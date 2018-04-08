import 'package:inkino/data/loading_status.dart';
import 'package:inkino/data/models/event.dart';
import 'package:meta/meta.dart';

@immutable
class EventState {
  EventState({
    @required this.loadingStatus,
    @required this.nowInTheatersEvents,
    @required this.comingSoonEvents,
  });

  final LoadingStatus loadingStatus;
  final List<Event> nowInTheatersEvents;
  final List<Event> comingSoonEvents;

  factory EventState.initial() {
    return new EventState(
      loadingStatus: LoadingStatus.loading,
      nowInTheatersEvents: <Event>[],
      comingSoonEvents: <Event>[],
    );
  }

  EventState copyWith({
    LoadingStatus loadingStatus,
    List<Event> nowInTheatersEvents,
    List<Event> comingSoonEvents,
  }) {
    return new EventState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      nowInTheatersEvents: nowInTheatersEvents ?? this.nowInTheatersEvents,
      comingSoonEvents: comingSoonEvents ?? this.comingSoonEvents,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is EventState &&
              runtimeType == other.runtimeType &&
              loadingStatus == other.loadingStatus &&
              nowInTheatersEvents == other.nowInTheatersEvents &&
              comingSoonEvents == other.comingSoonEvents;

  @override
  int get hashCode =>
      loadingStatus.hashCode ^
      nowInTheatersEvents.hashCode ^
      comingSoonEvents.hashCode;
}
