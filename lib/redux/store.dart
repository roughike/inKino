import 'dart:async';

import 'package:flutter/services.dart';
import 'package:inkino/data/networking/finnkino_api.dart';
import 'package:inkino/data/networking/tmdb_api.dart';
import 'package:inkino/redux/actor/actor_middleware.dart';
import 'package:inkino/redux/app/app_reducer.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/event/event_middleware.dart';
import 'package:inkino/redux/show/show_middleware.dart';
import 'package:inkino/redux/theater/theater_middleware.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Store<AppState>> createStore() async {
  var tmdbApi = new TMDBApi();
  var finnkinoApi = new FinnkinoApi();
  var prefs = await SharedPreferences.getInstance();

  return new Store(
    appReducer,
    initialState: new AppState.initial(),
    distinct: true,
    middleware: [
      new ActorMiddleware(tmdbApi),
      new TheaterMiddleware(rootBundle, prefs),
      new ShowMiddleware(finnkinoApi),
      new EventMiddleware(finnkinoApi),
    ],
  );
}
