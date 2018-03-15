import 'package:inkino/data/event.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:redux/redux.dart';

class EventsPageViewModel {
  EventsPageViewModel(this.events);
  final List<Event> events;

  static EventsPageViewModel fromStore(Store<AppState> store, EventListType type) {
    var events = type == EventListType.nowInTheaters
        ? store.state.eventState.nowInTheatersEvents
        : store.state.eventState.comingSoonEvents;

    return new EventsPageViewModel(events);
  }
}
