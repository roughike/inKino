import 'package:inkino/redux/app_state.dart';
import 'package:inkino/redux/theater_reducer.dart';
import 'package:inkino/redux/show_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    theaterState: theaterReducer(state.theaterState, action),
    shows: showReducer(state.shows, action),
  );
}