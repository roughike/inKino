import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:inkino/models/actor.dart';
import 'package:inkino/models/event.dart';
import 'package:inkino/models/loading_status.dart';
import 'package:inkino/ui/common/info_message_view.dart';
import 'package:inkino/ui/common/loading_view.dart';
import 'package:inkino/ui/event_details/event_details_page.dart';
import 'package:inkino/ui/events/event_grid.dart';
import 'package:inkino/ui/events/events_page.dart';
import 'package:inkino/ui/events/events_page_view_model.dart';
import 'package:mockito/mockito.dart';

class MockEventsPageViewModel extends Mock implements EventsPageViewModel {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('EventGrid', () {
    final List<Event> events = <Event>[
      Event(
        id: '1',
        title: 'Test Title',
        genres: 'Test Genres',
        directors: <String>[],
        actors: <Actor>[],
        images: EventImageData.empty(),
        youtubeTrailers: <String>[],
      ),
    ];

    MockNavigatorObserver observer;
    EventsPageViewModel mockViewModel;

    setUp(() {
      observer = MockNavigatorObserver();
      mockViewModel = MockEventsPageViewModel();
      when(mockViewModel.refreshEvents).thenReturn(() {});
    });

    Future<Null> _buildEventsPage(WidgetTester tester) {
      return provideMockedNetworkImages(() {
        return tester.pumpWidget(
          MaterialApp(
            home: EventsPageContent(mockViewModel),
            navigatorObservers: <NavigatorObserver>[observer],
          ),
        );
      });
    }

    testWidgets(
      'when there are no events, should show empty view',
      (WidgetTester tester) async {
        when(mockViewModel.status).thenReturn(LoadingStatus.success);
        when(mockViewModel.events).thenReturn(<Event>[]);

        await _buildEventsPage(tester);

        expect(find.byKey(EventGrid.emptyViewKey), findsOneWidget);
        expect(find.byKey(EventGrid.contentKey), findsNothing);

        LoadingViewState state = tester.state(find.byType(LoadingView));
        expect(state.errorContentVisible, isFalse);
      },
    );

    testWidgets(
      'when events exist, should show them',
      (WidgetTester tester) async {
        when(mockViewModel.status).thenReturn(LoadingStatus.success);
        when(mockViewModel.events).thenReturn(events);

        await _buildEventsPage(tester);

        expect(find.byKey(EventGrid.contentKey), findsOneWidget);
        expect(find.byKey(EventGrid.emptyViewKey), findsNothing);
        expect(find.text('Test Title'), findsOneWidget);

        LoadingViewState state = tester.state(find.byType(LoadingView));
        expect(state.errorContentVisible, isFalse);
      },
    );

    testWidgets(
      'when tapping on an event poster, should navigate to event details',
      (WidgetTester tester) async {
        when(mockViewModel.status).thenReturn(LoadingStatus.success);
        when(mockViewModel.events).thenReturn(events);

        await _buildEventsPage(tester);

        // Building the events page should trigger the navigator observer
        // once.
        verify(observer.didPush(any, any));

        await tester.tap(find.text('Test Title'));
        await tester.pumpAndSettle();

        verify(observer.didPush(any, any));
        expect(find.byType(EventDetailsPage), findsOneWidget);
      },
    );

    testWidgets(
      'when clicking "try again" on the error view, should call refreshEvents on the view model',
      (WidgetTester tester) async {
        when(mockViewModel.status).thenReturn(LoadingStatus.error);
        when(mockViewModel.events).thenReturn(<Event>[]);

        await _buildEventsPage(tester);

        LoadingViewState state = tester.state(find.byType(LoadingView));
        expect(state.errorContentVisible, isTrue);

        await tester.tap(find.byKey(ErrorView.tryAgainButtonKey));
        verify(mockViewModel.refreshEvents);
      },
    );
  });
}
