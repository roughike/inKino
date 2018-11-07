import 'package:core/src/models/show.dart';
import 'package:core/src/models/show_cache.dart';
import 'package:core/src/models/theater.dart';

class UpdateShowDatesAction {}
class ShowDatesUpdatedAction {
  ShowDatesUpdatedAction(this.dates);
  final List<DateTime> dates;
}

class FetchShowsIfNotLoadedAction {}

class RequestingShowsAction {}
class RefreshShowsAction {}
class ReceivedShowsAction {
  ReceivedShowsAction(this.cacheKey, this.shows);
  final DateTheaterPair cacheKey;
  final List<Show> shows;
}

class ErrorLoadingShowsAction {}
class ChangeCurrentDateAction {
  ChangeCurrentDateAction(this.date);
  final DateTime date;
}