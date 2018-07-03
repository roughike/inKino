import 'dart:async';

import 'package:inkino/models/show.dart';
import 'package:inkino/models/theater.dart';
import 'package:inkino/networking/finnkino_api.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/show/show_actions.dart';
import 'package:inkino/utils/clock.dart';
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

    if (action is InitCompleteAction ||
        action is ChangeCurrentTheaterAction ||
        action is RefreshShowsAction ||
        action is ChangeCurrentDateAction) {
      await _handleShowsUpdate(store, action, next);
    }
  }

  void _updateShowDates(dynamic action, NextDispatcher next) {
    var now = Clock.getCurrentTime();
    var dates = List.generate(7, (index) => now.add(Duration(days: index)));

    next(new ShowDatesUpdatedAction(dates));
  }

  Future<Null> _handleShowsUpdate(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    Theater theater = store.state.theaterState.currentTheater;
    DateTime date;

    if (action is InitCompleteAction || action is ChangeCurrentTheaterAction) {
      theater = action.selectedTheater;
    } else if (action is ChangeCurrentDateAction) {
      date = action.date;
    }

    next(RequestingShowsAction());

    try {
      var shows = await _fetchShows(theater, date, next);
      next(ReceivedShowsAction(theater, shows));
    } catch (e) {
      next(ErrorLoadingShowsAction());
    }
  }

  Future<List<Show>> _fetchShows(
    Theater newTheater,
    DateTime currentDate,
    NextDispatcher next,
  ) async {
    var shows = await api.getSchedule(newTheater, currentDate);
    var now = Clock.getCurrentTime();

    // Return only show times that haven't started yet.
    var relevantShows = shows.where((show) {
      return show.start.isAfter(now);
    }).toList();

    return relevantShows;
  }
}
