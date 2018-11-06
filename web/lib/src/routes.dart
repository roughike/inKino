import 'package:angular_router/angular_router.dart';
import 'package:core/core.dart';
import 'package:web/src/event_details/event_details_component.template.dart'
    deferred as event_details;
import 'package:web/src/events/events_page_component.template.dart'
    as events_page;
import 'package:web/src/showtimes/showtimes_page_component.template.dart'
    deferred as showtimes_page;

class RoutePaths {
  static final nowInTheaters = RoutePath(
    path: '/',
    additionalData: EventListType.nowInTheaters,
    useAsDefault: true,
  );

  static final showtimes = RoutePath(path: 'showtimes');
  static final comingSoon = RoutePath(
    path: 'comingSoon',
    additionalData: EventListType.comingSoon,
  );

  static final eventDetails = RoutePath(path: 'event/:eventId');
  static final showDetails = RoutePath(path: 'show/:eventId/:showId');
}

class Routes {
  static final List<RouteDefinition> all = [
    RouteDefinition(
      routePath: RoutePaths.nowInTheaters,
      useAsDefault: true,
      component: events_page.EventsPageComponentNgFactory,
    ),
    RouteDefinition(
      routePath: RoutePaths.comingSoon,
      component: events_page.EventsPageComponentNgFactory,
    ),
    RouteDefinition.defer(
      routePath: RoutePaths.showtimes,
      loader: () {
        return showtimes_page
            .loadLibrary()
            .then((_) => showtimes_page.ShowtimesPageComponentNgFactory);
      },
    ),
    RouteDefinition.defer(
      routePath: RoutePaths.eventDetails,
      loader: () {
        return event_details
            .loadLibrary()
            .then((_) => event_details.EventDetailsComponentNgFactory);
      },
    ),
    RouteDefinition.defer(
      routePath: RoutePaths.showDetails,
      loader: () {
        return event_details
            .loadLibrary()
            .then((_) => event_details.EventDetailsComponentNgFactory);
      },
    ),
  ];
}
