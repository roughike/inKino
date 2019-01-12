import 'package:core/src/models/actor.dart';
import 'package:core/src/models/event.dart';
import 'package:core/src/models/loading_status.dart';
import 'package:core/src/redux/_common/common_actions.dart';
import 'package:core/src/redux/event/event_actions.dart';
import 'package:core/src/redux/event/event_reducer.dart';
import 'package:core/src/redux/event/event_state.dart';
import 'package:kt_dart/collection.dart';
import 'package:test/test.dart';

void main() {
  group('EventReducer', () {
    test('when receiving now in theaters events', () {
      final events = listOf(
        Event(id: 'now in'),
        Event(id: 'theaters'),
      );

      final state = EventState.initial();
      final reducedState =
          eventReducer(state, ReceivedInTheatersEventsAction(events));

      expect(reducedState.nowInTheatersStatus, LoadingStatus.success);
      expect(reducedState.nowInTheatersEvents, events);
    });

    test('when receiving upcoming events', () {
      final events = listOf(
        Event(id: 'coming'),
        Event(id: 'soon'),
      );

      final state = EventState.initial();
      final reducedState =
          eventReducer(state, ReceivedComingSoonEventsAction(events));

      expect(reducedState.comingSoonStatus, LoadingStatus.success);
      expect(reducedState.comingSoonEvents, events);
    });

    test(
      'when called with UpdateActorsForEventAction, should update event actors when it is a now playing event',
      () {
        final state = EventState.initial().copyWith(
          nowInTheatersEvents: listOf(
            Event(id: '1'),
            Event(id: 'event-to-update'),
            Event(id: '2'),
          ),
        );

        final reducedState = eventReducer(
          state,
          UpdateActorsForEventAction(
            Event(id: 'event-to-update'),
            listOf(
              Actor(name: 'Eric Seidel', avatarUrl: 'http://erics-avatar'),
              Actor(name: 'Seth Ladd', avatarUrl: 'http://seths-avatar'),
            ),
          ),
        );

        final nowInTheatersEvents = reducedState.nowInTheatersEvents;
        expect(nowInTheatersEvents[0].actors, isNull);
        expect(nowInTheatersEvents[2].actors, isNull);

        final updatedEvent = nowInTheatersEvents[1];
        expect(updatedEvent.actors.size, 2);
        expect(updatedEvent.actors[0].name, 'Eric Seidel');
        expect(updatedEvent.actors[1].name, 'Seth Ladd');
      },
    );

    test(
      'when called with UpdateActorsForEventAction, should update event actors when it is a upcoming event',
      () {
        final state = EventState.initial().copyWith(
          comingSoonEvents: listOf(
            Event(id: '1'),
            Event(id: 'event-to-update'),
            Event(id: '2'),
          ),
        );

        final reducedState = eventReducer(
          state,
          UpdateActorsForEventAction(
            Event(id: 'event-to-update'),
            listOf(
              Actor(name: 'Eric Seidel', avatarUrl: 'http://erics-avatar'),
              Actor(name: 'Seth Ladd', avatarUrl: 'http://seths-avatar'),
            ),
          ),
        );

        final comingSoonEvents = reducedState.comingSoonEvents;
        expect(comingSoonEvents[0].actors, isNull);
        expect(comingSoonEvents[2].actors, isNull);

        final updatedEvent = comingSoonEvents[1];
        expect(updatedEvent.actors.size, 2);
        expect(updatedEvent.actors[0].name, 'Eric Seidel');
        expect(updatedEvent.actors[1].name, 'Seth Ladd');
      },
    );
  });
}
