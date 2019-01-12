import 'dart:async';

import 'package:core/src/models/show.dart';
import 'package:core/src/models/show_cache.dart';
import 'package:core/src/models/theater.dart';
import 'package:core/src/redux/_common/common_actions.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:core/src/redux/show/show_actions.dart';
import 'package:core/src/redux/show/show_middleware.dart';
import 'package:core/src/redux/show/show_state.dart';
import 'package:core/src/redux/theater/theater_state.dart';
import 'package:core/src/utils/clock.dart';
import 'package:kt_dart/collection.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks.dart';

void main() {
  group('ShowMiddleware', () {
    final DateTime startOf2018 = DateTime(2018);
    final Theater theater = Theater(id: 'abc123', name: 'Test Theater');
    final actionLog = <dynamic>[];
    final showCache = mutableMapFrom<DateTheaterPair, KtList<Show>>();
    final Function(dynamic) next = (dynamic action) {
      if (action is ReceivedShowsAction) {
        showCache[action.cacheKey] = action.shows;
      }

      actionLog.add(action);
    };

    MockFinnkinoApi mockFinnkinoApi;
    MockStore mockStore;
    ShowMiddleware middleware;

    AppState _stateBoilerplate({Theater currentTheater}) {
      return AppState.initial().copyWith(
        theaterState: TheaterState.initial().copyWith(
          currentTheater: currentTheater,
        ),
        showState: ShowState.initial().copyWith(
          selectedDate: startOf2018,
          shows: showCache,
        ),
      );
    }

    Future<Null> changeDate(DateTime newDate) {
      return middleware.call(mockStore, ChangeCurrentDateAction(newDate), next);
    }

    Future<Null> changeTheater(Theater newTheater) {
      return middleware.call(
          mockStore, ChangeCurrentTheaterAction(newTheater), next);
    }

    setUp(() {
      mockFinnkinoApi = MockFinnkinoApi();
      mockStore = MockStore();
      middleware = ShowMiddleware(mockFinnkinoApi);

      when(mockStore.state)
          .thenReturn(_stateBoilerplate(currentTheater: theater));
    });

    tearDown(() {
      actionLog.clear();
      showCache.clear();
      Clock.resetDateTimeGetter();
    });

    test(
      'when called with InitCompleteAction, should update show dates',
      () async {
        // The middleware filters shows based on if the showtime has already
        // passed. As DateTime(2018) will mean the very first hour and minute
        // in January, all the show times in test assets will be after this date.
        Clock.getCurrentTime = () => startOf2018;

        await middleware.call(
            mockStore, InitCompleteAction(null, theater), next);

        expect(actionLog.length, 2);
        expect(actionLog[0], const TypeMatcher<InitCompleteAction>());
        expect(actionLog[1], const TypeMatcher<ShowDatesUpdatedAction>());
      },
    );

    test(
      'when called with FetchShowsIfNotLoadedAction, should fetch shows',
      () async {
        Clock.getCurrentTime = () => startOf2018;
        when(mockFinnkinoApi.getSchedule(theater, any))
            .thenAnswer((_) => Future.value(listOf(
                  Show(start: DateTime(2018, 02, 21)),
                  Show(start: DateTime(2018, 02, 21)),
                  Show(start: DateTime(2018, 03, 21)),
                )));

        await middleware.call(mockStore, FetchShowsIfNotLoadedAction(), next);

        verify(mockFinnkinoApi.getSchedule(theater, startOf2018));

        expect(actionLog.length, 3);
        expect(actionLog[0], const TypeMatcher<FetchShowsIfNotLoadedAction>());
        expect(actionLog[1], const TypeMatcher<RequestingShowsAction>());

        final ReceivedShowsAction receivedShowsAction = actionLog[2];
        expect(receivedShowsAction.shows.size, 3);

        final showCacheKey = showCache.keys.first();
        expect(showCacheKey.theater, theater);
        expect(showCacheKey.dateTime, startOf2018);
      },
    );

    test(
      'when called with ChangeCurrentDateAction, should dispatch a ReceivedShowsAction with only relevant shows',
      () async {
        // Given
        Clock.getCurrentTime = () => DateTime(2018, 3);
        when(mockFinnkinoApi.getSchedule(theater, any))
            .thenAnswer((_) => Future.value(
                  listOf(
                    Show(start: DateTime(2018, 02, 21)),
                    Show(start: DateTime(2018, 02, 21)),
                    Show(start: DateTime(2018, 03, 21)),
                  ),
                ));

        // When
        await changeDate(startOf2018);

        // Then
        verify(mockFinnkinoApi.getSchedule(theater, startOf2018));

        expect(actionLog.length, 3);
        expect(actionLog[0], const TypeMatcher<ChangeCurrentDateAction>());
        expect(actionLog[1], const TypeMatcher<RequestingShowsAction>());

        final ReceivedShowsAction receivedShowsAction = actionLog[2];
        expect(receivedShowsAction.shows.size, 1);
      },
    );

    test(
      'when FetchShowsIfNotLoadedAction results in an error, should dispatch an ErrorLoadingShowsAction',
      () async {
        // Given
        when(mockFinnkinoApi.getSchedule(any, any))
            .thenAnswer((_) => Future.error(Error()));

        // When
        await middleware.call(mockStore, FetchShowsIfNotLoadedAction(), next);

        // Then
        expect(actionLog.length, 3);
        expect(actionLog[0], const TypeMatcher<FetchShowsIfNotLoadedAction>());
        expect(actionLog[1], const TypeMatcher<RequestingShowsAction>());
        expect(actionLog[2], const TypeMatcher<ErrorLoadingShowsAction>());
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
          listOf(
            DateTime(2018, 1, 1),
            DateTime(2018, 1, 2),
            DateTime(2018, 1, 3),
            DateTime(2018, 1, 4),
            DateTime(2018, 1, 5),
            DateTime(2018, 1, 6),
            DateTime(2018, 1, 7),
          ),
        );
      },
    );

    test(
      'should only fetch shows for specific date and theater once',
      () async {
        Clock.getCurrentTime = () => DateTime(2017, 1, 1);

        when(mockStore.state).thenReturn(_stateBoilerplate());
        when(mockFinnkinoApi.getSchedule(any, any))
            .thenAnswer((_) => Future.value(emptyList()));

        final firstDate = DateTime(2018);
        final secondDate = DateTime(2019);

        await changeDate(firstDate);
        await changeDate(secondDate);
        await changeDate(firstDate);
        await changeDate(secondDate);

        verify(mockFinnkinoApi.getSchedule(any, firstDate)).called(1);
        verify(mockFinnkinoApi.getSchedule(any, secondDate)).called(1);

        final firstTheater = Theater(id: 'first', name: 'First theater');
        final secondTheater = Theater(id: 'second', name: 'Second theater');

        await changeTheater(firstTheater);
        await changeTheater(secondTheater);
        await changeTheater(firstTheater);
        await changeTheater(secondTheater);

        verify(mockFinnkinoApi.getSchedule(firstTheater, any)).called(1);
        verify(mockFinnkinoApi.getSchedule(secondTheater, any)).called(1);

        verifyNoMoreInteractions(mockFinnkinoApi);
      },
    );
  });
}
