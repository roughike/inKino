import 'package:core/src/models/event.dart';
import 'package:core/src/models/loading_status.dart';
import 'package:core/src/redux/_common/common_actions.dart';
import 'package:core/src/redux/event/event_actions.dart';
import 'package:core/src/redux/event/event_state.dart';
import 'package:kt_dart/collection.dart';

EventState eventReducer(EventState state, dynamic action) {
  if (action is RequestingEventsAction) {
    return _requestingEvents(state, action.type);
  } else if (action is ReceivedInTheatersEventsAction) {
    return state.copyWith(
      nowInTheatersStatus: LoadingStatus.success,
      nowInTheatersEvents: action.events,
    );
  } else if (action is ReceivedComingSoonEventsAction) {
    return state.copyWith(
      comingSoonStatus: LoadingStatus.success,
      comingSoonEvents: action.events,
    );
  } else if (action is ErrorLoadingEventsAction) {
    return _errorLoadingEvents(state, action.type);
  } else if (action is UpdateActorsForEventAction) {
    return _updateActorsForEvent(state, action);
  }

  return state;
}

EventState _requestingEvents(EventState state, EventListType type) {
  final status = LoadingStatus.loading;

  if (type == EventListType.nowInTheaters) {
    return state.copyWith(nowInTheatersStatus: status);
  }

  return state.copyWith(comingSoonStatus: status);
}

EventState _errorLoadingEvents(EventState state, EventListType type) {
  final status = LoadingStatus.error;

  if (type == EventListType.nowInTheaters) {
    return state.copyWith(nowInTheatersStatus: status);
  }

  return state.copyWith(comingSoonStatus: status);
}

EventState _updateActorsForEvent(
    EventState state, UpdateActorsForEventAction action) {
  final event = action.event;
  event.actors = action.actors;

  return state.copyWith(
    nowInTheatersEvents:
        _addActorImagesToEvent(state.nowInTheatersEvents, event),
    comingSoonEvents: _addActorImagesToEvent(state.comingSoonEvents, event),
  );
}

KtList<Event> _addActorImagesToEvent(
    KtList<Event> originalEvents, Event replacement) {
  final positionToReplace = originalEvents
      .indexOfFirst((candidate) => candidate.id == replacement.id);

  if (positionToReplace > -1) {
    final newEvents = originalEvents.toMutableList();
    newEvents[positionToReplace] = replacement;
    return newEvents;
  }

  return originalEvents;
}
