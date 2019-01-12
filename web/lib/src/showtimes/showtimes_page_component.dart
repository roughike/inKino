import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:core/core.dart';
import 'package:kt_dart/collection.dart';
import 'package:redux/redux.dart';
import 'package:web/src/common/loading_view/loading_view_component.dart';
import 'package:web/src/common/showtime_item/showtime_item_component.dart';
import 'package:web/src/common/theater_selector/theater_selector_component.dart';
import 'package:web/src/restore_scroll_position.dart';
import 'package:web/src/routes.dart';
import 'package:web/src/showtimes/date_selector_component.dart';

@Component(
  selector: 'showtimes-page',
  styleUrls: ['showtimes_page_component.css'],
  templateUrl: 'showtimes_page_component.html',
  directives: [
    TheaterSelectorComponent,
    LoadingViewComponent,
    ShowtimeItemComponent,
    DateSelectorComponent,
    NgFor,
    NgIf,
  ],
  pipes: [DatePipe],
)
class ShowtimesPageComponent implements OnActivate {
  ShowtimesPageComponent(this._store, this._router, this.messages);
  final Store<AppState> _store;
  final Router _router;
  final Messages messages;

  @Input('event-filter')
  Event eventFilter;

  ShowtimesPageViewModel get viewModel =>
      ShowtimesPageViewModel.fromStore(_store);

  KtList<Show> get shows => eventFilter == null
      ? viewModel.shows
      : showsForEventSelector(viewModel.shows, eventFilter);

  void openShowDetails(Show show) {
    storeCurrentScrollPosition();

    final event = eventForShowSelector(_store.state, show);
    final url = RoutePaths.showDetails.toUrl(parameters: {
      'eventId': event.id,
      'showId': show.id,
    });

    _router.navigate(url);
  }

  @override
  void onActivate(RouterState previous, _) {
    restoreScrollPositionIfNeeded(previous, RoutePaths.showDetails);
    _store.dispatch(FetchShowsIfNotLoadedAction());
  }
}
