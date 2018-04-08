import 'package:inkino/data/loading_status.dart';
import 'package:inkino/data/models/show.dart';
import 'package:inkino/utils/clock.dart';
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
    // TODO: Refactor this to a possibly more appropriate place, but where?
    var now = Clock.getCurrentTime();
    var dates = new List.generate(
      7,
      (index) => now.add(new Duration(days: index)),
    );

    return new ShowState(
      loadingStatus: LoadingStatus.loading,
      dates: dates,
      selectedDate: dates.first,
      shows: <Show>[],
    );
  }

  ShowState copyWith({
    LoadingStatus loadingStatus,
    List<DateTime> availableDates,
    DateTime selectedDate,
    List<Show> shows,
  }) {
    return new ShowState(
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
