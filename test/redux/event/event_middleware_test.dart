import 'dart:async';
import 'dart:io';

import 'package:inkino/data/models/theater.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/event/event_actions.dart';
import 'package:inkino/redux/event/event_middleware.dart';
import 'package:test/test.dart';

import '../../mocks.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('EventMiddleware', () {
    final Theater theater = new Theater(id: 'test', name: 'Test Theater');
    final List<dynamic> actionLog = <dynamic>[];
    final Function(dynamic) next = (action) => actionLog.add(action);

    MockFinnkinoApi mockFinnkinoApi;
    EventMiddleware sut;

    Future<String> _nowInTheatersEventsXml() =>
        new File('test_assets/now_in_theaters_events.xml').readAsString();

    Future<String> _upcomingEventsXml() =>
        new File('test_assets/upcoming_events.xml').readAsString();

    setUp(() {
      mockFinnkinoApi = new MockFinnkinoApi();
      sut = new EventMiddleware(mockFinnkinoApi);
    });

    tearDown(() {
      actionLog.clear();
    });

    test(
      'when called with InitCompleteAction, should dispatch a ReceivedEventsAction with now playing and upcoming events',
      () async {
        when(mockFinnkinoApi.getNowInTheatersEvents(any))
            .thenReturn(_nowInTheatersEventsXml());
        when(mockFinnkinoApi.getUpcomingEvents())
            .thenReturn(_upcomingEventsXml());

        await sut.call(null, new InitCompleteAction(null, theater), next);

        expect(actionLog.length, 3);
        expect(actionLog[0], new isInstanceOf<InitCompleteAction>());
        expect(actionLog[1], new isInstanceOf<RequestingEventsAction>());

        final ReceivedEventsAction action = actionLog[2];
        expect(action.nowInTheatersEvents.length, 3);
        expect(action.comingSoonEvents.length, 4);
      },
    );

    test(
      'when called with ChangeCurrentTheaterAction, should request events for the new theater',
      () async {
        when(mockFinnkinoApi.getNowInTheatersEvents(any))
            .thenReturn(_nowInTheatersEventsXml());
        when(mockFinnkinoApi.getUpcomingEvents())
            .thenReturn(_upcomingEventsXml());

        await sut.call(
          null,
          new ChangeCurrentTheaterAction(
            new Theater(
              id: 'changed',
              name: 'A newly selected theater',
            ),
          ),
          next,
        );

        Theater captured =
            verify(mockFinnkinoApi.getNowInTheatersEvents(captureAny))
                .captured
                .first;
        expect(captured.id, 'changed');
        expect(captured.name, 'A newly selected theater');
      },
    );

    test(
      'when InitCompleteAction results in an error, should dispatch an ErrorLoadingEventsAction',
      () async {
        when(mockFinnkinoApi.getNowInTheatersEvents(any))
            .thenReturn(new Error());
        when(mockFinnkinoApi.getUpcomingEvents()).thenReturn(new Error());

        await sut.call(null, new InitCompleteAction(null, theater), next);

        expect(actionLog.length, 3);
        expect(actionLog[0], new isInstanceOf<InitCompleteAction>());
        expect(actionLog[1], new isInstanceOf<RequestingEventsAction>());
        expect(actionLog[2], new isInstanceOf<ErrorLoadingEventsAction>());
      },
    );
  });
}
