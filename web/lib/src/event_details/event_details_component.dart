import 'dart:async';
import 'dart:html' as html;

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:core/core.dart';
import 'package:redux/redux.dart';
import 'package:web/src/common/content_rating/content_rating_component.dart';
import 'package:web/src/common/event_poster/event_poster_component.dart';
import 'package:web/src/common/showtime_item/showtime_item_component.dart';
import 'package:web/src/event_details/actor_scroller/actor_scroller_component.dart';
import 'package:web/src/event_details/landscape_image/event_landscape_image_component.dart';
import 'package:web/src/routes.dart';

@Component(
  selector: 'event-details',
  styleUrls: ['event_details_component.css'],
  templateUrl: 'event_details_component.html',
  directives: [
    EventLandscapeImageComponent,
    ActorScrollerComponent,
    EventPosterComponent,
    ShowtimeItemComponent,
    ContentRatingComponent,
    NgIf,
    NgFor,
  ],
  pipes: [DatePipe],
)
class EventDetailsComponent implements OnInit, OnActivate, OnDestroy {
  EventDetailsComponent(this._store, this._router, this.messages);
  final Store<AppState> _store;
  final Router _router;
  final Messages messages;

  Event event;
  Show show;
  bool _navigatedFromApp = false;
  bool contentVisible = false;
  StreamSubscription<AppState> _eventDetailsSubscription;

  @override
  void ngOnInit() {
    // Reset the scroll position in case this page was previously opened.
    html.window.scrollTo(0, 0);
  }

  @override
  void onActivate(RouterState previous, RouterState current) {
    _navigatedFromApp = previous != null;

    _populateEventDetails(
      current.parameters['eventId'],
      current.parameters['showId'],
    );
  }

  @override
  void ngOnDestroy() => _eventDetailsSubscription?.cancel();

  void _populateEventDetails(String eventId, String showId) {
    event = eventByIdSelector(_store.state, eventId);
    show = showByIdSelector(_store.state, showId);

    if (show != null) {
      // If event is still null, try to find it by show.
      event ??= eventForShowSelector(_store.state, show);
    }

    if (event != null) {
      _store.dispatch(FetchActorAvatarsAction(event));
      _animateContentIntoView();
    } else {
      _store.dispatch(RefreshEventsAction(EventListType.nowInTheaters));
      _store.dispatch(RefreshEventsAction(EventListType.comingSoon));
      _waitForEventDetails(eventId, showId);
    }
  }

  /// The event details page was opened before loading data has finished.
  ///
  /// This happened because the user came to event details page by a link,
  /// for example [https://inkino.app/#event/302789].
  ///
  /// Since in this case, the event details page is the first entry point for
  /// inKino, we'll have to wait until the store is populated with all the events.
  void _waitForEventDetails(String eventId, String showId) {
    final state = _store.state.eventState;
    final isLoading = state.nowInTheatersStatus == LoadingStatus.loading ||
        state.comingSoonStatus == LoadingStatus.loading;

    if (!isLoading) {
      return;
    }

    _eventDetailsSubscription = _store.onChange.listen((state) {
      final state = _store.state.eventState;
      final hasFinishedLoading =
          state.nowInTheatersStatus != LoadingStatus.loading &&
              state.comingSoonStatus != LoadingStatus.loading;

      if (hasFinishedLoading) {
        _populateEventDetails(eventId, showId);
        _eventDetailsSubscription.cancel();
        _eventDetailsSubscription = null;

        _animateContentIntoView();
      }
    });
  }

  void _animateContentIntoView() =>
      Timer(Duration.zero, () => contentVisible = true);

  void openShow() => html.window.open(show.url, 'Tickets for ${show.title}');

  void goBack() {
    if (_navigatedFromApp) {
      html.window.history.back();
      return;
    }

    _router.navigateByUrl(
      RoutePaths.nowInTheaters.toUrl(),
      replace: true,
    );
  }
}
