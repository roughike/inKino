import 'package:core/src/models/loading_status.dart';
import 'package:core/src/models/show.dart';
import 'package:core/src/viewmodels/showtime_page_view_model.dart';
import 'package:test/test.dart';

void main() {
  group('ShowtimesPageViewModel', () {
    test('equal', () {
      final first = ShowtimesPageViewModel(
        status: LoadingStatus.success,
        dates: [DateTime(2018)],
        selectedDate: null,
        shows: [
          Show(id: 'abc123'),
        ],
        changeCurrentDate: (DateTime newDate) {},
        refreshShowtimes: () {},
      );

      final second = ShowtimesPageViewModel(
        status: LoadingStatus.success,
        dates: [DateTime(2018)],
        selectedDate: null,
        shows: [
          Show(id: 'abc123'),
        ],
        changeCurrentDate: (DateTime newDate) {},
        refreshShowtimes: () {},
      );

      expect(first, second);
    });

    test('not equal', () {
      final first = ShowtimesPageViewModel(
        status: LoadingStatus.success,
        dates: [DateTime(2018)],
        selectedDate: null,
        shows: [
          Show(id: 'abc123'),
        ],
        changeCurrentDate: (DateTime newDate) {},
        refreshShowtimes: () {},
      );

      final second = ShowtimesPageViewModel(
        status: LoadingStatus.success,
        dates: [DateTime(2018)],
        selectedDate: null,
        shows: [
          Show(id: 'xyz456'),
        ],
        changeCurrentDate: (DateTime newDate) {},
        refreshShowtimes: () {},
      );

      expect(first, isNot(second));
    });
  });
}
