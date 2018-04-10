import 'package:inkino/data/models/actor.dart';
import 'package:inkino/redux/actor/actor_actions.dart';
import 'package:inkino/redux/app/app_reducer.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:test/test.dart';

void main() {
  group('AppReducer', () {
    test(
        'when called with ActorsUpdatedAction, should not modify existing actors',
        () {
      var state = new AppState.initial().copyWith(
        actorsByName: <String, Actor>{
          'Seth Ladd': new Actor(
            name: 'Seth Ladd',
            avatarUrl: 'https://seths-avatar-url',
          ),
          'Eric Seidel': new Actor(
            name: 'Eric Seidel',
            avatarUrl: 'https://erics-avatar-url',
          ),
        },
      );

      var reducedState = appReducer(
        state,
        new ActorsUpdatedAction(<Actor>[
          new Actor(name: 'Seth Ladd', avatarUrl: null),
          new Actor(name: 'Eric Seidel', avatarUrl: null),
          new Actor(name: 'Ian Hickson', avatarUrl: null),
        ]),
      );

      expect(
        reducedState.actorsByName,
        <String, Actor>{
          'Seth Ladd': new Actor(
            name: 'Seth Ladd',
            avatarUrl: 'https://seths-avatar-url',
          ),
          'Eric Seidel': new Actor(
            name: 'Eric Seidel',
            avatarUrl: 'https://erics-avatar-url',
          ),
          'Ian Hickson': new Actor(
            name: 'Ian Hickson',
            avatarUrl: null,
          ),
        },
      );
    });

    test(
        'when called with ReceivedActorAvatarsAction, should add urls for actors',
        () {
      var state = new AppState.initial().copyWith(
        actorsByName: <String, Actor>{
          'Seth Ladd': new Actor(name: 'Seth Ladd', avatarUrl: null),
          'Eric Seidel': new Actor(name: 'Eric Seidel', avatarUrl: null),
        },
      );

      var reducedState = appReducer(
        state,
        new ReceivedActorAvatarsAction(<Actor>[
          new Actor(name: 'Seth Ladd', avatarUrl: 'https://seths-avatar-url'),
          new Actor(name: 'Eric Seidel', avatarUrl: 'https://erics-avatar-url'),
        ]),
      );

      expect(
        reducedState.actorsByName,
        <String, Actor>{
          'Seth Ladd': new Actor(
            name: 'Seth Ladd',
            avatarUrl: 'https://seths-avatar-url',
          ),
          'Eric Seidel': new Actor(
            name: 'Eric Seidel',
            avatarUrl: 'https://erics-avatar-url',
          ),
        },
      );
    });
  });
}
