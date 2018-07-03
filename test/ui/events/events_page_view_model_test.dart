import 'package:inkino/models/event.dart';
import 'package:inkino/models/loading_status.dart';
import 'package:inkino/ui/events/events_page_view_model.dart';
import 'package:test/test.dart';

void main() {
  group('EventsPageViewModel', () {
    test('equal', () {
      var first = EventsPageViewModel(
        status: LoadingStatus.success,
        events: <Event>[
          Event(id: 'abc123'),
        ],
        refreshEvents: () {},
      );

      var second = EventsPageViewModel(
        status: LoadingStatus.success,
        events: <Event>[
          Event(id: 'abc123'),
        ],
        refreshEvents: () {},
      );

      expect(first, second);
    });

    test('not equal', () {
      var first = EventsPageViewModel(
        status: LoadingStatus.success,
        events: <Event>[
          Event(id: 'abc123'),
        ],
        refreshEvents: () {},
      );

      var second = EventsPageViewModel(
        status: LoadingStatus.success,
        events: <Event>[
          Event(id: 'xyz456'),
        ],
        refreshEvents: () {},
      );

      expect(first, isNot(second));
    });
  });
}
