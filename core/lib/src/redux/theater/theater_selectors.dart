import 'package:core/src/models/theater.dart';
import 'package:core/src/redux/app/app_state.dart';

Theater currentTheaterSelector(AppState state) =>
    state.theaterState.currentTheater;

List<Theater> theatersSelector(AppState state) => state.theaterState.theaters;
