import 'package:collection/collection.dart';
import 'package:inkino/models/event.dart';
import 'package:inkino/models/loading_status.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/event/event_actions.dart';
import 'package:inkino/redux/event/event_selectors.dart';
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
    return EventsPageViewModel(
      status: store.state.eventState.loadingStatus,
      events: eventsSelector(store.state, type),
      refreshEvents: () => store.dispatch(RefreshEventsAction()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventsPageViewModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          const IterableEquality().equals(events, other.events);

  @override
  int get hashCode => status.hashCode ^ const IterableEquality().hash(events);
}
