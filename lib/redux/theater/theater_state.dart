import 'package:inkino/data/models/theater.dart';
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TheaterState &&
              runtimeType == other.runtimeType &&
              currentTheater == other.currentTheater &&
              theaters == other.theaters;

  @override
  int get hashCode =>
      currentTheater.hashCode ^
      theaters.hashCode;
}