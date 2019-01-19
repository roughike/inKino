import 'package:core/src/models/event.dart';
import 'package:core/src/models/show.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:core/src/redux/event/event_selectors.dart';
import 'package:core/src/redux/event/event_state.dart';
import 'package:kt_dart/collection.dart';
import 'package:test/test.dart';

void main() {
  group('Event selectors', () {
    final firstInTheaterEvent = Event(
      id: 'in-theater-1',
      originalTitle: 'In theater event #1',
      title: 'In theater event #1',
    );
    final secondInTheaterEvent = Event(
      id: 'in-theater-2',
      originalTitle: 'In theater event #2',
      title: 'In theater event #2',
    );
    final nowInTheatersEvents =
        listOf(firstInTheaterEvent, secondInTheaterEvent);

    final firstComingSoonEvent = Event(
      id: 'coming-soon-1',
      originalTitle: 'Coming soon event #1',
      title: 'Coming soon event #1',
    );
    final firstComingSoonEventDuplicate = Event(
      id: 'coming-soon-1-fr',
      originalTitle: 'Coming soon event #1',
      title: 'Coming soon event #1 (FR)',
    );
    final secondComingSoonEvent = Event(
      id: 'coming-soon-2',
      originalTitle: 'Coming soon event #2',
      title: 'Coming soon event #2',
    );
    final comingSoonEvents = listOf(firstComingSoonEvent,
        firstComingSoonEventDuplicate, secondComingSoonEvent);

    final state = AppState.initial().copyWith(
      eventState: EventState.initial().copyWith(
        nowInTheatersEvents: nowInTheatersEvents,
        comingSoonEvents: comingSoonEvents,
      ),
    );

    test('events', () {
      expect(nowInTheatersSelector(state), nowInTheatersEvents);
      // without duplicates
      expect(comingSoonSelector(state),
          listOf(firstComingSoonEvent, secondComingSoonEvent));
    });

    test('events with search query', () {
      final stateWithSearchQuery = state.copyWith(searchQuery: '2');

      expect(
        nowInTheatersSelector(stateWithSearchQuery),
        listOf(secondInTheaterEvent),
      );

      expect(
        comingSoonSelector(stateWithSearchQuery),
        listOf(secondComingSoonEvent),
      );
    });

    test('event by id', () {
      expect(eventByIdSelector(state, 'in-theater-1'), firstInTheaterEvent);
      expect(eventByIdSelector(state, 'in-theater-2'), secondInTheaterEvent);
      expect(eventByIdSelector(state, 'coming-soon-1'), firstComingSoonEvent);
      expect(eventByIdSelector(state, 'coming-soon-2'), secondComingSoonEvent);
    });

    test('event for show', () {
      final show = Show(eventId: 'in-theater-2');
      expect(eventForShowSelector(state, show), secondInTheaterEvent);
    });

    test('event by id - null', () {
      // If no crash, this is considered a passing test.
      expect(eventByIdSelector(state, null), isNull);
    });
  });
}
