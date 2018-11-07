import 'dart:collection';

import 'package:core/src/models/event.dart';
import 'package:core/src/models/show.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:reselect/reselect.dart';

final nowInTheatersSelector = createSelector2(
  (AppState state) => state.eventState.nowInTheatersEvents,
  (AppState state) => state.searchQuery,
  _eventsOrEventSearch,
);

final comingSoonSelector = createSelector2(
  (AppState state) => state.eventState.comingSoonEvents,
  (AppState state) => state.searchQuery,
  _eventsOrEventSearch,
);

Event eventByIdSelector(AppState state, String id) {
  final predicate = (event) => event.id == id;

  return nowInTheatersSelector(state).firstWhere(
    predicate,
    orElse: () {
      return comingSoonSelector(state).firstWhere(
        predicate,
        orElse: () => null,
      );
    },
  );
}

Event eventForShowSelector(AppState state, Show show) {
  return state.eventState.nowInTheatersEvents
      .where((event) => event.id == show.eventId)
      .first;
}

List<Event> _eventsOrEventSearch(List<Event> events, String searchQuery) {
  return searchQuery == null
      ? _uniqueEvents(events)
      : _eventsWithSearchQuery(events, searchQuery);
}

/// Since Finnkino XML API considers "The Grinch" and "The Grinch 2D" to be two
/// completely different events, we might get a lot of duplication. We have to
/// do this hack because it is quite boring to display four movie posters that
/// are exactly the same.
List<Event> _uniqueEvents(List<Event> original) {
  final uniqueEventMap = LinkedHashMap<String, Event>();
  original.forEach((event) {
    uniqueEventMap[event.originalTitle] = event;
  });

  return uniqueEventMap.values.toList();
}

List<Event> _eventsWithSearchQuery(List<Event> original, String searchQuery) {
  final searchQueryPattern = RegExp(searchQuery, caseSensitive: false);

  return original.where((event) {
    return event.title.contains(searchQueryPattern) ||
        event.originalTitle.contains(searchQueryPattern);
  }).toList();
}
