import 'package:inkino/data/show.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/show_state.dart';
import 'package:redux/redux.dart';

final showReducer = combineTypedReducers([
  new ReducerBinding<ShowState, ReceivedShowsAction>(_receivedShows),
]);

ShowState _receivedShows(ShowState state, ReceivedShowsAction action) {
  var showsById = <String, Show>{};
  action.shows.forEach((show) {
    showsById[show.id] = show;
  });

  var showIdsByTheaterId = <String, List<String>>{};
  showIdsByTheaterId.addAll(state.showIdsByTheaterId);
  showIdsByTheaterId[action.theater.id] = showsById.keys.toList();

  return state.copyWith(
    showsById: showsById,
    showIdsByTheaterId: showIdsByTheaterId,
  );
}
