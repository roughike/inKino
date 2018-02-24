import 'package:inkino/data/event.dart';
import 'package:meta/meta.dart';

@immutable
class EventState {
  EventState({
    @required this.allEventsById,
    @required this.eventIdsByTheaterId,
  });

  final Map<String, Event> allEventsById;
  final Map<String, List<String>> eventIdsByTheaterId;

  factory EventState.initial() {
    return new EventState(
      allEventsById: <String, Event>{},
      eventIdsByTheaterId: <String, List<String>>{},
    );
  }

  EventState copyWith({
    Map<String, Event> allEventsById,
    Map<String, List<String>> eventIdsByTheaterId,
  }) {
    return new EventState(
      allEventsById: allEventsById ?? this.allEventsById,
      eventIdsByTheaterId: eventIdsByTheaterId ?? this.eventIdsByTheaterId,
    );
  }
}
