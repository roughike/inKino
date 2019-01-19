import 'dart:async';

import 'package:core/src/models/event.dart';
import 'package:core/src/models/loading_status.dart';
import 'package:core/src/models/theater.dart';
import 'package:core/src/redux/_common/common_actions.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:core/src/redux/event/event_actions.dart';
import 'package:core/src/redux/event/event_middleware.dart';
import 'package:core/src/redux/event/event_state.dart';
import 'package:core/src/redux/theater/theater_state.dart';
import 'package:kt_dart/kt.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks.dart';

void main() {
  group('EventMiddleware', () {
    final Theater theater = Theater(id: 'test', name: 'Test Theater');
    final actionLog = <dynamic>[];
    final next = (dynamic action) => actionLog.add(action);

    MockFinnkinoApi mockFinnkinoApi;
    EventMiddleware middleware;
    MockStore mockStore;

    final nowInTheatersEvents = listOf(
      Event(),
      Event(),
      Event(),
    );

    final upcomingEvents = listOf(
      Event(),
      Event(),
      Event(),
    );

    setUp(() {
      mockFinnkinoApi = MockFinnkinoApi();
      middleware = EventMiddleware(mockFinnkinoApi);
      mockStore = MockStore();

      when(mockStore.state).thenReturn(
        AppState.initial().copyWith(
          theaterState: TheaterState.initial().copyWith(
            currentTheater: Theater(id: 'test', name: 'Test Theater'),
          ),
        ),
      );
    });

    tearDown(() {
      actionLog.clear();
    });

    test(
      'when called with InitCompleteAction, should dispatch a ReceivedEventsAction with now playing events',
      () async {
        when(mockFinnkinoApi.getNowInTheatersEvents(any))
            .thenAnswer((_) => Future.value(nowInTheatersEvents));
        when(mockFinnkinoApi.getUpcomingEvents())
            .thenAnswer((_) => Future.value(upcomingEvents));

        await middleware.call(
            mockStore, InitCompleteAction(null, theater), next);

        expect(actionLog.length, 3);
        expect(actionLog[0], const TypeMatcher<InitCompleteAction>());
        expect(actionLog[1], const TypeMatcher<RequestingEventsAction>());

        final ReceivedInTheatersEventsAction action = actionLog[2];
        expect(action.events, nowInTheatersEvents);
      },
    );

    test('fetch only now in theaters events', () async {
      when(mockFinnkinoApi.getNowInTheatersEvents(any))
          .thenAnswer((_) => Future.value(nowInTheatersEvents));

      await middleware.call(
          mockStore, RefreshEventsAction(EventListType.nowInTheaters), next);

      expect(actionLog.length, 3);

      final RefreshEventsAction refreshAction = actionLog[0];
      final RequestingEventsAction requestingAction = actionLog[1];
      final ReceivedInTheatersEventsAction action = actionLog[2];

      expect(refreshAction.type, EventListType.nowInTheaters);
      expect(requestingAction.type, EventListType.nowInTheaters);
      expect(action.events, nowInTheatersEvents);
    });

    test('fetch only upcoming events', () async {
      when(mockFinnkinoApi.getUpcomingEvents())
          .thenAnswer((_) => Future.value(upcomingEvents));

      await middleware.call(
          mockStore, RefreshEventsAction(EventListType.comingSoon), next);

      expect(actionLog.length, 3);

      final RefreshEventsAction refreshAction = actionLog[0];
      final RequestingEventsAction requestingAction = actionLog[1];
      final ReceivedComingSoonEventsAction action = actionLog[2];

      expect(refreshAction.type, EventListType.comingSoon);
      expect(requestingAction.type, EventListType.comingSoon);
      expect(action.events, upcomingEvents);
    });

    test('fetch upcoming events if not loaded', () async {
      when(mockFinnkinoApi.getUpcomingEvents())
          .thenAnswer((_) => Future.value(upcomingEvents));
      when(mockStore.state).thenReturn(
        AppState.initial().copyWith(
          eventState: EventState.initial().copyWith(
            comingSoonStatus: LoadingStatus.idle,
          ),
        ),
      );

      await middleware.call(
          mockStore, FetchComingSoonEventsIfNotLoadedAction(), next);

      expect(actionLog.length, 3);
      expect(actionLog[0],
          const TypeMatcher<FetchComingSoonEventsIfNotLoadedAction>());

      final RequestingEventsAction requestingAction = actionLog[1];
      final ReceivedComingSoonEventsAction action = actionLog[2];

      expect(requestingAction.type, EventListType.comingSoon);
      expect(action.events, upcomingEvents);
    });

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

        verify(mockFinnkinoApi.getUpcomingEvents());
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
            mockStore, InitCompleteAction(null, theater), next);

        expect(actionLog.length, 3);
        expect(actionLog[0], const TypeMatcher<InitCompleteAction>());
        expect(actionLog[1], const TypeMatcher<RequestingEventsAction>());
        expect(actionLog[2], const TypeMatcher<ErrorLoadingEventsAction>());
      },
    );
  });
}
