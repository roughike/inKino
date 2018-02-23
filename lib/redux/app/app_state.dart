import 'package:inkino/redux/show/show_state.dart';
import 'package:inkino/redux/theater/theater_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  AppState({
    @required this.theaterState,
    @required this.showState,
  });

  final TheaterState theaterState;
  final ShowState showState;

  factory AppState.initial() {
    return new AppState(
      theaterState: new TheaterState.initial(),
      showState: new ShowState.initial(),
    );
  }

  AppState copyWith({
    TheaterState theaters,
    ShowState shows,
  }) {
    return new AppState(
      theaterState: theaters ?? this.theaterState,
      showState: shows ?? this.showState,
    );
  }
}
