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
  final actors = state.toMutableMap();
  action.actors.forEach((actor) {
    actors.putIfAbsent(actor.name, Actor(name: actor.name));
  });
  return actors.toMap();
}

KtMap<String, Actor> _updateActorAvatars(
    KtMap<String, Actor> state, ReceivedActorAvatarsAction action) {
  final actorsWithAvatars = state.toMutableMap();
  action.actors.forEach((actor) {
    actorsWithAvatars[actor.name] = Actor(
      name: actor.name,
      avatarUrl: actor.avatarUrl,
    );
  });

  return actorsWithAvatars.toMap();
}
