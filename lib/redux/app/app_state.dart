import 'package:inkino/redux/event/event_state.dart';
import 'package:inkino/redux/show/show_state.dart';
import 'package:inkino/redux/theater/theater_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  AppState({
    @required this.theaterState,
    @required this.showState,
    @required this.eventState,
  });

  final TheaterState theaterState;
  final ShowState showState;
  final EventState eventState;

  factory AppState.initial() {
    return new AppState(
      theaterState: new TheaterState.initial(),
      showState: new ShowState.initial(),
      eventState: new EventState.initial(),
    );
  }

  AppState copyWith({
    TheaterState theaterState,
    ShowState showState,
    EventState eventState,
  }) {
    return new AppState(
      theaterState: theaterState ?? this.theaterState,
      showState: showState ?? this.showState,
      eventState: eventState ?? this.eventState,
    );
  }
}
