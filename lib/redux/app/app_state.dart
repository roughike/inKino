import 'package:inkino/models/actor.dart';
import 'package:inkino/redux/event/event_state.dart';
import 'package:inkino/redux/show/show_state.dart';
import 'package:inkino/redux/theater/theater_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  AppState({
    @required this.searchQuery,
    @required this.actorsByName,
    @required this.theaterState,
    @required this.showState,
    @required this.eventState,
  });

  final String searchQuery;
  final Map<String, Actor> actorsByName;
  final TheaterState theaterState;
  final ShowState showState;
  final EventState eventState;

  factory AppState.initial() {
    return AppState(
      searchQuery: null,
      actorsByName: <String, Actor>{},
      theaterState: TheaterState.initial(),
      showState: ShowState.initial(),
      eventState: EventState.initial(),
    );
  }

  AppState copyWith({
    String searchQuery,
    Map<String, Actor> actorsByName,
    TheaterState theaterState,
    ShowState showState,
    EventState eventState,
  }) {
    return AppState(
      searchQuery: searchQuery ?? this.searchQuery,
      actorsByName: actorsByName ?? this.actorsByName,
      theaterState: theaterState ?? this.theaterState,
      showState: showState ?? this.showState,
      eventState: eventState ?? this.eventState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              searchQuery == other.searchQuery &&
              actorsByName == other.actorsByName &&
              theaterState == other.theaterState &&
              showState == other.showState &&
              eventState == other.eventState;

  @override
  int get hashCode =>
      searchQuery.hashCode ^
      actorsByName.hashCode ^
      theaterState.hashCode ^
      showState.hashCode ^
      eventState.hashCode;
}
