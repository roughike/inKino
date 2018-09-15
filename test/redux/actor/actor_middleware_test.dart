import 'dart:async';

import 'package:inkino/models/actor.dart';
import 'package:inkino/models/event.dart';
import 'package:inkino/networking/tmdb_api.dart';
import 'package:inkino/redux/actor/actor_actions.dart';
import 'package:inkino/redux/actor/actor_middleware.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockTMDBApi extends Mock implements TMDBApi {}

void main() {
  group('AppMiddleware', () {
    final Event event = Event(
      id: 'test',
      actors: <Actor>[
        Actor(name: 'Seth Ladd'),
        Actor(name: 'Eric Seidel'),
      ],
    );

    final List<Actor> actorsWithAvatars = <Actor>[
      Actor(
        name: 'Seth Ladd',
        avatarUrl: 'https://seths-profile-picture',
      ),
      Actor(
        name: 'Eric Seidel',
        avatarUrl: 'https://erics-profile-picture',
      ),
    ];

    final List<dynamic> actionLog = <dynamic>[];
    final Function(dynamic) next = (dynamic action) => actionLog.add(action);

    MockTMDBApi mockTMDBApi;
    ActorMiddleware middleware;

    setUp(() {
      mockTMDBApi = MockTMDBApi();
      middleware = ActorMiddleware(mockTMDBApi);
    });

    tearDown(() {
      actionLog.clear();
    });

    test('FetchActorAvatarsAction - successful API request', () async {
      when(mockTMDBApi.findAvatarsForActors(any, any))
          .thenAnswer((_) => Future.value(actorsWithAvatars));
      await middleware.call(null, FetchActorAvatarsAction(event), next);

      expect(actionLog.length, 4);
      expect(actionLog[0], const TypeMatcher<FetchActorAvatarsAction>());

      ActorsUpdatedAction actorsUpdated = actionLog[1];
      expect(actorsUpdated.actors, event.actors);

      UpdateActorsForEventAction updateActorsForEvent = actionLog[2];
      expect(updateActorsForEvent.event, event);
      expect(updateActorsForEvent.actors, actorsWithAvatars);

      ReceivedActorAvatarsAction receivedActorAvatars = actionLog[3];
      expect(receivedActorAvatars.actors, actorsWithAvatars);
    });

    test('FetchActorAvatarsAction - handles errors silently', () async {
      when(mockTMDBApi.findAvatarsForActors(any, any))
          .thenAnswer((_) => Future.error(Error()));

      await middleware.call(null, FetchActorAvatarsAction(event), next);
    });
  });
}
