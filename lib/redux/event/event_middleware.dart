import 'dart:async';

import 'package:inkino/data/file_cache.dart';
import 'package:inkino/data/event.dart';
import 'package:inkino/data/finnkino_api.dart';
import 'package:inkino/data/theater.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:redux/redux.dart';
import 'package:inkino/redux/selectors.dart';

class EventMiddleware extends MiddlewareClass<AppState> {
  static const Duration kMaxStaleness = const Duration(minutes: 5);

  EventMiddleware(this.api, this.cache);

  final FinnkinoApi api;
  final FileCache cache;

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is InitCompleteAction || action is ChangeCurrentTheaterAction) {
      final Theater currentTheater = action.selectedTheater;
      await _refreshEventsForTheaterIfNeeded(store, currentTheater, next);
    }
  }

  Future<Null> _refreshEventsForTheaterIfNeeded(
    Store<AppState> store,
    Theater newTheater,
    NextDispatcher next,
  ) async {
    var inMemoryCache = eventsForTheaterSelector(store.state, newTheater);

    if (inMemoryCache.isNotEmpty) {
      next(new ReceivedEventsAction(newTheater, inMemoryCache));
    } else {
      var diskCache = await cache.read('events_${newTheater.id}');

      if (diskCache.contentFreshEnough(kMaxStaleness)) {
        next(new ReceivedEventsAction(
          newTheater,
          Event.parseAll(diskCache.content),
        ));
      } else {
        return _fetchEvents(store, newTheater, next);
      }
    }
  }

  Future<Null> _fetchEvents(
    Store<AppState> store,
    Theater newTheater,
    NextDispatcher next,
  ) async {
    next(new RequestingEventsAction());

    try {
      var events = await api.getEvents(newTheater);
      next(new ReceivedEventsAction(newTheater, Event.parseAll(events)));
      await cache.persist('events_${newTheater.id}', events);
    } on Exception {
      print('Event error');
    }
  }
}
