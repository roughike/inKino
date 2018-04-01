import 'package:inkino/data/models/event.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/event/event_actions.dart';
import 'package:inkino/redux/loading_status.dart';
import 'package:inkino/redux/selectors.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class EventsPageViewModel {
  EventsPageViewModel({
    @required this.status,
    @required this.events,
    @required this.refreshEvents,
  });

  final LoadingStatus status;
  final List<Event> events;
  final Function refreshEvents;

  static EventsPageViewModel fromStore(
    Store<AppState> store,
    EventListType type,
  ) {
    return new EventsPageViewModel(
      status: store.state.eventState.loadingStatus,
      events: eventsSelector(store.state, type),
      refreshEvents: () => store.dispatch(new RefreshEventsAction()),
    );
  }
}
