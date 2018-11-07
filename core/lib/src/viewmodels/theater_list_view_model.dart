import 'package:collection/collection.dart';
import 'package:core/src/models/theater.dart';
import 'package:core/src/redux/_common/common_actions.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:core/src/redux/theater/theater_selectors.dart';
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
    return TheaterListViewModel(
      currentTheater: currentTheaterSelector(store.state),
      theaters: theatersSelector(store.state),
      changeCurrentTheater: (theater) {
        store.dispatch(ChangeCurrentTheaterAction(theater));
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TheaterListViewModel &&
          runtimeType == other.runtimeType &&
          currentTheater == other.currentTheater &&
          const IterableEquality().equals(theaters, other.theaters);

  @override
  int get hashCode =>
      currentTheater.hashCode ^ const IterableEquality().hash(theaters);
}
