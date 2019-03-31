import 'package:core/src/models/actor.dart';
import 'package:core/src/redux/actor/actor_actions.dart';
import 'package:kt_dart/collection.dart';

KtMap<String, Actor> actorReducer(KtMap<String, Actor> state, dynamic action) {
  if (action is ActorsUpdatedAction) {
    return _updateActors(state, action);
  } else if (action is ReceivedActorAvatarsAction) {
    return _updateActorAvatars(state, action);
  }

  return state;
}

KtMap<String, Actor> _updateActors(
    KtMap<String, Actor> state, ActorsUpdatedAction action) {
  final updated = action.actors.associateBy((it) => it.name);
  return updated.plus(state);
}

KtMap<String, Actor> _updateActorAvatars(
    KtMap<String, Actor> state, ReceivedActorAvatarsAction action) {
  final actors = state.toMutableMap();
  for (final actor in action.actors.iter) {
    final current = actors[actor.name];
    if (current == null) {
      continue;
    }
    actors.put(actor.name, actor);
  }
  return actors.toMap();
}
