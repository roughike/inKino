import 'dart:async';
import 'dart:io';

import 'package:inkino/data/finnkino_api.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/show/show_middleware.dart';
import 'package:inkino/redux/theater/theater_middleware.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.dart';


void main() {
  group('ShowMiddleware', () {
    final log = <dynamic>[];
    final next = (action) => log.add(action);

    final theaters = <MockTheater>[
      new MockTheater(),
      new MockTheater(),
    ];

    final shows = <MockShow>[
      new MockShow(),
      new MockShow(),
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

    test('when called with InitCompleteAction, fetches the shows for the current theater', () async {
      var currentTheater = theaters.first;
      var action = new InitCompleteAction(theaters, theaters.first);

      when(mockStore.state).thenReturn(new AppState.initial());
      when(mockApi.getSchedule(currentTheater)).thenReturn(shows);

      await sut.call(mockStore, action, next);

      expect(log[0], new isInstanceOf<InitCompleteAction>());
      expect(log[1], new isInstanceOf<RequestingShowsAction>());

      final ReceivedShowsAction receivedShows = log[2];
      expect(receivedShows.theater, theaters.first);
      expect(receivedShows.shows, shows);
    });
  });
}
