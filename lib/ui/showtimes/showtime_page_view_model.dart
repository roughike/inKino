import 'package:inkino/data/show.dart';
import 'package:inkino/redux/app_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:inkino/redux/selectors.dart';

class ShowtimesPageViewModel {
  ShowtimesPageViewModel({
    @required this.shows,
  });

  final List<Show> shows;

  static ShowtimesPageViewModel fromStore(Store<AppState> store) {
    return new ShowtimesPageViewModel(
      shows: showsForTheaterSelector(
        store.state,
        store.state.theaterState.currentTheater,
      ),
    );
  }
}
