import 'package:inkino/data/event.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:redux/redux.dart';
import 'package:inkino/redux/selectors.dart';

class EventsPageViewModel {
  EventsPageViewModel(this.events);
  final List<Event> events;

  static EventsPageViewModel fromStore(Store<AppState> store) {
    return new EventsPageViewModel(
      eventsForTheaterSelector(
        store.state,
        currentTheaterSelector(store.state),
      ),
    );
  }
}
