import 'package:core/src/models/theater.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:kt_dart/collection.dart';

Theater currentTheaterSelector(AppState state) =>
    state.theaterState.currentTheater;

KtList<Theater> theatersSelector(AppState state) => state.theaterState.theaters;
