import 'package:inkino/data/event.dart';
import 'package:meta/meta.dart';

@immutable
class EventState {
  EventState({
    @required this.nowInTheatersEvents,
    @required this.comingSoonEvents,
  });

  final List<Event> nowInTheatersEvents;
  final List<Event> comingSoonEvents;

  factory EventState.initial() {
    return new EventState(
      nowInTheatersEvents: <Event>[],
      comingSoonEvents: <Event>[],
    );
  }

  EventState copyWith({
    List<Event> nowInTheatersEvents,
    List<Event> comingSoonEvents,
  }) {
    return new EventState(
      nowInTheatersEvents: nowInTheatersEvents ?? this.nowInTheatersEvents,
      comingSoonEvents: comingSoonEvents ?? this.comingSoonEvents,
    );
  }
}
