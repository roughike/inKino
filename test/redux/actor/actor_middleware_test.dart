import 'dart:async';

import 'package:inkino/data/models/actor.dart';
import 'package:inkino/data/models/event.dart';
import 'package:inkino/data/networking/tmdb_api.dart';
import 'package:inkino/redux/actor/actor_actions.dart';
import 'package:inkino/redux/actor/actor_middleware.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockTMDBApi extends Mock implements TMDBApi {}

void main() {
  group('AppMiddleware', () {
    final Event event = new Event(
      id: 'test',
      actors: <Actor>[
        new Actor(name: 'Seth Ladd'),
        new Actor(name: 'Eric Seidel'),
      ],
    );

    final List<Actor> actorsWithAvatars = <Actor>[
      new Actor(
        name: 'Seth Ladd',
        avatarUrl: 'https://seths-profile-picture',
      ),
      new Actor(
        name: 'Eric Seidel',
        avatarUrl: 'https://erics-profile-picture',
      ),
    ];

    final List<dynamic> actionLog = <dynamic>[];
    final Function(dynamic) next = (action) => actionLog.add(action);

    MockTMDBApi mockTMDBApi;
    ActorMiddleware middleware;

    setUp(() {
      mockTMDBApi = new MockTMDBApi();
      middleware = new ActorMiddleware(mockTMDBApi);
    });

    tearDown(() {
      actionLog.clear();
    });

    test('FetchActorAvatarsAction - successful API request', () async {
      when(mockTMDBApi.findAvatarsForActors(typed(any), typed(any)))
          .thenAnswer((_) => new Future.value(actorsWithAvatars));
      await middleware.call(null, new FetchActorAvatarsAction(event), next);

      expect(actionLog.length, 4);
      expect(actionLog[0], new isInstanceOf<FetchActorAvatarsAction>());

      ActorsUpdatedAction actorsUpdated = actionLog[1];
      expect(actorsUpdated.actors, event.actors);

      UpdateActorsForEventAction updateActorsForEvent = actionLog[2];
      expect(updateActorsForEvent.event, event);
      expect(updateActorsForEvent.actors, actorsWithAvatars);

      ReceivedActorAvatarsAction receivedActorAvatars = actionLog[3];
      expect(receivedActorAvatars.actors, actorsWithAvatars);
    });

    test('FetchActorAvatarsAction - handles errors silently', () async {
      when(mockTMDBApi.findAvatarsForActors(typed(any), typed(any)))
          .thenAnswer((_) => new Future.value(new Error()));

      await middleware.call(null, new FetchActorAvatarsAction(event), next);
    });
  });
}
