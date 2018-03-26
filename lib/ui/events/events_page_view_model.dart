import 'package:inkino/data/event.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/loading_status.dart';
import 'package:inkino/redux/selectors.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class EventsPageViewModel {
  EventsPageViewModel({
    @required this.status,
    @required this.events,
    @required this.refreshEventsCallback,
  });

  final LoadingStatus status;
  final List<Event> events;
  final Function refreshEventsCallback;

  static EventsPageViewModel fromStore(
    Store<AppState> store,
    EventListType type,
  ) {
    return new EventsPageViewModel(
      status: store.state.eventState.loadingStatus,
      events: eventsSelector(store.state, type),
      refreshEventsCallback: () => store.dispatch(new RefreshEventsAction()),
    );
  }
}
