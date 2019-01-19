import 'package:core/src/models/event.dart';
import 'package:core/src/models/loading_status.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:core/src/redux/event/event_actions.dart';
import 'package:core/src/redux/event/event_selectors.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class EventsPageViewModel {
  EventsPageViewModel({
    @required this.status,
    @required this.events,
    @required this.refreshEvents,
  });

  final LoadingStatus status;
  final KtList<Event> events;
  final Function refreshEvents;

  static EventsPageViewModel fromStore(
    Store<AppState> store,
    EventListType type,
  ) {
    return EventsPageViewModel(
      status: type == EventListType.nowInTheaters
          ? store.state.eventState.nowInTheatersStatus
          : store.state.eventState.comingSoonStatus,
      events: type == EventListType.nowInTheaters
          ? nowInTheatersSelector(store.state)
          : comingSoonSelector(store.state),
      refreshEvents: () => store.dispatch(RefreshEventsAction(type)),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventsPageViewModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          events == other.events;

  @override
  int get hashCode => status.hashCode ^ events.hashCode;
}
