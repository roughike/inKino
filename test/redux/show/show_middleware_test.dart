import 'dart:async';

import 'package:inkino/models/show.dart';
import 'package:inkino/models/theater.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/show/show_actions.dart';
import 'package:inkino/redux/show/show_middleware.dart';
import 'package:inkino/redux/theater/theater_state.dart';
import 'package:inkino/utils/clock.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  group('ShowMiddleware', () {
    final DateTime startOf2018 = DateTime(2018);
    final Theater theater = Theater(id: 'abc123', name: 'Test Theater');
    final List<dynamic> actionLog = <dynamic>[];
    final Function(dynamic) next = (dynamic action) => actionLog.add(action);

    MockFinnkinoApi mockFinnkinoApi;
    MockStore mockStore;
    ShowMiddleware middleware;

    AppState _theaterState({Theater currentTheater}) {
      return AppState.initial().copyWith(
            theaterState: TheaterState.initial().copyWith(
                  currentTheater: currentTheater,
                ),
          );
    }

    setUp(() {
      mockFinnkinoApi = MockFinnkinoApi();
      mockStore = MockStore();
      middleware = ShowMiddleware(mockFinnkinoApi);

      // Given
      when(mockStore.state).thenReturn(_theaterState(currentTheater: theater));
    });

    tearDown(() {
      actionLog.clear();
      Clock.resetDateTimeGetter();
    });

    test(
      'when called with InitCompleteAction, should dispatch a ReceivedShowsAction with all shows',
      () async {
        // The middleware filters shows based on if the showtime has already
        // passed. As DateTime(2018) will mean the very first hour and minute
        // in January, all the show times in test assets will be after this date.
        Clock.getCurrentTime = () => startOf2018;
        when(mockFinnkinoApi.getSchedule(theater, any))
            .thenAnswer((_) => Future.value(<Show>[
                  Show(start: DateTime(2018, 02, 21)),
                  Show(start: DateTime(2018, 02, 21)),
                  Show(start: DateTime(2018, 03, 21)),
                ]));

        // When
        await middleware.call(
            mockStore, InitCompleteAction(null, theater), next);

        // Then
        verify(mockFinnkinoApi.getSchedule(theater, null));

        expect(actionLog.length, 4);
        expect(actionLog[0], const TypeMatcher<InitCompleteAction>());
        expect(actionLog[1], const TypeMatcher<ShowDatesUpdatedAction>());
        expect(actionLog[2], const TypeMatcher<RequestingShowsAction>());

        final ReceivedShowsAction receivedShowsAction = actionLog[3];
        expect(receivedShowsAction.shows.length, 3);
      },
    );

    test(
      'when called with ChangeCurrentDateAction, should dispatch a ReceivedShowsAction with only relevant shows',
      () async {
        // Given
        Clock.getCurrentTime = () => DateTime(2018, 3);
        when(mockFinnkinoApi.getSchedule(theater, any))
            .thenAnswer((_) => Future.value(
                  <Show>[
                    Show(start: DateTime(2018, 02, 21)),
                    Show(start: DateTime(2018, 02, 21)),
                    Show(start: DateTime(2018, 03, 21)),
                  ],
                ));

        // When
        await middleware.call(
            mockStore, ChangeCurrentDateAction(startOf2018), next);

        // Then
        verify(mockFinnkinoApi.getSchedule(theater, startOf2018));

        expect(actionLog.length, 3);
        expect(actionLog[0], const TypeMatcher<ChangeCurrentDateAction>());
        expect(actionLog[1], const TypeMatcher<RequestingShowsAction>());

        final ReceivedShowsAction receivedShowsAction = actionLog[2];
        expect(receivedShowsAction.shows.length, 1);
      },
    );

    test(
      'when InitCompleteAction results in an error, should dispatch an ErrorLoadingShowsAction',
      () async {
        // Given
        when(mockFinnkinoApi.getSchedule(any, any))
            .thenAnswer((_) => Future.error(Error()));

        // When
        await middleware.call(
            mockStore, InitCompleteAction(null, theater), next);

        // Then
        expect(actionLog.length, 4);
        expect(actionLog[0], const TypeMatcher<InitCompleteAction>());
        expect(actionLog[1], const TypeMatcher<ShowDatesUpdatedAction>());
        expect(actionLog[2], const TypeMatcher<RequestingShowsAction>());
        expect(actionLog[3], const TypeMatcher<ErrorLoadingShowsAction>());
      },
    );

    test(
      'when called with UpdateShowDatesAction',
      () async {
        Clock.getCurrentTime = () => DateTime(2018, 1, 1);

        await middleware.call(mockStore, UpdateShowDatesAction(), next);

        expect(actionLog.length, 2);
        expect(actionLog[0], const TypeMatcher<UpdateShowDatesAction>());
        expect(actionLog[1], const TypeMatcher<ShowDatesUpdatedAction>());

        ShowDatesUpdatedAction action = actionLog[1];
        expect(
          action.dates,
          <DateTime>[
            DateTime(2018, 1, 1),
            DateTime(2018, 1, 2),
            DateTime(2018, 1, 3),
            DateTime(2018, 1, 4),
            DateTime(2018, 1, 5),
            DateTime(2018, 1, 6),
            DateTime(2018, 1, 7),
          ],
        );
      },
    );
  });
}
