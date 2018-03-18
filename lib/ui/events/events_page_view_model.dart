import 'package:inkino/data/event.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/loading_status.dart';
import 'package:redux/redux.dart';

class EventsPageViewModel {
  EventsPageViewModel(
    this.status,
    this.events,
    this.refreshEvents,
  );

  final LoadingStatus status;
  final List<Event> events;
  final Function refreshEvents;

  static EventsPageViewModel fromStore(
    Store<AppState> store,
    EventListType type,
  ) {
    var events = type == EventListType.nowInTheaters
        ? store.state.eventState.nowInTheatersEvents
        : store.state.eventState.comingSoonEvents;

    return new EventsPageViewModel(
      store.state.eventState.loadingStatus,
      events,
      () => store.dispatch(new RefreshEventsAction()),
    );
  }
}
