import 'dart:async';

import 'package:flutter/services.dart';
import 'package:inkino/networking/finnkino_api.dart';
import 'package:inkino/networking/tmdb_api.dart';
import 'package:inkino/redux/actor/actor_middleware.dart';
import 'package:inkino/redux/app/app_reducer.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/event/event_middleware.dart';
import 'package:inkino/redux/show/show_middleware.dart';
import 'package:inkino/redux/theater/theater_middleware.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Store<AppState>> createStore() async {
  var tmdbApi = TMDBApi();
  var finnkinoApi = FinnkinoApi();
  var prefs = await SharedPreferences.getInstance();

  return Store(
    appReducer,
    initialState: AppState.initial(),
    distinct: true,
    middleware: [
      ActorMiddleware(tmdbApi),
      TheaterMiddleware(rootBundle, prefs),
      ShowMiddleware(finnkinoApi),
      EventMiddleware(finnkinoApi),
    ],
  );
}
