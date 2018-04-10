import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkino/data/loading_status.dart';
import 'package:inkino/data/models/actor.dart';
import 'package:inkino/data/models/event.dart';
import 'package:inkino/ui/common/info_message_view.dart';
import 'package:inkino/ui/common/loading_view.dart';
import 'package:inkino/ui/event_details/event_details_page.dart';
import 'package:inkino/ui/events/event_grid.dart';
import 'package:inkino/ui/events/events_page.dart';
import 'package:inkino/ui/events/events_page_view_model.dart';
import 'package:mockito/mockito.dart';

import '../../test_utils.dart';

class MockEventsPageViewModel extends Mock implements EventsPageViewModel {}

class NavigatorPushObserver extends NavigatorObserver {
  Route<dynamic> lastPushedRoute;

  void reset() => lastPushedRoute = null;

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    lastPushedRoute = route;
  }
}

void main() {
  group('EventGrid', () {
    final List<Event> events = <Event>[
      new Event(
        id: '1',
        title: 'Test Title',
        genres: 'Test Genres',
        directors: <String>[],
        actors: <Actor>[],
        images: new EventImageData.empty(),
        youtubeTrailers: <String>[],
      ),
    ];

    NavigatorPushObserver observer;
    EventsPageViewModel mockViewModel;

    setUp(() {
      io.HttpOverrides.global = new TestHttpOverrides();

      observer = new NavigatorPushObserver();
      mockViewModel = new MockEventsPageViewModel();
      when(mockViewModel.refreshEvents).thenReturn(() {});
    });

    Future<Null> _buildEventsPage(WidgetTester tester) {
      return tester.pumpWidget(new MaterialApp(
        home: new EventsPageContent(mockViewModel),
        navigatorObservers: <NavigatorObserver>[observer],
      ));
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

        // Building the events page makes the last pushed route non-null,
        // so we'll reset at this point.
        observer.reset();
        expect(observer.lastPushedRoute, isNull);

        await tester.tap(find.text('Test Title'));
        await tester.pumpAndSettle();

        expect(observer.lastPushedRoute, isNotNull);
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
