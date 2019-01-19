import 'package:core/src/models/actor.dart';
import 'package:core/src/models/event.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:kt_dart/collection.dart';

KtList<Actor> actorsForEventSelector(AppState state, Event event) {
  return state.actorsByName.values
      .filter((actor) => event.actors.contains(actor));
}
