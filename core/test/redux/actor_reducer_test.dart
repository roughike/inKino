import 'package:core/src/models/actor.dart';
import 'package:core/src/redux/actor/actor_actions.dart';
import 'package:core/src/redux/app/app_reducer.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:test/test.dart';

void main() {
  group('AppReducer', () {
    test(
        'when called with ActorsUpdatedAction, should not modify existing actors',
        () {
      final state = AppState.initial().copyWith(
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

      final reducedState = appReducer(
        state,
        ActorsUpdatedAction([
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
      final state = AppState.initial().copyWith(
        actorsByName: <String, Actor>{
          'Seth Ladd': Actor(name: 'Seth Ladd', avatarUrl: null),
          'Eric Seidel': Actor(name: 'Eric Seidel', avatarUrl: null),
        },
      );

      final reducedState = appReducer(
        state,
        ReceivedActorAvatarsAction([
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
