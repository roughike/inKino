import 'package:core/src/models/event.dart';
import 'package:core/src/models/theater.dart';
import 'package:meta/meta.dart';

class RefreshEventsAction {
  RefreshEventsAction(this.type);
  final EventListType type;
}

class RequestingEventsAction {
  RequestingEventsAction(this.type);
  final EventListType type;
}

class ReceivedInTheatersEventsAction {
  ReceivedInTheatersEventsAction(this.events);
  final List<Event> events;
}

class ReceivedComingSoonEventsAction {
  ReceivedComingSoonEventsAction(this.events);
  final List<Event> events;
}

class ErrorLoadingEventsAction {
  ErrorLoadingEventsAction(this.type);
  final EventListType type;
}
