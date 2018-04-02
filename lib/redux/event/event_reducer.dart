import 'package:inkino/redux/event/event_actions.dart';
import 'package:inkino/redux/event/event_state.dart';
import 'package:inkino/data/loading_status.dart';
import 'package:redux/redux.dart';

final eventReducer = combineTypedReducers([
  new ReducerBinding<EventState, RequestingEventsAction>(_requestingEvents),
  new ReducerBinding<EventState, ReceivedEventsAction>(_receivedEvents),
  new ReducerBinding<EventState, ErrorLoadingEventsAction>(_errorLoadingEvents),
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

EventState _errorLoadingEvents(EventState state, ErrorLoadingEventsAction action) {
  return state.copyWith(loadingStatus: LoadingStatus.error);
}
