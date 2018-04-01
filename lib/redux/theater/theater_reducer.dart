import 'package:inkino/redux/common_actions.dart';
import 'package:redux/redux.dart';
import 'package:inkino/redux/theater/theater_state.dart';

final theaterReducer = combineTypedReducers<TheaterState>([
  new ReducerBinding<TheaterState, InitCompleteAction>(_initComplete),
  new ReducerBinding<TheaterState, ChangeCurrentTheaterAction>(
      _currentTheaterChanged),
]);

TheaterState _initComplete(TheaterState state, InitCompleteAction action) {
  return state.copyWith(
    currentTheater: action.selectedTheater,
    theaters: action.theaters,
  );
}

TheaterState _currentTheaterChanged(
    TheaterState state, ChangeCurrentTheaterAction action) {
  return state.copyWith(currentTheater: action.selectedTheater);
}
