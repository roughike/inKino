import 'dart:async';

import 'package:inkino/data/event.dart';
import 'package:inkino/data/finnkino_api.dart';
import 'package:inkino/data/theater.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:redux/redux.dart';

class EventMiddleware extends MiddlewareClass<AppState> {
  EventMiddleware(this.api);
  final FinnkinoApi api;

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is InitCompleteAction || action is ChangeCurrentTheaterAction) {
      final Theater currentTheater = action.selectedTheater;
      await _fetchEvents(currentTheater, next);
    }
  }

  Future<Null> _fetchEvents(
    Theater newTheater,
    NextDispatcher next,
  ) async {
    next(new RequestingEventsAction());

    try {
      var inTheatersEvents = await api.getEvents(
        newTheater,
        EventListType.nowInTheaters,
      );

      var comingSoonEvents = await api.getEvents(
        newTheater,
        EventListType.comingSoon,
      );

      next(new ReceivedEventsAction(
        nowInTheatersEvents: Event.parseAll(inTheatersEvents),
        comingSoonEvents: Event.parseAll(comingSoonEvents),
      ));
    } catch (e) {
      next(new ErrorLoadingEventsAction());
    }
  }
}
