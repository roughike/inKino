import 'package:core/src/models/theater.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';

@immutable
class TheaterState {
  TheaterState({
    @required this.currentTheater,
    @required this.theaters,
  });

  final Theater currentTheater;
  final KtList<Theater> theaters;

  factory TheaterState.initial() {
    return TheaterState(
      currentTheater: null,
      theaters: emptyList(),
    );
  }

  TheaterState copyWith({
    Theater currentTheater,
    KtList<Theater> theaters,
  }) {
    return TheaterState(
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
  int get hashCode => currentTheater.hashCode ^ theaters.hashCode;
}
