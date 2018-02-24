import 'dart:async';

import 'package:inkino/data/finnkino_api.dart';
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
      await _refreshShowsForTheaterIfNeeded(store, currentTheater, next);
    }
  }

  Future<Null> _refreshShowsForTheaterIfNeeded(
    Store<AppState> store,
    Theater newTheater,
    NextDispatcher next,
  ) async {
    // TODO: persist the shows and actually include the time when the shows were last loaded.
    var cachedShows = showsForTheaterSelector(store.state, newTheater);

    if (cachedShows.isNotEmpty) {
      next(new ReceivedShowsAction(newTheater, cachedShows));
    } else {
      return _fetchShows(store, newTheater, next);
    }
  }

  Future<Null> _fetchShows(
    Store<AppState> store,
    Theater newTheater,
    NextDispatcher next,
  ) async {
    next(new RequestingShowsAction());
    var shows = await api.getSchedule(newTheater);
    next(new ReceivedShowsAction(newTheater, shows));
  }
}
