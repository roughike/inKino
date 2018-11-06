import 'package:core/src/models/actor.dart';
import 'package:core/src/models/event.dart';
import 'package:core/src/models/theater.dart';

class InitAction {}

class InitCompleteAction {
  InitCompleteAction(
    this.theaters,
    this.selectedTheater,
  );

  final List<Theater> theaters;
  final Theater selectedTheater;
}

class FetchComingSoonEventsIfNotLoadedAction {}

class ChangeCurrentTheaterAction {
  ChangeCurrentTheaterAction(this.selectedTheater);
  final Theater selectedTheater;
}

class UpdateActorsForEventAction {
  UpdateActorsForEventAction(this.event, this.actors);

  final Event event;
  final List<Actor> actors;
}
