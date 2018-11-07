import 'package:core/src/models/event.dart';
import 'package:core/src/models/show.dart';
import 'package:core/src/models/show_cache.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:memoize/memoize.dart';
import 'package:reselect/reselect.dart';

Show showByIdSelector(AppState state, String id) {
  return showsSelector(state).firstWhere(
    (show) => show.id == id,
    orElse: () => _findFromAllShows(state, id),
  );
}

/// Selects a list of shows based on the currently selected date and theater.
///
/// If the current AppState contains a search query, returns only shows that match
/// that search query. Otherwise returns all matching shows for current theater
/// and date.
final showsSelector = createSelector3<AppState, DateTheaterPair,
    Map<DateTheaterPair, List<Show>>, String, List<Show>>(
  (state) => DateTheaterPair.fromState(state),
  (state) => state.showState.shows,
  (state) => state.searchQuery,
  (key, shows, searchQuery) {
    final matchingShows = shows[key] ?? [];

    return searchQuery == null
        ? matchingShows
        : _showsWithSearchQuery(matchingShows, searchQuery);
  },
);

final showsForEventSelector =
    memo2<List<Show>, Event, List<Show>>((shows, event) {
  return shows
      .where((show) => show.originalTitle == event.originalTitle)
      .toList();
});

List<Show> _showsWithSearchQuery(List<Show> shows, String searchQuery) {
  final searchQueryPattern = new RegExp(searchQuery, caseSensitive: false);

  return shows.where((show) {
    return show.title.contains(searchQueryPattern) ||
        show.originalTitle.contains(searchQueryPattern);
  }).toList();
}

/// Goes through the list of showtimes for every single theater.
///
/// Skips all memoization and searches for correct show time through all shows
/// instead of shows specific to current theater and date. Used as a fallback
/// when [showByIdSelector] fails.
Show _findFromAllShows(AppState state, String id) {
  final allShows = state.showState.shows.values;
  return allShows.firstWhere(
    (shows) {
      final match = shows.firstWhere(
        (show) => show.id == id,
        orElse: () => null,
      );

      return match != null;
    },
    orElse: () => null,
  )?.first;
}
