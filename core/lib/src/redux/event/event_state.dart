import 'package:core/src/models/event.dart';
import 'package:core/src/models/loading_status.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';

@immutable
class EventState {
  EventState({
    @required this.nowInTheatersStatus,
    @required this.nowInTheatersEvents,
    @required this.comingSoonStatus,
    @required this.comingSoonEvents,
  });

  final LoadingStatus nowInTheatersStatus;
  final KtList<Event> nowInTheatersEvents;
  final LoadingStatus comingSoonStatus;
  final KtList<Event> comingSoonEvents;

  factory EventState.initial() {
    return EventState(
      nowInTheatersStatus: LoadingStatus.idle,
      nowInTheatersEvents: emptyList(),
      comingSoonStatus: LoadingStatus.idle,
      comingSoonEvents: emptyList(),
    );
  }

  EventState copyWith({
    LoadingStatus nowInTheatersStatus,
    KtList<Event> nowInTheatersEvents,
    LoadingStatus comingSoonStatus,
    KtList<Event> comingSoonEvents,
  }) {
    return EventState(
      nowInTheatersStatus: nowInTheatersStatus ?? this.nowInTheatersStatus,
      comingSoonStatus: comingSoonStatus ?? this.comingSoonStatus,
      nowInTheatersEvents: nowInTheatersEvents ?? this.nowInTheatersEvents,
      comingSoonEvents: comingSoonEvents ?? this.comingSoonEvents,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventState &&
          runtimeType == other.runtimeType &&
          nowInTheatersStatus == other.nowInTheatersStatus &&
          comingSoonStatus == other.comingSoonStatus &&
          nowInTheatersEvents == other.nowInTheatersEvents &&
          comingSoonEvents == other.comingSoonEvents;

  @override
  int get hashCode =>
      nowInTheatersStatus.hashCode ^
      comingSoonStatus.hashCode ^
      nowInTheatersEvents.hashCode ^
      comingSoonEvents.hashCode;
}
