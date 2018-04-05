import 'dart:async';
import 'dart:io';

import 'package:inkino/data/models/theater.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/theater/theater_middleware.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  group('TheaterMiddleware', () {
    final List<dynamic> log = <dynamic>[];
    final Function(dynamic) next = (action) => log.add(action);

    MockAssetBundle mockAssetBundle;
    MockPreferences mockPreferences;
    TheaterMiddleware sut;

    Future<String> _theaterXml() =>
        new File('test_assets/theaters.xml').readAsString();

    setUp(() {
      mockAssetBundle = new MockAssetBundle();
      mockPreferences = new MockPreferences();
      sut = new TheaterMiddleware(mockAssetBundle, mockPreferences);
    });

    tearDown(() {
      log.clear();
    });

    group('called with InitAction', () {
      test('loads the preloaded theaters', () async {
        // Given
        when(mockAssetBundle.loadString(any)).thenReturn(_theaterXml());

        // When
        await sut.call(null, new InitAction(), next);

        // Then
        final InitCompleteAction action = log.single;
        expect(action.theaters.length, 3);
      });

      test('when a persisted theater id exists, uses that as a default',
          () async {
        when(mockAssetBundle.loadString(any)).thenReturn(_theaterXml());
        when(mockPreferences.getString(TheaterMiddleware.kDefaultTheaterId))
            .thenReturn('001');

        await sut.call(null, new InitAction(), next);

        final InitCompleteAction action = log.single;
        Theater theater = action.selectedTheater;
        expect(theater.id, '001');
        expect(theater.name, 'Gotham: Theater One');
      });

      test(
        'when no persisted theater id, uses the first theater as a default',
        () async {
          when(mockAssetBundle.loadString(any)).thenReturn(_theaterXml());
          when(mockPreferences.getString(TheaterMiddleware.kDefaultTheaterId))
              .thenReturn(null);

          await sut.call(null, new InitAction(), next);

          final InitCompleteAction action = log.single;
          Theater theater = action.selectedTheater;
          expect(theater.id, '1029');
          expect(theater.name, 'All theaters');
        },
      );
    });

    test(
      'when called with ChangeCurrentTheaterAction, persists and dispatches the same action',
      () async {
        var theater = new Theater(id: 'test-123', name: 'Test Theater');
        await sut.call(null, new ChangeCurrentTheaterAction(theater), next);

        verify(mockPreferences.setString(
            TheaterMiddleware.kDefaultTheaterId, 'test-123'));

        final ChangeCurrentTheaterAction action = log.single;
        expect(action.selectedTheater, theater);
      },
    );
  });
}
