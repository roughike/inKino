import 'dart:async';

import 'package:inkino/models/theater.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/theater/theater_middleware.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  group('TheaterMiddleware', () {
    final List<dynamic> log = <dynamic>[];
    final Function(dynamic) next = (dynamic action) => log.add(action);

    MockAssetBundle mockAssetBundle;
    MockPreferences mockPreferences;
    TheaterMiddleware middleware;

    setUp(() {
      mockAssetBundle = MockAssetBundle();
      mockPreferences = MockPreferences();
      middleware = TheaterMiddleware(mockAssetBundle, mockPreferences);
    });

    tearDown(() {
      log.clear();
    });

    group('called with InitAction', () {
      test('loads the preloaded theaters', () async {
        // Given
        when(mockAssetBundle.loadString(any))
            .thenAnswer((_) => theatersXml());

        // When
        await middleware.call(null, InitAction(), next);

        // Then
        final InitCompleteAction action = log.single;
        expect(action.theaters.length, 3);
      });

      test('when a persisted theater id exists, uses that as a default',
          () async {
        when(mockAssetBundle.loadString(any))
            .thenAnswer((_) => theatersXml());
        when(mockPreferences.getString(TheaterMiddleware.kDefaultTheaterId))
            .thenReturn('001');

        await middleware.call(null, InitAction(), next);

        final InitCompleteAction action = log.single;
        Theater theater = action.selectedTheater;
        expect(theater.id, '001');
        expect(theater.name, 'Gotham: Theater One');
      });

      test(
        'when no persisted theater id, uses the first theater as a default',
        () async {
          when(mockAssetBundle.loadString(any))
              .thenAnswer((_) => theatersXml());
          when(mockPreferences.getString(TheaterMiddleware.kDefaultTheaterId))
              .thenReturn(null);

          await middleware.call(null, InitAction(), next);

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
        var theater = Theater(id: 'test-123', name: 'Test Theater');
        await middleware.call(
            null, ChangeCurrentTheaterAction(theater), next);

        verify(mockPreferences.setString(
            TheaterMiddleware.kDefaultTheaterId, 'test-123'));

        final ChangeCurrentTheaterAction action = log.single;
        expect(action.selectedTheater, theater);
      },
    );
  });
}

Future<String> theatersXml() => Future.value('''<?xml version="1.0"?>
<TheatreAreas xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <TheatreArea>
        <ID>1029</ID>
        <Name>Valitse alue/teatteri</Name>
    </TheatreArea>
    <TheatreArea>
        <ID>001</ID>
        <Name>Gotham: THEATER ONE</Name>
    </TheatreArea>
    <TheatreArea>
        <ID>002</ID>
        <Name>Gotham: THEATER TWO</Name>
    </TheatreArea>
</TheatreAreas>''');
