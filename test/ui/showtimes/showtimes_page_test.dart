import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkino/models/loading_status.dart';
import 'package:inkino/models/show.dart';
import 'package:inkino/ui/common/info_message_view.dart';
import 'package:inkino/ui/common/loading_view.dart';
import 'package:inkino/ui/showtimes/showtime_list.dart';
import 'package:inkino/ui/showtimes/showtime_page_view_model.dart';
import 'package:inkino/ui/showtimes/showtimes_page.dart';
import 'package:mockito/mockito.dart';

class MockShowtimesPageViewModel extends Mock
    implements ShowtimesPageViewModel {}

void main() {
  group('ShowtimesPage', () {
    MockShowtimesPageViewModel mockViewModel;

    setUp(() {
      mockViewModel = MockShowtimesPageViewModel();
      when(mockViewModel.status).thenReturn(LoadingStatus.loading);
      when(mockViewModel.dates).thenReturn(<DateTime>[]);
      when(mockViewModel.selectedDate).thenReturn(DateTime(2018));
      when(mockViewModel.shows).thenReturn(<Show>[]);
      when(mockViewModel.refreshShowtimes).thenReturn(() {});
    });

    Future<Null> _buildShowtimesPage(WidgetTester tester) {
      return tester.pumpWidget(
        MaterialApp(
          home: ShowtimesPageContent(mockViewModel),
        ),
      );
    }

    testWidgets(
      'when there are no shows, should show empty view',
      (WidgetTester tester) async {
        when(mockViewModel.status).thenReturn(LoadingStatus.success);
        when(mockViewModel.shows).thenReturn(<Show>[]);

        await _buildShowtimesPage(tester);

        expect(find.byKey(ShowtimeList.emptyViewKey), findsOneWidget);
        expect(find.byKey(ShowtimeList.contentKey), findsNothing);

        LoadingViewState state = tester.state(find.byType(LoadingView));
        expect(state.errorContentVisible, isFalse);
      },
    );

    testWidgets('when shows exist, should show them',
        (WidgetTester tester) async {
      when(mockViewModel.status).thenReturn(LoadingStatus.success);
      when(mockViewModel.shows).thenReturn(<Show>[
        Show(
          title: 'Show title',
          theaterAndAuditorium: 'Auditorium One',
          presentationMethod: '2D',
          start: DateTime(2018),
          end: DateTime(2018),
        ),
      ]);

      await _buildShowtimesPage(tester);

      expect(find.byKey(ShowtimeList.contentKey), findsOneWidget);
      expect(find.byKey(ShowtimeList.emptyViewKey), findsNothing);
      expect(find.text('Show title'), findsOneWidget);

      LoadingViewState state = tester.state(find.byType(LoadingView));
      expect(state.errorContentVisible, isFalse);
    });

    testWidgets(
      'when clicking "try again" on the error view, should call refreshShowtimes on the view model',
      (WidgetTester tester) async {
        when(mockViewModel.status).thenReturn(LoadingStatus.error);

        await _buildShowtimesPage(tester);

        LoadingViewState state = tester.state(find.byType(LoadingView));
        expect(state.errorContentVisible, isTrue);

        await tester.tap(find.byKey(ErrorView.tryAgainButtonKey));
        verify(mockViewModel.refreshShowtimes);
      },
    );
  });
}
