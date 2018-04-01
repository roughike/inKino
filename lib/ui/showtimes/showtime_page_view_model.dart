import 'package:inkino/data/models/show.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/loading_status.dart';
import 'package:inkino/redux/selectors.dart';
import 'package:inkino/redux/show/show_actions.dart';
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
    return new ShowtimesPageViewModel(
      selectedDate: store.state.showState.selectedDate,
      dates: store.state.showState.dates,
      status: store.state.showState.loadingStatus,
      shows: showsSelector(store.state),
      changeCurrentDate: (newDate) {
        store.dispatch(new ChangeCurrentDateAction(newDate));
      },
      refreshShowtimes: () => store.dispatch(new RefreshShowsAction()),
    );
  }
}
