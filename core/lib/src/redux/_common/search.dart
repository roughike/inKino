class SearchQueryChangedAction {
  SearchQueryChangedAction(this.query);
  final String query;
}

String searchQueryReducer(String searchQuery, dynamic action) {
  if (action is SearchQueryChangedAction) {
    return action.query;
  }

  return searchQuery;
}
