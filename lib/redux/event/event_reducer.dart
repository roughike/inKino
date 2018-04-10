import 'package:inkino/data/loading_status.dart';
import 'package:inkino/data/models/event.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/event/event_actions.dart';
import 'package:inkino/redux/event/event_state.dart';
import 'package:redux/redux.dart';

final eventReducer = combineReducers<EventState>([
  new TypedReducer<EventState, RequestingEventsAction>(_requestingEvents),
  new TypedReducer<EventState, ReceivedEventsAction>(_receivedEvents),
  new TypedReducer<EventState, ErrorLoadingEventsAction>(_errorLoadingEvents),
  new TypedReducer<EventState, UpdateActorsForEventAction>(
      _updateActorsForEvent),
]);

EventState _requestingEvents(EventState state, RequestingEventsAction action) {
  return state.copyWith(loadingStatus: LoadingStatus.loading);
}

EventState _receivedEvents(EventState state, ReceivedEventsAction action) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    nowInTheatersEvents: action.nowInTheatersEvents,
    comingSoonEvents: action.comingSoonEvents,
  );
}

EventState _errorLoadingEvents(
    EventState state, ErrorLoadingEventsAction action) {
  return state.copyWith(loadingStatus: LoadingStatus.error);
}

EventState _updateActorsForEvent(
    EventState state, UpdateActorsForEventAction action) {
  var event = action.event;
  event.actors = action.actors;

  var inTheatersEvents = <Event>[]..addAll(state.nowInTheatersEvents);
  var comingSoonEvents = <Event>[]..addAll(state.comingSoonEvents);

  var inTheatersMatch = inTheatersEvents.indexWhere((e) => e.id == event.id);

  if (inTheatersMatch > -1) {
    inTheatersEvents[inTheatersMatch] = event;
  } else {
    var comingSoonMatch = comingSoonEvents.indexWhere((e) => e.id == event.id);

    if (comingSoonMatch > -1) {
      comingSoonEvents[comingSoonMatch] = event;
    }
  }

  return state.copyWith(
    nowInTheatersEvents: inTheatersEvents,
    comingSoonEvents: comingSoonEvents,
  );
}
