import 'dart:async';

import 'package:inkino/data/finnkino_api.dart';
import 'package:inkino/data/show.dart';
import 'package:inkino/data/theater.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:redux/redux.dart';

class ShowMiddleware extends MiddlewareClass<AppState> {
  ShowMiddleware(this.api);
  final FinnkinoApi api;

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is InitCompleteAction ||
        action is ChangeCurrentTheaterAction ||
        action is RefreshShowsAction ||
        action is ChangeCurrentDateAction) {
      _handleShowsUpdate(store, action, next);
    }
  }

  Future<Null> _handleShowsUpdate(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    Theater theater = store.state.theaterState.currentTheater;
    DateTime date;

    if (action is InitCompleteAction ||
        action is ChangeCurrentTheaterAction) {
      theater = action.selectedTheater;
    } else if (action is ChangeCurrentDateAction) {
      date = action.date;
    }

    await _fetchShows(theater, date, next);
  }

  Future<Null> _fetchShows(
    Theater newTheater,
    DateTime currentDate,
    NextDispatcher next,
  ) async {
    next(new RequestingShowsAction());

    try {
      var shows = await api.getSchedule(newTheater, currentDate);
      next(new ReceivedShowsAction(newTheater, Show.parseAll(shows)));
    } catch (e) {
      print(e);
      next(new ErrorLoadingShowsAction());
    }
  }
}
