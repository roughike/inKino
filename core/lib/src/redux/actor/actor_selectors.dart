import 'package:core/src/models/actor.dart';
import 'package:core/src/models/event.dart';
import 'package:core/src/redux/app/app_state.dart';

List<Actor> actorsForEventSelector(AppState state, Event event) {
  return state.actorsByName.values
      .where((actor) => event.actors.contains(actor))
      .toList();
}
