import 'dart:async';

import 'package:inkino/data/file_cache.dart';
import 'package:inkino/data/finnkino_api.dart';
import 'package:inkino/data/show.dart';
import 'package:inkino/data/theater.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:redux/redux.dart';
import 'package:inkino/redux/selectors.dart';

class ShowMiddleware extends MiddlewareClass<AppState> {
  static const Duration kMaxStaleness = const Duration(minutes: 5);

  ShowMiddleware(this.api, this.cache);

  final FinnkinoApi api;
  final FileCache cache;

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
    var inMemoryCache = showsForTheaterSelector(store.state, newTheater);

    if (inMemoryCache.isNotEmpty) {
      next(new ReceivedShowsAction(newTheater, inMemoryCache));
    } else {
      var diskCache = await cache.read('shows_${newTheater.id}');

      if (diskCache.contentFreshEnough(kMaxStaleness)) {
        next(new ReceivedShowsAction(
          newTheater,
          Show.parseAll(diskCache.content),
        ));
      }

      return _fetchShows(store, newTheater, next);
    }
  }

  Future<Null> _fetchShows(
    Store<AppState> store,
    Theater newTheater,
    NextDispatcher next,
  ) async {
    next(new RequestingShowsAction());

    try {
      var shows = await api.getSchedule(newTheater);
      next(new ReceivedShowsAction(newTheater, Show.parseAll(shows)));
      await cache.persist('shows_${newTheater.id}', shows);
    } on Exception {
      print('Shows error');
    }
  }
}
