import 'dart:async';

import 'package:core/src/models/theater.dart';
import 'package:core/src/redux/_common/common_actions.dart';
import 'package:core/src/redux/theater/theater_middleware.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks.dart';

void main() {
  group('TheaterMiddleware', () {
    final log = <dynamic>[];
    final next = (dynamic action) => log.add(action);

    MockKeyValueStore mockKeyValueStore;
    TheaterMiddleware middleware;

    setUp(() {
      mockKeyValueStore = MockKeyValueStore();
      middleware = TheaterMiddleware(mockKeyValueStore);
    });

    tearDown(() {
      log.clear();
    });

    group('called with InitAction', () {
      test('loads the preloaded theaters', () async {
        // When
        await middleware.call(null, InitAction(), next);

        // Then
        final InitCompleteAction action = log.single;
        expect(action.theaters.size, 21);
      });

      test('when a persisted theater id exists, uses that as a default',
          () async {
        when(mockKeyValueStore.getString(TheaterMiddleware.kDefaultTheaterId))
            .thenReturn('1012');

        await middleware.call(null, InitAction(), next);

        final InitCompleteAction action = log.single;
        Theater theater = action.selectedTheater;
        expect(theater.id, '1012');
        expect(theater.name, 'Espoo');
      });

      test(
        'when no persisted theater id, defaults to Helsinki',
        () async {
          when(mockKeyValueStore.getString(TheaterMiddleware.kDefaultTheaterId))
              .thenReturn(null);

          await middleware.call(null, InitAction(), next);

          final InitCompleteAction action = log.single;
          Theater theater = action.selectedTheater;
          expect(theater.id, '1033');
          expect(theater.name, 'Helsinki: Tennispalatsi');
        },
      );
    });

    test(
      'when called with ChangeCurrentTheaterAction, persists and dispatches the same action',
      () async {
        final theater = Theater(id: 'test-123', name: 'Test Theater');
        await middleware.call(null, ChangeCurrentTheaterAction(theater), next);

        verify(mockKeyValueStore.setString(
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
