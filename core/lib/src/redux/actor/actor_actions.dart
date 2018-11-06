import 'package:core/src/models/actor.dart';
import 'package:core/src/models/event.dart';

class FetchActorAvatarsAction {
  FetchActorAvatarsAction(this.event);
  final Event event;
}

class ActorsUpdatedAction {
  ActorsUpdatedAction(this.actors);
  final List<Actor> actors;
}

class ReceivedActorAvatarsAction {
  ReceivedActorAvatarsAction(this.actors);
  final List<Actor> actors;
}
