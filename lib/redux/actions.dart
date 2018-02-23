import 'package:inkino/data/show.dart';
import 'package:inkino/data/theater.dart';

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

class FetchShowsAction {
  FetchShowsAction(this.theater);
  final Theater theater;
}

class RequestingShowsAction {}

class ReceivedShowsAction {
  ReceivedShowsAction(this.theater, this.shows);

  final Theater theater;
  final List<Show> shows;
}
