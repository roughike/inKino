import 'package:inkino/data/models/actor.dart';
import 'package:inkino/data/models/event.dart';
import 'package:inkino/redux/app/app_state.dart';

List<Actor> actorsForEventSelector(AppState state, Event event) {
  return state.actorsByName.values
      .where((actor) => event.actors.contains(actor))
      .toList();
}
