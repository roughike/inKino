import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/theater/theater_reducer.dart';
import 'package:inkino/redux/show/show_reducer.dart';
import 'package:inkino/redux/event/event_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    searchQuery: _searchQueryReducer(state.searchQuery, action),
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