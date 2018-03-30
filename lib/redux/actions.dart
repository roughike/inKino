import 'package:inkino/data/models/event.dart';
import 'package:inkino/data/models/show.dart';
import 'package:inkino/data/models/theater.dart';
import 'package:meta/meta.dart';

class InitAction {}

class InitCompleteAction {
  InitCompleteAction(
    this.theaters,
    this.selectedTheater,
  );

  final List<Theater> theaters;
  final Theater selectedTheater;
}

class ChangeCurrentTheaterAction {
  ChangeCurrentTheaterAction(this.selectedTheater);
  final Theater selectedTheater;
}

class ChangeCurrentDateAction {
  ChangeCurrentDateAction(this.date);
  final DateTime date;
}

class RefreshEventsAction {}

class ErrorLoadingShowsAction {}

class FetchShowsAction {
  FetchShowsAction(this.theater);
  final Theater theater;
}

class RequestingShowsAction {}

class RefreshShowsAction {}

class ReceivedShowsAction {
  ReceivedShowsAction(this.theater, this.shows);

  final Theater theater;
  final List<Show> shows;
}

class FetchEventsAction {
  FetchEventsAction(this.theater);
  final Theater theater;
}

class RequestingEventsAction {}

class ReceivedEventsAction {
  ReceivedEventsAction({
    @required this.nowInTheatersEvents,
    @required this.comingSoonEvents,
  });

  final List<Event> nowInTheatersEvents;
  final List<Event> comingSoonEvents;
}

class ErrorLoadingEventsAction {}

class SearchQueryChangedAction {
  SearchQueryChangedAction(this.query);
  final String query;
}