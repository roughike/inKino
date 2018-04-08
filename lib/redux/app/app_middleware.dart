import 'dart:async';

import 'package:inkino/data/networking/tmdb_api.dart';
import 'package:inkino/redux/app/app_actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:redux/redux.dart';

class AppMiddleware extends MiddlewareClass<AppState> {
  AppMiddleware(this.tmdbApi);
  final TMDBApi tmdbApi;

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is FetchActorAvatarsAction) {
      next(new ActorsUpdatedAction(action.event.actors));

      try {
        var actorsWithAvatars = await tmdbApi.findAvatarsForActors(
          action.event,
          action.event.actors,
        );

        // TMDB API might have a more comprehensive list of actors than the
        // Finnkino API, so we update the event with the actors we get from
        // the TMDB API.
        next(new UpdateActorsForEventAction(action.event, actorsWithAvatars));
        next(new ReceivedActorAvatarsAction(actorsWithAvatars));
      } catch (e) {
        // YOLO! We don't need to handle this. If fetching actor avatars
        // fails, we don't care.
      }
    }
  }
}
