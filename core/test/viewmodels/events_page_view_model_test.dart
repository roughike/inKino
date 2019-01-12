import 'package:core/src/models/event.dart';
import 'package:core/src/models/loading_status.dart';
import 'package:core/src/viewmodels/events_page_view_model.dart';
import 'package:kt_dart/collection.dart';
import 'package:test/test.dart';

void main() {
  group('EventsPageViewModel', () {
    test('equal', () {
      final first = EventsPageViewModel(
        status: LoadingStatus.success,
        events: listOf(
          Event(id: 'abc123'),
        ),
        refreshEvents: () {},
      );

      final second = EventsPageViewModel(
        status: LoadingStatus.success,
        events: listOf(
          Event(id: 'abc123'),
        ),
        refreshEvents: () {},
      );

      expect(first, second);
    });

    test('not equal', () {
      final first = EventsPageViewModel(
        status: LoadingStatus.success,
        events: listOf(
          Event(id: 'abc123'),
        ),
        refreshEvents: () {},
      );

      final second = EventsPageViewModel(
        status: LoadingStatus.success,
        events: listOf(
          Event(id: 'xyz456'),
        ),
        refreshEvents: () {},
      );

      expect(first, isNot(second));
    });
  });
}
