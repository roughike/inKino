import 'package:inkino/data/models/actor.dart';
import 'package:inkino/data/models/event.dart';

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
