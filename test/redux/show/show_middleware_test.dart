import 'dart:io';

import 'package:inkino/data/models/theater.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/show/show_middleware.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

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

    /*
    TODO: Fix
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

      // When
      await sut.call(mockStore, action, next);

      // Then
      expect(log[0], new isInstanceOf<InitCompleteAction>());
      expect(log[1], new isInstanceOf<RequestingShowsAction>());

      final ReceivedShowsAction receivedShows = log[2];
      expect(receivedShows.theater, theaters.first);
      expect(receivedShows.shows.length, 3);
    });*/
  });
}
