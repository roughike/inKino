import 'package:inkino/data/show.dart';
import 'package:meta/meta.dart';

@immutable
class ShowState {
  ShowState({
    @required this.showsById,
    @required this.showIdsByTheaterId,
  });

  final Map<String, Show> showsById;
  final Map<String, List<String>> showIdsByTheaterId;

  factory ShowState.initial() {
    return new ShowState(
      showsById: <String, Show>{},
      showIdsByTheaterId: <String, List<String>>{},
    );
  }

  ShowState copyWith({
    Map<String, Show> showsById,
    Map<String, List<String>> showIdsByTheaterId,
  }) {
    return new ShowState(
      showsById: showsById ?? this.showsById,
      showIdsByTheaterId: showIdsByTheaterId ?? this.showIdsByTheaterId,
    );
  }
}
