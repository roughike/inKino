import 'package:inkino/data/show.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/loading_status.dart';
import 'package:inkino/redux/show/show_state.dart';
import 'package:redux/redux.dart';

final showReducer = combineTypedReducers([
  new ReducerBinding<ShowState, ReceivedScheduleDatesAction>(_receivedDates),
  new ReducerBinding<ShowState, ChangeCurrentDateAction>(_changeDate),
  new ReducerBinding<ShowState, RequestingShowsAction>(_requestingShows),
  new ReducerBinding<ShowState, ReceivedShowsAction>(_receivedShows),
  new ReducerBinding<ShowState, ErrorLoadingShowsAction>(_errorLoadingShows),
]);

ShowState _receivedDates(ShowState state, ReceivedScheduleDatesAction action) {
  var selectedDate =
      action.dates.isNotEmpty ? action.dates.first : state.selectedDate;

  return state.copyWith(
    selectedDate: selectedDate,
    availableDates: action.dates,
  );
}

ShowState _changeDate(ShowState state, ChangeCurrentDateAction action) {
  return state.copyWith(selectedDate: action.date);
}

ShowState _requestingShows(ShowState state, RequestingShowsAction action) {
  return state.copyWith(loadingStatus: LoadingStatus.loading);
}

ShowState _receivedShows(ShowState state, ReceivedShowsAction action) {
  var showsById = <String, Show>{};
  action.shows.forEach((show) {
    showsById[show.id] = show;
  });

  var showIdsByTheaterId = <String, List<String>>{};
  showIdsByTheaterId.addAll(state.showIdsByTheaterId);
  showIdsByTheaterId[action.theater.id] = showsById.keys.toList();

  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    allShowsById: showsById,
    showIdsByTheaterId: showIdsByTheaterId,
  );
}

ShowState _errorLoadingShows(ShowState state, ErrorLoadingShowsAction action) {
  return state.copyWith(loadingStatus: LoadingStatus.error);
}
