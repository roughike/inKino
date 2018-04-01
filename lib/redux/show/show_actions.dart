import 'package:inkino/data/models/show.dart';
import 'package:inkino/data/models/theater.dart';

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

class ErrorLoadingShowsAction {}

class ChangeCurrentDateAction {
  ChangeCurrentDateAction(this.date);
  final DateTime date;
}
