import 'package:inkino/data/models/show.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/show/show_state.dart';
import 'package:inkino/redux/theater/theater_state.dart';

AppState appState({
  TheaterState theaters,
  ShowState shows,
}) {
  return new AppState.initial().copyWith(
    theaterState: theaters,
    showState: shows,
  );
}

AppState showState({
  List<Show> shows,
}) {
  return appState().copyWith(
    showState: appState().showState.copyWith(shows: shows),
  );
}
