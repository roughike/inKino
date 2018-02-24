import 'dart:async';

import 'package:inkino/data/finnkino_api.dart';
import 'package:inkino/data/theater.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:redux/redux.dart';
import 'package:inkino/redux/selectors.dart';

class EventMiddleware extends MiddlewareClass<AppState> {
  EventMiddleware(this.api);
  final FinnkinoApi api;

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
    // TODO: persist the shows and actually include the time when the shows were last loaded.
    var cachedEvents = eventsForTheaterSelector(store.state, newTheater);

    if (cachedEvents.isNotEmpty) {
      next(new ReceivedEventsAction(newTheater, cachedEvents));
    } else {
      return _fetchEvents(store, newTheater, next);
    }
  }

  Future<Null> _fetchEvents(
    Store<AppState> store,
    Theater newTheater,
    NextDispatcher next,
  ) async {
    next(new RequestingEventsAction());
    var events = await api.getEvents(newTheater);
    next(new ReceivedEventsAction(newTheater, events));
  }
}
