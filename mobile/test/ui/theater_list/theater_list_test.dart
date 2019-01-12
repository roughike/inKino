import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkino/ui/theater_list/theater_list.dart';
import 'package:kt_dart/collection.dart';
import 'package:mockito/mockito.dart';

class MockTheaterListViewModel extends Mock implements TheaterListViewModel {}

void main() {
  group('TheaterList', () {
    final theaters = listOf(
      Theater(id: '1', name: 'Test Theater #1'),
      Theater(id: '2', name: 'Test Theater #2'),
    );

    MockTheaterListViewModel mockViewModel;
    bool theaterTappedCallbackCalled;

    setUp(() {
      mockViewModel = MockTheaterListViewModel();
      when(mockViewModel.currentTheater).thenReturn(null);
      when(mockViewModel.theaters).thenReturn(emptyList());

      theaterTappedCallbackCalled = false;
    });

    Future<void> _buildTheaterList(WidgetTester tester) {
      return tester.pumpWidget(MaterialApp(
        home: TheaterListContent(
          onTheaterTapped: () {
            theaterTappedCallbackCalled = true;
          },
          viewModel: mockViewModel,
        ),
      ));
    }

    testWidgets(
      'when theaters exist, should show theam in the UI',
      (WidgetTester tester) async {
        when(mockViewModel.currentTheater).thenReturn(theaters.first());
        when(mockViewModel.theaters).thenReturn(theaters);

        await _buildTheaterList(tester);

        expect(find.text('Test Theater #1'), findsOneWidget);
        expect(find.text('Test Theater #2'), findsOneWidget);
      },
    );

    testWidgets(
      'when theater tapped, should call both changeCurrentTheater and onTheaterTapped',
      (WidgetTester tester) async {
        Theater theater;
        when(mockViewModel.currentTheater).thenReturn(theaters.first());
        when(mockViewModel.theaters).thenReturn(theaters);
        when(mockViewModel.changeCurrentTheater)
            .thenReturn((newTheater) => theater = newTheater);

        await _buildTheaterList(tester);
        await tester.tap(find.text('Test Theater #2'));

        expect(theater.id, '2');
        expect(theater.name, 'Test Theater #2');

        expect(theaterTappedCallbackCalled, isTrue);
      },
    );
  });
}
