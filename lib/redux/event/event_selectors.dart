import 'dart:collection';

import 'package:inkino/data/models/event.dart';
import 'package:inkino/data/models/show.dart';
import 'package:inkino/redux/app/app_state.dart';

List<Event> eventsSelector(AppState state, EventListType type) {
  List<Event> events = type == EventListType.nowInTheaters
      ? state.eventState.nowInTheatersEvents
      : state.eventState.comingSoonEvents;

  var uniqueEvents = _uniqueEvents(events);

  if (state.searchQuery == null) {
    return uniqueEvents;
  }

  return _eventsWithSearchQuery(state, uniqueEvents);
}

List<Event> _uniqueEvents(List<Event> original) {
  var uniqueEventMap = new LinkedHashMap<String, Event>();
  original.forEach((event) {
    uniqueEventMap[event.originalTitle] = event;
  });

  return uniqueEventMap.values.toList();
}

List<Event> _eventsWithSearchQuery(AppState state, List<Event> original) {
  var searchQuery = new RegExp(state.searchQuery, caseSensitive: false);

  return original.where((event) {
    return event.title.contains(searchQuery) ||
        event.originalTitle.contains(searchQuery);
  }).toList();
}

Event eventForShowSelector(AppState state, Show show) {
  return state.eventState.nowInTheatersEvents
      .where((event) => event.id == show.eventId)
      .first;
}
