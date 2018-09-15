import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkino/ui/showtimes/showtime_date_selector.dart';
import 'package:inkino/ui/showtimes/showtime_page_view_model.dart';
import 'package:mockito/mockito.dart';

class MockShowtimesPageViewModel extends Mock
    implements ShowtimesPageViewModel {}

void main() {
  group('ShowtimeDateSelector', () {
    final List<DateTime> dates = <DateTime>[
      DateTime(2018, 1, 1),
      DateTime(2018, 1, 2),
    ];

    MockShowtimesPageViewModel mockViewModel;

    setUp(() {
      mockViewModel = MockShowtimesPageViewModel();
    });

    Future<Null> _buildDateSelector(WidgetTester tester) {
      return tester.pumpWidget(MaterialApp(
        home: ShowtimeDateSelector(mockViewModel),
      ));
    }

    testWidgets(
      'when there are dates, should show them in UI',
      (WidgetTester tester) async {
        when(mockViewModel.dates).thenReturn(dates);

        await _buildDateSelector(tester);

        // Monday is the first day of 2018.
        expect(find.text('Mon'), findsOneWidget);
        expect(find.text('Tue'), findsOneWidget);
      },
    );

    testWidgets(
      'when tapping a date, calls changeCurrentDate on the viewmodel with new date',
      (WidgetTester tester) async {
        DateTime date;

        when(mockViewModel.dates).thenReturn(dates);
        when(mockViewModel.changeCurrentDate).thenReturn((newDate) => date = newDate);

        await _buildDateSelector(tester);
        await tester.tap(find.text('Tue'));

        expect(date.year, 2018);
        expect(date.month, 1);
        expect(date.day, 2);
      },
    );
  });
}
