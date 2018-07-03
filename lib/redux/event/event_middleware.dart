import 'dart:async';

import 'package:inkino/models/theater.dart';
import 'package:inkino/networking/finnkino_api.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/event/event_actions.dart';
import 'package:redux/redux.dart';

class EventMiddleware extends MiddlewareClass<AppState> {
  EventMiddleware(this.api);
  final FinnkinoApi api;

  @override
  Future<Null> call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    if (action is InitCompleteAction ||
        action is ChangeCurrentTheaterAction ||
        action is RefreshEventsAction) {
      var theater = _determineTheater(action, store);

      if (theater != null) {
        await _fetchEvents(theater, next);
      }
    }
  }

  Theater _determineTheater(dynamic action, Store<AppState> store) {
    if (action is RefreshEventsAction) {
      return store.state.theaterState.currentTheater;
    }

    return action.selectedTheater;
  }

  Future<Null> _fetchEvents(
    Theater newTheater,
    NextDispatcher next,
  ) async {
    next(RequestingEventsAction());

    try {
      var inTheatersEvents = await api.getNowInTheatersEvents(newTheater);
      var comingSoonEvents = await api.getUpcomingEvents();

      next(ReceivedEventsAction(
        nowInTheatersEvents: inTheatersEvents,
        comingSoonEvents: comingSoonEvents,
      ));
    } catch (e) {
      next(ErrorLoadingEventsAction());
    }
  }
}
