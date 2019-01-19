import 'package:core/src/models/event.dart';
import 'package:kt_dart/collection.dart';

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
  final KtList<Event> events;
}

class ReceivedComingSoonEventsAction {
  ReceivedComingSoonEventsAction(this.events);
  final KtList<Event> events;
}

class ErrorLoadingEventsAction {
  ErrorLoadingEventsAction(this.type);
  final EventListType type;
}
