import 'package:inkino/data/show.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/loading_status.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:inkino/redux/selectors.dart';

class ShowtimesPageViewModel {
  ShowtimesPageViewModel({
    @required this.status,
    @required this.shows,
  });

  final LoadingStatus status;
  final List<Show> shows;

  static ShowtimesPageViewModel fromStore(Store<AppState> store) {
    var shows = showsForTheaterSelector(
      store.state,
      store.state.theaterState.currentTheater,
    );

    return new ShowtimesPageViewModel(
      status: shows.isEmpty? LoadingStatus.loading : LoadingStatus.success,
      shows: shows,
    );
  }
}
