import 'package:core/src/models/loading_status.dart';
import 'package:core/src/models/show.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:core/src/redux/show/show_actions.dart';
import 'package:core/src/redux/show/show_selectors.dart';
import 'package:kt_dart/collection.dart';
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
  final KtList<DateTime> dates;
  final DateTime selectedDate;
  final KtList<Show> shows;
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
          dates == other.dates &&
          selectedDate == other.selectedDate &&
          shows == other.shows;

  @override
  int get hashCode =>
      status.hashCode ^ dates.hashCode ^ selectedDate.hashCode ^ shows.hashCode;
}
