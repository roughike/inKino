import 'package:inkino/models/theater.dart';
import 'package:inkino/redux/app/app_state.dart';

Theater currentTheaterSelector(AppState state) =>
    state.theaterState.currentTheater;

List<Theater> theatersSelector(AppState state) => state.theaterState.theaters;
