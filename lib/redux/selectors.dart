import 'package:inkino/data/show.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/data/theater.dart';

Theater currentTheaterSelector(AppState state) =>
    state.theaterState.currentTheater;

List<Theater> theatersSelector(AppState state) => state.theaterState.theaters;

List<Show> showsForTheaterSelector(AppState state, Theater theater) {
  var shows = <Show>[];
  var allShows = state.showState.allShowsById;
  var showIdsForTheater =
      theater != null ? state.showState.showIdsByTheaterId[theater.id] : [];

  showIdsForTheater?.forEach((id) {
    var show = allShows[id];

    if (show != null) {
      shows.add(show);
    }
  });

  return shows;
}
