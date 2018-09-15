import 'package:collection/collection.dart';
import 'package:inkino/models/loading_status.dart';
import 'package:inkino/models/show.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/show/show_actions.dart';
import 'package:inkino/redux/show/show_selectors.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class ShowtimesPageViewModel {
  ShowtimesPageViewModel({
    @required this.status,
    @required this.dates,
    @required this.selectedDate,
    @required this.shows,
    @required this.changeCurrentDate,
    @required this.refreshShowtimes,
  });

  final LoadingStatus status;
  final List<DateTime> dates;
  final DateTime selectedDate;
  final List<Show> shows;
  final Function(DateTime) changeCurrentDate;
  final Function refreshShowtimes;

  static ShowtimesPageViewModel fromStore(Store<AppState> store) {
    return ShowtimesPageViewModel(
      selectedDate: store.state.showState.selectedDate,
      dates: store.state.showState.dates,
      status: store.state.showState.loadingStatus,
      shows: showsSelector(store.state),
      changeCurrentDate: (newDate) {
        store.dispatch(ChangeCurrentDateAction(newDate));
      },
      refreshShowtimes: () => store.dispatch(RefreshShowsAction()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShowtimesPageViewModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          const IterableEquality().equals(dates, other.dates) &&
          selectedDate == other.selectedDate &&
          const IterableEquality().equals(shows, other.shows);

  @override
  int get hashCode =>
      status.hashCode ^
      const IterableEquality().hash(dates) ^
      selectedDate.hashCode ^
      const IterableEquality().hash(shows);
}
