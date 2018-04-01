import 'dart:async';

import 'package:inkino/data/models/event.dart';
import 'package:inkino/data/models/theater.dart';
import 'package:inkino/data/networking/finnkino_api.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/event/event_actions.dart';
import 'package:redux/redux.dart';

class EventMiddleware extends MiddlewareClass<AppState> {
  EventMiddleware(this.api);
  final FinnkinoApi api;

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is InitCompleteAction ||
        action is ChangeCurrentTheaterAction ||
        action is RefreshEventsAction) {
      Theater theater;

      if (action is RefreshEventsAction) {
        theater = store.state.theaterState.currentTheater;
      } else {
        theater = action.selectedTheater;
      }

      if (theater != null) {
        await _fetchEvents(theater, next);
      }
    }
  }

  Future<Null> _fetchEvents(
    Theater newTheater,
    NextDispatcher next,
  ) async {
    next(new RequestingEventsAction());

    try {
      var inTheatersEvents = await api.getNowInTheatersEvents(newTheater);
      var comingSoonEvents = await api.getUpcomingEvents();

      next(new ReceivedEventsAction(
        nowInTheatersEvents: Event.parseAll(inTheatersEvents),
        comingSoonEvents: Event.parseAll(comingSoonEvents),
      ));
    } catch (e) {
      next(new ErrorLoadingEventsAction());
    }
  }
}
