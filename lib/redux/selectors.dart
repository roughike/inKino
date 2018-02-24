import 'package:inkino/data/event.dart';
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

List<Event> eventsForTheaterSelector(AppState state, Theater theater) {
  var events = <Event>[];
  var allEvents = state.eventState.allEventsById;
  var eventIdsForTheater =
      theater != null ? state.eventState.eventIdsByTheaterId[theater.id] : [];

  eventIdsForTheater?.forEach((id) {
    var event = allEvents[id];

    if (event != null) {
      events.add(event);
    }
  });

  return events;
}
