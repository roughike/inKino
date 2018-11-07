import 'package:core/src/networking/finnkino_api.dart';
import 'package:core/src/networking/tmdb_api.dart';
import 'package:core/src/redux/actor/actor_middleware.dart';
import 'package:core/src/redux/app/app_reducer.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:core/src/redux/event/event_middleware.dart';
import 'package:core/src/redux/show/show_middleware.dart';
import 'package:core/src/redux/theater/theater_middleware.dart';
import 'package:http/http.dart';
import 'package:key_value_store/key_value_store.dart';
import 'package:redux/redux.dart';

Store<AppState> createStore(Client client, KeyValueStore keyValueStore) {
  final tmdbApi = TMDBApi(client);
  final finnkinoApi = FinnkinoApi(client);

  return Store(
    appReducer,
    initialState: AppState.initial(),
    distinct: true,
    middleware: [
      ActorMiddleware(tmdbApi),
      TheaterMiddleware(keyValueStore),
      ShowMiddleware(finnkinoApi),
      EventMiddleware(finnkinoApi),
    ],
  );
}
