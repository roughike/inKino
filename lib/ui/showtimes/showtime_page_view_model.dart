import 'package:inkino/data/schedule_date.dart';
import 'package:inkino/data/show.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/loading_status.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:inkino/redux/selectors.dart';

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
      shows: store.state.showState.shows,
      changeCurrentDate: (newDate) {
        store.dispatch(new ChangeCurrentDateAction(newDate));
      },
      refreshShowtimes: () => store.dispatch(new RefreshShowsAction()),
    );
  }
}
