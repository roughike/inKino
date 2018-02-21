import 'package:inkino/data/show.dart';
import 'package:inkino/redux/app_state.dart';
import 'package:inkino/data/theater.dart';

Theater currentTheaterSelector(AppState state) =>
    state.theaterState.currentTheater;

List<Theater> theatersSelector(AppState state) => state.theaterState.theaters;

List<Show> showsForTheaterSelector(AppState state, Theater theater) {
  var shows = <Show>[];
  var allShows = state.shows.showsById;
  var showIdsForTheater =
      theater != null ? state.shows.showIdsByTheaterId[theater.id] : [];

  showIdsForTheater?.forEach((id) {
    shows.add(allShows[id]);
  });

  return shows;
}
