import 'package:inkino/models/event.dart';
import 'package:inkino/models/loading_status.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/event/event_actions.dart';
import 'package:inkino/redux/event/event_state.dart';
import 'package:redux/redux.dart';

final eventReducer = combineReducers<EventState>([
  TypedReducer<EventState, RequestingEventsAction>(_requestingEvents),
  TypedReducer<EventState, ReceivedEventsAction>(_receivedEvents),
  TypedReducer<EventState, ErrorLoadingEventsAction>(_errorLoadingEvents),
  TypedReducer<EventState, UpdateActorsForEventAction>(_updateActorsForEvent),
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

  return state.copyWith(
    nowInTheatersEvents: _replaceEventIfFound(state.nowInTheatersEvents, event),
    comingSoonEvents: _replaceEventIfFound(state.comingSoonEvents, event),
  );
}

List<Event> _replaceEventIfFound(
  List<Event> originalEvents,
  Event replacement,
) {
  var newEvents = <Event>[]..addAll(originalEvents);
  var positionToReplace = originalEvents.indexWhere((candidate) {
    return candidate.id == replacement.id;
  });

  if (positionToReplace > -1) {
    newEvents[positionToReplace] = replacement;
  }

  return newEvents;
}
