import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/theater/theater_reducer.dart';
import 'package:inkino/redux/show/show_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    theaterState: theaterReducer(state.theaterState, action),
    showState: showReducer(state.showState, action),
  );
}