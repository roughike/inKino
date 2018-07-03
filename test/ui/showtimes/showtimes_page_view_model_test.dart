import 'package:inkino/models/loading_status.dart';
import 'package:inkino/models/show.dart';
import 'package:inkino/ui/showtimes/showtime_page_view_model.dart';
import 'package:test/test.dart';

void main() {
  group('ShowtimesPageViewModel', () {
    test('equal', () {
      var first = ShowtimesPageViewModel(
        status: LoadingStatus.success,
        dates: <DateTime>[DateTime(2018)],
        selectedDate: null,
        shows: <Show>[
          Show(id: 'abc123'),
        ],
        changeCurrentDate: (DateTime newDate) {},
        refreshShowtimes: () {},
      );

      var second = ShowtimesPageViewModel(
        status: LoadingStatus.success,
        dates: <DateTime>[DateTime(2018)],
        selectedDate: null,
        shows: <Show>[
          Show(id: 'abc123'),
        ],
        changeCurrentDate: (DateTime newDate) {},
        refreshShowtimes: () {},
      );

      expect(first, second);
    });

    test('not equal', () {
      var first = ShowtimesPageViewModel(
        status: LoadingStatus.success,
        dates: <DateTime>[DateTime(2018)],
        selectedDate: null,
        shows: <Show>[
          Show(id: 'abc123'),
        ],
        changeCurrentDate: (DateTime newDate) {},
        refreshShowtimes: () {},
      );

      var second = ShowtimesPageViewModel(
        status: LoadingStatus.success,
        dates: <DateTime>[DateTime(2018)],
        selectedDate: null,
        shows: <Show>[
          Show(id: 'xyz456'),
        ],
        changeCurrentDate: (DateTime newDate) {},
        refreshShowtimes: () {},
      );

      expect(first, isNot(second));
    });
  });
}