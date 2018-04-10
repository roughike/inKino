import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/data/loading_status.dart';
import 'package:inkino/redux/show/show_actions.dart';
import 'package:inkino/redux/show/show_state.dart';
import 'package:redux/redux.dart';

final showReducer = combineReducers<ShowState>([
  new TypedReducer<ShowState, ChangeCurrentTheaterAction>(_changeTheater),
  new TypedReducer<ShowState, ChangeCurrentDateAction>(_changeDate),
  new TypedReducer<ShowState, RequestingShowsAction>(_requestingShows),
  new TypedReducer<ShowState, ReceivedShowsAction>(_receivedShows),
  new TypedReducer<ShowState, ErrorLoadingShowsAction>(_errorLoadingShows),
]);

ShowState _changeTheater(ShowState state, _) {
  return state.copyWith(selectedDate: state.dates.first);
}

ShowState _changeDate(ShowState state, ChangeCurrentDateAction action) {
  return state.copyWith(selectedDate: action.date);
}

ShowState _requestingShows(ShowState state, RequestingShowsAction action) {
  return state.copyWith(loadingStatus: LoadingStatus.loading);
}

ShowState _receivedShows(ShowState state, ReceivedShowsAction action) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    shows: action.shows,
  );
}

ShowState _errorLoadingShows(ShowState state, ErrorLoadingShowsAction action) {
  return state.copyWith(loadingStatus: LoadingStatus.error);
}
