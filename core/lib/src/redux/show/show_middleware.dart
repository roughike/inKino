import 'dart:async';

import 'package:core/src/models/loading_status.dart';
import 'package:core/src/models/show.dart';
import 'package:core/src/models/show_cache.dart';
import 'package:core/src/models/theater.dart';
import 'package:core/src/networking/finnkino_api.dart';
import 'package:core/src/redux/_common/common_actions.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:core/src/redux/show/show_actions.dart';
import 'package:core/src/utils/clock.dart';
import 'package:kt_dart/collection.dart';
import 'package:redux/redux.dart';

class ShowMiddleware extends MiddlewareClass<AppState> {
  ShowMiddleware(this.api);

  final FinnkinoApi api;

  @override
  Future<Null> call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    if (action is InitCompleteAction || action is UpdateShowDatesAction) {
      await _updateShowDates(action, next);
    }

    if (action is ChangeCurrentTheaterAction ||
        action is RefreshShowsAction ||
        action is ChangeCurrentDateAction) {
      await _updateCurrentShows(store, action, next);
    }

    if (action is FetchShowsIfNotLoadedAction) {
      if (store.state.showState.loadingStatus == LoadingStatus.idle) {
        await _updateCurrentShows(store, action, next);
      }
    }
  }

  void _updateShowDates(dynamic action, NextDispatcher next) {
    final now = Clock.getCurrentTime();
    var dates =
        listFrom(List.generate(7, (index) => now.add(Duration(days: index))));

    next(new ShowDatesUpdatedAction(dates));
  }

  Future<void> _updateCurrentShows(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(RequestingShowsAction());

    try {
      final theater = _getCorrectTheater(store, action);
      final date = _getCorrectDate(store, action);
      final cacheKey = DateTheaterPair(date, theater);

      var shows = store.state.showState.shows[cacheKey];

      if (shows == null) {
        shows = await _fetchShows(date, theater, next);
      }

      next(ReceivedShowsAction(DateTheaterPair(date, theater), shows));
    } catch (e) {
      next(ErrorLoadingShowsAction());
    }
  }

  Future<KtList<Show>> _fetchShows(
      DateTime currentDate, Theater newTheater, NextDispatcher next) async {
    final shows = await api.getSchedule(newTheater, currentDate);
    final now = Clock.getCurrentTime();

    // Return only show times that haven't started yet.
    return shows.filter((show) => show.start.isAfter(now));
  }

  Theater _getCorrectTheater(Store<AppState> store, dynamic action) {
    return action is InitCompleteAction || action is ChangeCurrentTheaterAction
        ? action.selectedTheater
        : store.state.theaterState.currentTheater;
  }

  DateTime _getCorrectDate(Store<AppState> store, dynamic action) {
    return action is ChangeCurrentDateAction
        ? action.date
        : store.state.showState.selectedDate;
  }
}
