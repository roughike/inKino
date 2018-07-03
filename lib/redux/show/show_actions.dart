import 'package:inkino/models/show.dart';
import 'package:inkino/models/theater.dart';

class UpdateShowDatesAction {}

class ShowDatesUpdatedAction {
  ShowDatesUpdatedAction(this.dates);
  final List<DateTime> dates;
}

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
