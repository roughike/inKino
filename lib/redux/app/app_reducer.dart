import 'package:inkino/data/models/actor.dart';
import 'package:inkino/redux/app/app_actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/event/event_reducer.dart';
import 'package:inkino/redux/show/show_reducer.dart';
import 'package:inkino/redux/theater/theater_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    searchQuery: _searchQueryReducer(state.searchQuery, action),
    actorsByName: _actorReducer(state.actorsByName, action),
    theaterState: theaterReducer(state.theaterState, action),
    showState: showReducer(state.showState, action),
    eventState: eventReducer(state.eventState, action),
  );
}

String _searchQueryReducer(String searchQuery, action) {
  if (action is SearchQueryChangedAction) {
    return action.query;
  }

  return searchQuery;
}

Map<String, Actor> _actorReducer(Map<String, Actor> actorsByName, action) {
  if (action is ActorsUpdatedAction) {
    var actors = <String, Actor>{}..addAll(actorsByName);
    action.actors.forEach((actor) {
      actors.putIfAbsent(actor.name, () => new Actor(name: actor.name));
    });

    return actors;
  } else if (action is ReceivedActorAvatarsAction) {
    var actorsWithAvatars = <String, Actor>{}..addAll(actorsByName);
    action.actors.forEach((actor) {
      actorsWithAvatars[actor.name] = new Actor(
        name: actor.name,
        avatarUrl: actor.avatarUrl,
      );
    });

    return actorsWithAvatars;
  }

  return actorsByName;
}
