import 'package:inkino/data/show.dart';
import 'package:meta/meta.dart';

@immutable
class ShowState {
  ShowState({
    @required this.allShowsById,
    @required this.showIdsByTheaterId,
  });

  final Map<String, Show> allShowsById;
  final Map<String, List<String>> showIdsByTheaterId;

  factory ShowState.initial() {
    return new ShowState(
      allShowsById: <String, Show>{},
      showIdsByTheaterId: <String, List<String>>{},
    );
  }

  ShowState copyWith({
    Map<String, Show> allShowsById,
    Map<String, List<String>> showIdsByTheaterId,
  }) {
    return new ShowState(
      allShowsById: allShowsById ?? this.allShowsById,
      showIdsByTheaterId: showIdsByTheaterId ?? this.showIdsByTheaterId,
    );
  }
}
