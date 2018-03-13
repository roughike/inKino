import 'package:inkino/data/schedule_date.dart';
import 'package:inkino/data/show.dart';
import 'package:inkino/redux/loading_status.dart';
import 'package:meta/meta.dart';

@immutable
class ShowState {
  ShowState({
    @required this.loadingStatus,
    @required this.availableDates,
    @required this.selectedDate,
    @required this.allShowsById,
    @required this.showIdsByTheaterId,
  });

  final LoadingStatus loadingStatus;
  final List<ScheduleDate> availableDates;
  final ScheduleDate selectedDate;
  final Map<String, Show> allShowsById;
  final Map<String, List<String>> showIdsByTheaterId;

  factory ShowState.initial() {
    return new ShowState(
      loadingStatus: LoadingStatus.loading,
      availableDates: <ScheduleDate>[],
      selectedDate: null,
      allShowsById: <String, Show>{},
      showIdsByTheaterId: <String, List<String>>{},
    );
  }

  ShowState copyWith({
    LoadingStatus loadingStatus,
    List<ScheduleDate> availableDates,
    ScheduleDate selectedDate,
    Map<String, Show> allShowsById,
    Map<String, List<String>> showIdsByTheaterId,
  }) {
    return new ShowState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      availableDates: availableDates ?? this.availableDates,
      selectedDate: selectedDate ?? this.selectedDate,
      allShowsById: allShowsById ?? this.allShowsById,
      showIdsByTheaterId: showIdsByTheaterId ?? this.showIdsByTheaterId,
    );
  }
}
