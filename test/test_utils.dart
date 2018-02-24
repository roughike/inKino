import 'package:inkino/data/show.dart';
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
  Map<String, Show> allShowsById,
  Map<String, List<String>> showIdsByTheaterId,
}) {
  return appState().copyWith(
    showState: appState().showState.copyWith(
          allShowsById: allShowsById,
          showIdsByTheaterId: showIdsByTheaterId,
        ),
  );
}
