import 'package:inkino/redux/show_state.dart';
import 'package:inkino/redux/theater_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  AppState({
    @required this.theaterState,
    @required this.shows,
  });

  final TheaterState theaterState;
  final ShowState shows;

  factory AppState.initial() {
    return new AppState(
      theaterState: new TheaterState.initial(),
      shows: new ShowState.initial(),
    );
  }

  AppState copyWith({
    TheaterState theaters,
    ShowState shows,
  }) {
    return new AppState(
      theaterState: theaters ?? this.theaterState,
      shows: shows ?? this.shows,
    );
  }
}
