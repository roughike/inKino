import 'package:inkino/models/loading_status.dart';
import 'package:inkino/models/show.dart';
import 'package:meta/meta.dart';

@immutable
class ShowState {
  ShowState({
    @required this.loadingStatus,
    @required this.dates,
    @required this.selectedDate,
    @required this.shows,
  });

  final LoadingStatus loadingStatus;
  final List<DateTime> dates;
  final DateTime selectedDate;
  final List<Show> shows;

  factory ShowState.initial() {
    return ShowState(
      loadingStatus: LoadingStatus.loading,
      dates: <DateTime>[],
      selectedDate: null,
      shows: <Show>[],
    );
  }

  ShowState copyWith({
    LoadingStatus loadingStatus,
    List<DateTime> availableDates,
    DateTime selectedDate,
    List<Show> shows,
  }) {
    return ShowState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      dates: availableDates ?? this.dates,
      selectedDate: selectedDate ?? this.selectedDate,
      shows: shows ?? this.shows,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ShowState &&
              runtimeType == other.runtimeType &&
              loadingStatus == other.loadingStatus &&
              dates == other.dates &&
              selectedDate == other.selectedDate &&
              shows == other.shows;

  @override
  int get hashCode =>
      loadingStatus.hashCode ^
      dates.hashCode ^
      selectedDate.hashCode ^
      shows.hashCode;
}
