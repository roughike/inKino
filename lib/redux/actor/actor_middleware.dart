import 'dart:async';

import 'package:inkino/networking/tmdb_api.dart';
import 'package:inkino/redux/actor/actor_actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:redux/redux.dart';

class ActorMiddleware extends MiddlewareClass<AppState> {
  ActorMiddleware(this.tmdbApi);
  final TMDBApi tmdbApi;

  @override
  Future<Null> call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    if (action is FetchActorAvatarsAction) {
      next(ActorsUpdatedAction(action.event.actors));

      try {
        var actorsWithAvatars = await tmdbApi.findAvatarsForActors(
          action.event,
          action.event.actors,
        );

        // TMDB API might have a more comprehensive list of actors than the
        // Finnkino API, so we update the event with the actors we get from
        // the TMDB API.
        next(UpdateActorsForEventAction(action.event, actorsWithAvatars));
        next(ReceivedActorAvatarsAction(actorsWithAvatars));
      } catch (e) {
        // We don't need to handle this. If fetching actor avatars
        // fails, we don't care: the UI just simply won't display
        // any actor avatars and falls back to placeholder icons
        // instead.
      }
    }
  }
}
