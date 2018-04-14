import 'package:inkino/data/models/theater.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/theater/theater_selectors.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class TheaterListViewModel {
  TheaterListViewModel({
    @required this.currentTheater,
    @required this.theaters,
    @required this.changeCurrentTheater,
  });

  final Theater currentTheater;
  final List<Theater> theaters;
  final Function(Theater) changeCurrentTheater;

  static TheaterListViewModel fromStore(Store<AppState> store) {
    return new TheaterListViewModel(
      currentTheater: currentTheaterSelector(store.state),
      theaters: theatersSelector(store.state),
      changeCurrentTheater: (theater) {
        store.dispatch(new ChangeCurrentTheaterAction(theater));
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TheaterListViewModel &&
          runtimeType == other.runtimeType &&
          currentTheater == other.currentTheater &&
          theaters == other.theaters &&
          changeCurrentTheater == other.changeCurrentTheater;

  @override
  int get hashCode =>
      currentTheater.hashCode ^
      theaters.hashCode ^
      changeCurrentTheater.hashCode;
}
