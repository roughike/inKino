import 'package:core/src/models/loading_status.dart';
import 'package:core/src/redux/_common/common_actions.dart';
import 'package:core/src/redux/show/show_actions.dart';
import 'package:core/src/redux/show/show_state.dart';

ShowState showReducer(ShowState state, dynamic action) {
  if (action is ChangeCurrentTheaterAction) {
    return state.copyWith(selectedDate: state.dates.first());
  } else if (action is ChangeCurrentDateAction) {
    return state.copyWith(selectedDate: action.date);
  } else if (action is RequestingShowsAction) {
    return state.copyWith(loadingStatus: LoadingStatus.loading);
  } else if (action is ReceivedShowsAction) {
    final newShows = state.shows.toMutableMap();
    newShows[action.cacheKey] = action.shows;

    return state.copyWith(
      loadingStatus: LoadingStatus.success,
      shows: newShows,
    );
  } else if (action is ErrorLoadingShowsAction) {
    return state.copyWith(loadingStatus: LoadingStatus.error);
  } else if (action is ShowDatesUpdatedAction) {
    return state.copyWith(
      availableDates: action.dates,
      selectedDate: action.dates.first(),
    );
  }

  return state;
}
