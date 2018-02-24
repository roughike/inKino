import 'package:inkino/data/event.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/event/event_state.dart';
import 'package:redux/redux.dart';

final eventReducer = combineTypedReducers([
  new ReducerBinding<EventState, ReceivedEventsAction>(_receivedEvents),
]);

EventState _receivedEvents(EventState state, ReceivedEventsAction action) {
  var eventsById = <String, Event>{};
  action.events.forEach((event) {
    eventsById[event.id] = event;
  });

  var eventIdsByTheaterId = <String, List<String>>{};
  eventIdsByTheaterId.addAll(state.eventIdsByTheaterId);
  eventIdsByTheaterId[action.theater.id] = eventsById.keys.toList();

  return state.copyWith(
    allEventsById: eventsById,
    eventIdsByTheaterId: eventIdsByTheaterId,
  );
}
