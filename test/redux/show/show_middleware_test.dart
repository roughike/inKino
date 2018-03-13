import 'dart:async';
import 'dart:io';

import 'package:inkino/data/file_cache.dart';
import 'package:inkino/data/finnkino_api.dart';
import 'package:inkino/data/theater.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/show/show_middleware.dart';
import 'package:inkino/redux/theater/theater_middleware.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.dart';
import '../../test_utils.dart';

void main() {
  group('ShowMiddleware', () {
    final log = <dynamic>[];
    final next = (action) => log.add(action);

    final theaters = <Theater>[
      new Theater(id: 'first', name: 'Test theater #1'),
      new Theater(
        id: 'second',
        name: 'Test theater #2',
      ),
    ];

    MockStore mockStore;
    MockFinnkinoApi mockApi;
    ShowMiddleware sut;

    setUp(() {
      mockStore = new MockStore();
      mockApi = new MockFinnkinoApi();
      sut = new ShowMiddleware(mockApi);

      log.clear();
    });

    test(
        'when called with InitCompleteAction, fetches the shows for the current theater',
        () async {
      // Given
      var currentTheater = theaters.first;
      var action = new InitCompleteAction(theaters, theaters.first);

      when(mockStore.state).thenReturn(new AppState.initial());
      when(mockApi.getSchedule(currentTheater, null)).thenReturn(
        new File('test_assets/schedule.xml').readAsStringSync(),
      );
      when(mockApi.getScheduleDates(currentTheater)).thenReturn(
        new File('test_assets/schedule_dates.xml').readAsStringSync(),
      );

      // When
      await sut.call(mockStore, action, next);

      // Then
      expect(log[0], new isInstanceOf<InitCompleteAction>());
      expect(log[1], new isInstanceOf<ReceivedScheduleDatesAction>());
      expect(log[2], new isInstanceOf<RequestingShowsAction>());

      final ReceivedShowsAction receivedShows = log[3];
      expect(receivedShows.theater, theaters.first);
      expect(receivedShows.shows.length, 3);
    });
  });
}
