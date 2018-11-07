import 'package:core/src/redux/_common/common_actions.dart';
import 'package:core/src/redux/theater/theater_state.dart';

TheaterState theaterReducer(TheaterState state, dynamic action) {
  if (action is InitCompleteAction) {
    return state.copyWith(
        currentTheater: action.selectedTheater, theaters: action.theaters);
  } else if (action is ChangeCurrentTheaterAction) {
    return state.copyWith(currentTheater: action.selectedTheater);
  }

  return state;
}