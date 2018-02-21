import 'package:inkino/data/show.dart';
import 'package:inkino/data/theater.dart';

class InitAction {}

class InitCompleteAction {
  InitCompleteAction(this.theaters);
  final List<Theater> theaters;
}

class ChangeCurrentTheaterAction {
  ChangeCurrentTheaterAction(this.newTheater);
  final Theater newTheater;
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