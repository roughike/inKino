import 'package:core/src/models/show.dart';
import 'package:core/src/models/show_cache.dart';
import 'package:kt_dart/collection.dart';

class UpdateShowDatesAction {}

class ShowDatesUpdatedAction {
  ShowDatesUpdatedAction(this.dates);
  final KtList<DateTime> dates;
}

class FetchShowsIfNotLoadedAction {}

class RequestingShowsAction {}

class RefreshShowsAction {}

class ReceivedShowsAction {
  ReceivedShowsAction(this.cacheKey, this.shows);
  final DateTheaterPair cacheKey;
  final KtList<Show> shows;
}

class ErrorLoadingShowsAction {}

class ChangeCurrentDateAction {
  ChangeCurrentDateAction(this.date);
  final DateTime date;
}
