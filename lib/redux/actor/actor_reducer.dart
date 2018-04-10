import 'package:inkino/data/models/actor.dart';
import 'package:inkino/redux/actor/actor_actions.dart';
import 'package:redux/redux.dart';

final actorReducer = combineReducers<Map<String, Actor>>([
  new TypedReducer<Map<String, Actor>, ActorsUpdatedAction>(_actorsUpdated),
  new TypedReducer<Map<String, Actor>, ReceivedActorAvatarsAction>(_receivedAvatars),
]);

Map<String, Actor> _actorsUpdated(Map<String, Actor> actorsByName, action) {
  var actors = <String, Actor>{}..addAll(actorsByName);
  action.actors.forEach((actor) {
    actors.putIfAbsent(actor.name, () => new Actor(name: actor.name));
  });

  return actors;
}

Map<String, Actor> _receivedAvatars(Map<String, Actor> actorsByName, action) {
  var actorsWithAvatars = <String, Actor>{}..addAll(actorsByName);
  action.actors.forEach((actor) {
    actorsWithAvatars[actor.name] = new Actor(
      name: actor.name,
      avatarUrl: actor.avatarUrl,
    );
  });

  return actorsWithAvatars;
}
