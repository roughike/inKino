import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:core/core.dart';
import 'package:redux/redux.dart';

@Component(
  selector: 'search-bar',
  templateUrl: 'search_bar_component.html',
  styleUrls: ['search_bar_component.css'],
)
class SearchBarComponent {
  SearchBarComponent(this.messages, this.store);
  final Messages messages;
  final Store<AppState> store;

  @HostBinding('attr.expanded')
  String get hostExpanded => searchOpen ? '' : null;

  @ViewChild('searchField')
  InputElement searchField;

  bool searchOpen = false;

  void toggleSearch() {
    searchOpen = !searchOpen;

    if (searchOpen) {
      Timer(const Duration(milliseconds: 250), () => searchField.focus());
    } else {
      searchField.value = ''; // Clear the search when closed.
      updateSearchQuery(null);
    }
  }

  void updateSearchQuery(String newQuery) =>
      store.dispatch(SearchQueryChangedAction(newQuery));
}
