import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:core/core.dart';
import 'package:redux/redux.dart';
import 'package:web/src/common/event_poster/event_poster_component.dart';
import 'package:web/src/common/loading_view/loading_view_component.dart';
import 'package:web/src/common/theater_selector/theater_selector_component.dart';
import 'package:web/src/routes.dart';

import '../restore_scroll_position.dart';

@Component(
  selector: 'events-page',
  styleUrls: ['events_page_component.css'],
  templateUrl: 'events_page_component.html',
  directives: [
    TheaterSelectorComponent,
    LoadingViewComponent,
    EventPosterComponent,
    NgFor,
  ],
)
class EventsPageComponent implements OnActivate {
  EventsPageComponent(this._store, this._router, this.messages);
  final Store<AppState> _store;
  final Router _router;
  final Messages messages;

  EventListType _listType;

  EventsPageViewModel get viewModel =>
      EventsPageViewModel.fromStore(_store, _listType);

  String get eventTypeTitle => _listType == EventListType.nowInTheaters
      ? messages.nowInTheaters
      : messages.comingSoon;

  bool get isDisplayingComingSoonMovies =>
      _listType == EventListType.comingSoon;

  @override
  void onActivate(RouterState previous, RouterState current) {
    _listType = current.routePath.additionalData;
    restoreScrollPositionIfNeeded(previous, RoutePaths.eventDetails);

    if (_listType == EventListType.comingSoon) {
      _store.dispatch(FetchComingSoonEventsIfNotLoadedAction());
    }
  }

  void openEventDetails(Event event) {
    storeCurrentScrollPosition();

    final url =
        RoutePaths.eventDetails.toUrl(parameters: {'eventId': event.id});
    _router.navigate(url);
  }
}
