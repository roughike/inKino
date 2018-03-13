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
    @required this.availableDates,
    @required this.selectedDate,
    @required this.shows,
    @required this.changeCurrentDate,
  });

  final LoadingStatus status;
  final List<ScheduleDate> availableDates;
  final ScheduleDate selectedDate;
  final List<Show> shows;
  final Function(ScheduleDate) changeCurrentDate;

  static ShowtimesPageViewModel fromStore(Store<AppState> store) {
    var shows = showsForTheaterSelector(
      store.state,
      store.state.theaterState.currentTheater,
    );

    return new ShowtimesPageViewModel(
      availableDates: store.state.showState.availableDates.take(7).toList(),
      selectedDate: store.state.showState.selectedDate,
      status: store.state.showState.loadingStatus,
      shows: shows,
      changeCurrentDate: (newDate) {
        store.dispatch(new ChangeCurrentDateAction(newDate));
      },
    );
  }
}
