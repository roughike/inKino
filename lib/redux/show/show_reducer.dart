import 'package:inkino/models/loading_status.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/show/show_actions.dart';
import 'package:inkino/redux/show/show_state.dart';
import 'package:redux/redux.dart';

final showReducer = combineReducers<ShowState>([
  TypedReducer<ShowState, ChangeCurrentTheaterAction>(_changeTheater),
  TypedReducer<ShowState, ChangeCurrentDateAction>(_changeDate),
  TypedReducer<ShowState, RequestingShowsAction>(_requestingShows),
  TypedReducer<ShowState, ReceivedShowsAction>(_receivedShows),
  TypedReducer<ShowState, ErrorLoadingShowsAction>(_errorLoadingShows),
  TypedReducer<ShowState, ShowDatesUpdatedAction>(_showDatesUpdated),
]);

ShowState _changeTheater(ShowState state, dynamic _) {
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

ShowState _showDatesUpdated(ShowState state, ShowDatesUpdatedAction action) {
  return state.copyWith(
    availableDates: action.dates,
    selectedDate: action.dates.first,
  );
}
