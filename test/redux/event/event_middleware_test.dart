import 'dart:async';

import 'package:inkino/models/event.dart';
import 'package:inkino/models/theater.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/event/event_actions.dart';
import 'package:inkino/redux/event/event_middleware.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  group('EventMiddleware', () {
    final Theater theater = Theater(id: 'test', name: 'Test Theater');
    final List<dynamic> actionLog = <dynamic>[];
    final Function(dynamic) next = (dynamic action) => actionLog.add(action);

    MockFinnkinoApi mockFinnkinoApi;
    EventMiddleware middleware;

    List<Event> nowInTheatersEvents = <Event>[
      Event(),
      Event(),
      Event(),
    ];

    List<Event> upcomingEvents = <Event>[
      Event(),
      Event(),
      Event(),
    ];

    setUp(() {
      mockFinnkinoApi = MockFinnkinoApi();
      middleware = EventMiddleware(mockFinnkinoApi);
    });

    tearDown(() {
      actionLog.clear();
    });

    test(
      'when called with InitCompleteAction, should dispatch a ReceivedEventsAction with now playing and upcoming events',
      () async {
        when(mockFinnkinoApi.getNowInTheatersEvents(any))
            .thenAnswer((_) => Future.value(nowInTheatersEvents));
        when(mockFinnkinoApi.getUpcomingEvents())
            .thenAnswer((_) => Future.value(upcomingEvents));

        await middleware.call(
            null, InitCompleteAction(null, theater), next);

        expect(actionLog.length, 3);
        expect(actionLog[0], const TypeMatcher<InitCompleteAction>());
        expect(actionLog[1], const TypeMatcher<RequestingEventsAction>());

        final ReceivedEventsAction action = actionLog[2];
        expect(action.nowInTheatersEvents, nowInTheatersEvents);
        expect(action.comingSoonEvents, upcomingEvents);
      },
    );

    test(
      'when called with ChangeCurrentTheaterAction, should request events for the theater',
      () async {
        when(mockFinnkinoApi.getNowInTheatersEvents(any))
            .thenAnswer((_) => Future.value(nowInTheatersEvents));
        when(mockFinnkinoApi.getUpcomingEvents())
            .thenAnswer((_) => Future.value(upcomingEvents));

        await middleware.call(
          null,
          ChangeCurrentTheaterAction(
            Theater(
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
            .thenAnswer((_) => Future.error(Error()));
        when(mockFinnkinoApi.getUpcomingEvents())
            .thenAnswer((_) => Future.error(Error()));

        await middleware.call(
            null, InitCompleteAction(null, theater), next);

        expect(actionLog.length, 3);
        expect(actionLog[0], const TypeMatcher<InitCompleteAction>());
        expect(actionLog[1], const TypeMatcher<RequestingEventsAction>());
        expect(actionLog[2], const TypeMatcher<ErrorLoadingEventsAction>());
      },
    );
  });
}
