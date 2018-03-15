import 'package:flutter/services.dart';
import 'package:inkino/data/file_cache.dart';
import 'package:inkino/data/finnkino_api.dart';
import 'package:inkino/redux/app/app_reducer.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/event/event_middleware.dart';
import 'package:inkino/redux/show/show_middleware.dart';
import 'package:inkino/redux/theater/theater_middleware.dart';
import 'package:redux/redux.dart';

Store<AppState> createStore() {
  var api = new FinnkinoApi();
  var cache = new FileCache();

  return new Store(
    appReducer,
    initialState: new AppState.initial(),
    middleware: [
      // TODO: test the ordering, since it matters.
      new TheaterMiddleware(rootBundle),
      new ShowMiddleware(api),
      new EventMiddleware(api),
    ],
  );
}
