import 'dart:async';

import 'package:inkino/data/file_cache.dart';
import 'package:inkino/data/finnkino_api.dart';
import 'package:inkino/data/schedule_date.dart';
import 'package:inkino/data/show.dart';
import 'package:inkino/data/theater.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:redux/redux.dart';
import 'package:inkino/redux/selectors.dart';

class ShowMiddleware extends MiddlewareClass<AppState> {
  ShowMiddleware(this.api);
  final FinnkinoApi api;

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is InitCompleteAction || action is ChangeCurrentTheaterAction) {
      final Theater currentTheater = action.selectedTheater;

      try {
        await _fetchScheduleDates(currentTheater, next);
        await _fetchShows(currentTheater, null, next);
      } catch (e) {
        next(new ErrorLoadingShowsAction());
      }
    } else if (action is ChangeCurrentDateAction) {
      await _fetchShows(store.state.theaterState.currentTheater, action.date, next);
    }
  }

  Future<Null> _fetchScheduleDates(
    Theater currentTheater,
    NextDispatcher next,
  ) async {
    var dates = await api.getScheduleDates(currentTheater);
    next(new ReceivedScheduleDatesAction(ScheduleDate.parseAll(dates)));
  }

  Future<Null> _fetchShows(
    Theater newTheater,
    ScheduleDate currentDate,
    NextDispatcher next,
  ) async {
    next(new RequestingShowsAction());
    var shows = await api.getSchedule(newTheater, currentDate);
    next(new ReceivedShowsAction(newTheater, Show.parseAll(shows)));
  }
}
