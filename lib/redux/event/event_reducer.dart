import 'package:inkino/data/event.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/event/event_state.dart';
import 'package:redux/redux.dart';

final eventReducer = combineTypedReducers([
  new ReducerBinding<EventState, ReceivedEventsAction>(_receivedEvents),
]);

EventState _receivedEvents(EventState state, ReceivedEventsAction action) {
  return state.copyWith(
    nowInTheatersEvents: action.nowInTheatersEvents,
    comingSoonEvents: action.comingSoonEvents,
  );
}
