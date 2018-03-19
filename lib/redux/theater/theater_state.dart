import 'package:inkino/data/theater.dart';
import 'package:meta/meta.dart';

@immutable
class TheaterState {
  TheaterState({
    @required this.currentTheater,
    @required this.theaters,
  });

  final Theater currentTheater;
  final List<Theater> theaters;

  factory TheaterState.initial() {
    return new TheaterState(
      currentTheater: null,
      theaters: <Theater>[],
    );
  }

  TheaterState copyWith({
    Theater currentTheater,
    List<Theater> theaters,
  }) {
    return new TheaterState(
      currentTheater: currentTheater ?? this.currentTheater,
      theaters: theaters ?? this.theaters,
    );
  }
}