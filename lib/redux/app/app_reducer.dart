import 'package:inkino/redux/actor/actor_reducer.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/event/event_reducer.dart';
import 'package:inkino/redux/search/search_reducer.dart';
import 'package:inkino/redux/show/show_reducer.dart';
import 'package:inkino/redux/theater/theater_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    searchQuery: searchQueryReducer(state.searchQuery, action),
    actorsByName: actorReducer(state.actorsByName, action),
    theaterState: theaterReducer(state.theaterState, action),
    showState: showReducer(state.showState, action),
    eventState: eventReducer(state.eventState, action),
  );
}
