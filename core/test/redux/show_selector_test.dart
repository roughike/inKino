import 'package:core/src/models/loading_status.dart';
import 'package:core/src/models/show.dart';
import 'package:core/src/models/show_cache.dart';
import 'package:core/src/models/theater.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:core/src/redux/show/show_selectors.dart';
import 'package:core/src/redux/show/show_state.dart';
import 'package:core/src/redux/theater/theater_state.dart';
import 'package:kt_dart/collection.dart';
import 'package:test/test.dart';

void main() {
  group('Show selectors', () {
    final firstShow =
        Show(id: 'first', title: 'First show', originalTitle: 'First show');
    final secondShow =
        Show(id: 'second', title: 'Second show', originalTitle: 'Second show');
    final showWithAnotherCacheKey = Show(id: 'show-with-another-cache-key');
    final shows = listOf(firstShow, secondShow);

    final theater = Theater(id: 'test', name: 'Test Theater');
    final date = DateTime(2018);
    final state = AppState.initial().copyWith(
      theaterState: TheaterState.initial().copyWith(
        currentTheater: theater,
      ),
      showState: ShowState.initial().copyWith(
        loadingStatus: LoadingStatus.success,
        selectedDate: date,
        shows: mapFrom({
          DateTheaterPair(date, theater): shows,
          DateTheaterPair(null, null): listOf(showWithAnotherCacheKey),
        }),
      ),
    );

    test('show by id', () {
      expect(showByIdSelector(state, 'first'), firstShow);
      expect(showByIdSelector(state, 'second'), secondShow);
      expect(showByIdSelector(state, 'null show'), isNull);
    });

    test('show by id - falls back to searching through all shows', () {
      /// When no shows found for current theater and date, should find a show
      /// from all available shows in the cache.
      expect(
        showByIdSelector(state, 'show-with-another-cache-key'),
        showWithAnotherCacheKey,
      );
    });

    test('shows without search query', () {
      expect(showsSelector(state), shows);

      /// When no shows found, should return empty show list instead of null.
      expect(showsSelector(AppState.initial()), emptyList());
    });

    test('shows with search query', () {
      final stateWithSearchQuery = state.copyWith(searchQuery: 'Sec');
      expect(showsSelector(stateWithSearchQuery), listOf(secondShow));

      /// When no shows found, should return empty show list instead of null.
      expect(
        showsSelector(
          stateWithSearchQuery.copyWith(
            showState: ShowState.initial().copyWith(
              shows: emptyMap(),
            ),
          ),
        ),
        emptyList(),
      );
    });

    test('showById - null', () {
      // If no crash, this is considered a passing test.
      expect(showByIdSelector(state, null), isNull);
    });
  });
}
