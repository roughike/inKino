import 'package:inkino/models/show.dart';
import 'package:inkino/redux/app/app_state.dart';

List<Show> showsSelector(AppState state) {
  var shows = state.showState.shows;

  if (state.searchQuery == null) {
    return shows;
  }

  return _showsWithSearchQuery(state, shows);
}

List<Show> _showsWithSearchQuery(AppState state, List<Show> shows) {
  var searchQuery = new RegExp(state.searchQuery, caseSensitive: false);

  return shows.where((show) {
    return show.title.contains(searchQuery) ||
        show.originalTitle.contains(searchQuery);
  }).toList();
}
