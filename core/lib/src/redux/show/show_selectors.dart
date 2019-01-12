import 'package:core/src/models/event.dart';
import 'package:core/src/models/show.dart';
import 'package:core/src/models/show_cache.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:kt_dart/collection.dart';
import 'package:memoize/memoize.dart';
import 'package:reselect/reselect.dart';

Show showByIdSelector(AppState state, String id) {
  return showsSelector(state).firstOrNull((show) => show.id == id) ??
      _findFromAllShows(state, id);
}

/// Selects a list of shows based on the currently selected date and theater.
///
/// If the current AppState contains a search query, returns only shows that match
/// that search query. Otherwise returns all matching shows for current theater
/// and date.
final showsSelector = createSelector3<AppState, DateTheaterPair,
    KtMap<DateTheaterPair, KtList<Show>>, String, KtList<Show>>(
  (state) => DateTheaterPair.fromState(state),
  (state) => state.showState.shows,
  (state) => state.searchQuery,
  (key, KtMap<DateTheaterPair, KtList<Show>> shows, searchQuery) {
    KtList<Show> matchingShows = shows.getOrDefault(key, emptyList<Show>());
    if (searchQuery == null) {
      return matchingShows;
    } else {
      return _showsWithSearchQuery(matchingShows, searchQuery);
    }
  },
);

final showsForEventSelector =
    memo2<KtList<Show>, Event, KtList<Show>>((shows, event) {
  return shows.filter((show) => show.originalTitle == event.originalTitle);
});

KtList<Show> _showsWithSearchQuery(KtList<Show> shows, String searchQuery) {
  final searchQueryPattern = new RegExp(searchQuery, caseSensitive: false);

  return shows.filter((show) =>
      show.title.contains(searchQueryPattern) ||
      show.originalTitle.contains(searchQueryPattern));
}

/// Goes through the list of showtimes for every single theater.
///
/// Skips all memoization and searches for correct show time through all shows
/// instead of shows specific to current theater and date. Used as a fallback
/// when [showByIdSelector] fails.
Show _findFromAllShows(AppState state, String id) {
  final allShows = state.showState.shows.values;
  return allShows
      .firstOrNull(
          (shows) => shows.firstOrNull((show) => show.id == id) != null)
      ?.firstOrNull();
}
