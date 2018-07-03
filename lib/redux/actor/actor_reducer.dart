import 'package:inkino/models/actor.dart';
import 'package:inkino/redux/actor/actor_actions.dart';
import 'package:redux/redux.dart';

final actorReducer = combineReducers<Map<String, Actor>>([
  TypedReducer<Map<String, Actor>, ActorsUpdatedAction>(_actorsUpdated),
  TypedReducer<Map<String, Actor>, ReceivedActorAvatarsAction>(
      _receivedAvatars),
]);

Map<String, Actor> _actorsUpdated(
    Map<String, Actor> actorsByName, dynamic action) {
  var actors = <String, Actor>{}..addAll(actorsByName);
  action.actors.forEach((Actor actor) {
    actors.putIfAbsent(actor.name, () => Actor(name: actor.name));
  });

  return actors;
}

Map<String, Actor> _receivedAvatars(
    Map<String, Actor> actorsByName, dynamic action) {
  var actorsWithAvatars = <String, Actor>{}..addAll(actorsByName);
  action.actors.forEach((Actor actor) {
    actorsWithAvatars[actor.name] = Actor(
      name: actor.name,
      avatarUrl: actor.avatarUrl,
    );
  });

  return actorsWithAvatars;
}
