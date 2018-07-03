import 'package:inkino/models/actor.dart';
import 'package:inkino/redux/actor/actor_actions.dart';
import 'package:inkino/redux/app/app_reducer.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:test/test.dart';

void main() {
  group('AppReducer', () {
    test(
        'when called with ActorsUpdatedAction, should not modify existing actors',
        () {
      var state = AppState.initial().copyWith(
        actorsByName: <String, Actor>{
          'Seth Ladd': Actor(
            name: 'Seth Ladd',
            avatarUrl: 'https://seths-avatar-url',
          ),
          'Eric Seidel': Actor(
            name: 'Eric Seidel',
            avatarUrl: 'https://erics-avatar-url',
          ),
        },
      );

      var reducedState = appReducer(
        state,
        ActorsUpdatedAction(<Actor>[
          Actor(name: 'Seth Ladd', avatarUrl: null),
          Actor(name: 'Eric Seidel', avatarUrl: null),
          Actor(name: 'Ian Hickson', avatarUrl: null),
        ]),
      );

      expect(
        reducedState.actorsByName,
        <String, Actor>{
          'Seth Ladd': Actor(
            name: 'Seth Ladd',
            avatarUrl: 'https://seths-avatar-url',
          ),
          'Eric Seidel': Actor(
            name: 'Eric Seidel',
            avatarUrl: 'https://erics-avatar-url',
          ),
          'Ian Hickson': Actor(
            name: 'Ian Hickson',
            avatarUrl: null,
          ),
        },
      );
    });

    test(
        'when called with ReceivedActorAvatarsAction, should add urls for actors',
        () {
      var state = AppState.initial().copyWith(
        actorsByName: <String, Actor>{
          'Seth Ladd': Actor(name: 'Seth Ladd', avatarUrl: null),
          'Eric Seidel': Actor(name: 'Eric Seidel', avatarUrl: null),
        },
      );

      var reducedState = appReducer(
        state,
        ReceivedActorAvatarsAction(<Actor>[
          Actor(name: 'Seth Ladd', avatarUrl: 'https://seths-avatar-url'),
          Actor(name: 'Eric Seidel', avatarUrl: 'https://erics-avatar-url'),
        ]),
      );

      expect(
        reducedState.actorsByName,
        <String, Actor>{
          'Seth Ladd': Actor(
            name: 'Seth Ladd',
            avatarUrl: 'https://seths-avatar-url',
          ),
          'Eric Seidel': Actor(
            name: 'Eric Seidel',
            avatarUrl: 'https://erics-avatar-url',
          ),
        },
      );
    });
  });
}
