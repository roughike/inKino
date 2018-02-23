import 'dart:async';

import 'package:inkino/data/finnkino_api.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:redux/redux.dart';
import 'package:inkino/redux/selectors.dart';

class ApiMiddleware extends MiddlewareClass<AppState> {
  ApiMiddleware(this.api);
  final FinnkinoApi api;

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is ChangeCurrentTheaterAction) {
      await _refreshShowsForTheaterIfNeeded(store, action, next);
    }
  }

  Future<Null> _refreshShowsForTheaterIfNeeded(
    Store<AppState> store,
    ChangeCurrentTheaterAction action,
    NextDispatcher next,
  ) async {
    var shows = showsForTheaterSelector(store.state, action.newTheater);

    if (shows.isNotEmpty) {
      next(new ReceivedShowsAction(action.newTheater, shows));
    } else {
      return _fetchShows(store, action, next);
    }
  }

  Future<Null> _fetchShows(
    Store<AppState> store,
    ChangeCurrentTheaterAction action,
    NextDispatcher next,
  ) async {
    next(new RequestingShowsAction());
    var shows = await api.getSchedule(action.newTheater);
    next(new ReceivedShowsAction(action.newTheater, shows));
  }
}
