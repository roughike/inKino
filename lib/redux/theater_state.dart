import 'package:inkino/data/schedule_date.dart';
import 'package:inkino/data/theater.dart';
import 'package:meta/meta.dart';

@immutable
class TheaterState {
  TheaterState({
    @required this.currentTheater,
    @required this.theaters,
    @required this.scheduleDatesByTheaterID,
  });

  final Theater currentTheater;
  final List<Theater> theaters;
  final Map<String, ScheduleDate> scheduleDatesByTheaterID;

  factory TheaterState.initial() {
    return new TheaterState(
      currentTheater: null,
      theaters: <Theater>[],
      scheduleDatesByTheaterID: <String, ScheduleDate>{},
    );
  }

  TheaterState copyWith({
    Theater currentTheater,
    List<Theater> theaters,
    Map<String, ScheduleDate> scheduleDatesByTheaterID,
  }) {
    return new TheaterState(
      currentTheater: currentTheater ?? this.currentTheater,
      theaters: theaters ?? this.theaters,
      scheduleDatesByTheaterID: scheduleDatesByTheaterID ?? this.scheduleDatesByTheaterID,
    );
  }
}