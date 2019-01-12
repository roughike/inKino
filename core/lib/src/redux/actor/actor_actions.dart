import 'package:core/src/models/actor.dart';
import 'package:core/src/models/event.dart';
import 'package:kt_dart/collection.dart';

class FetchActorAvatarsAction {
  FetchActorAvatarsAction(this.event);
  final Event event;
}

class ActorsUpdatedAction {
  ActorsUpdatedAction(this.actors);
  final KtList<Actor> actors;
}

class ReceivedActorAvatarsAction {
  ReceivedActorAvatarsAction(this.actors);
  final KtList<Actor> actors;
}
