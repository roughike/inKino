import 'package:core/src/models/actor.dart';
import 'package:core/src/redux/actor/actor_actions.dart';

Map<String, Actor> actorReducer(Map<String, Actor> state, dynamic action) {
  if (action is ActorsUpdatedAction) {
    return _updateActors(state, action);
  } else if (action is ReceivedActorAvatarsAction) {
    return _updateActorAvatars(state, action);
  }

  return state;
}

Map<String, Actor> _updateActors(Map<String, Actor> state, dynamic action) {
  final actors = <String, Actor>{}..addAll(state);
  action.actors.forEach((Actor actor) {
    actors.putIfAbsent(actor.name, () => Actor(name: actor.name));
  });

  return actors;
}

Map<String, Actor> _updateActorAvatars(
    Map<String, Actor> state, dynamic action) {
  final actorsWithAvatars = <String, Actor>{}..addAll(state);
  action.actors.forEach((Actor actor) {
    actorsWithAvatars[actor.name] = Actor(
      name: actor.name,
      avatarUrl: actor.avatarUrl,
    );
  });

  return actorsWithAvatars;
}
