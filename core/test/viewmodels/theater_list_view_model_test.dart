import 'package:core/src/models/theater.dart';
import 'package:core/src/viewmodels/theater_list_view_model.dart';
import 'package:kt_dart/collection.dart';
import 'package:test/test.dart';

void main() {
  group('TheaterListViewModel', () {
    test('equal', () {
      final first = TheaterListViewModel(
        currentTheater: Theater(id: 'abc123', name: 'Test 1'),
        theaters: listOf(
          Theater(id: 'abc123', name: 'Test 1'),
          Theater(id: 'xyz456', name: 'Test 2'),
        ),
        changeCurrentTheater: (Theater newTheater) {},
      );

      final second = TheaterListViewModel(
        currentTheater: Theater(id: 'abc123', name: 'Test 1'),
        theaters: listOf(
          Theater(id: 'abc123', name: 'Test 1'),
          Theater(id: 'xyz456', name: 'Test 2'),
        ),
        changeCurrentTheater: (Theater newTheater) {},
      );

      expect(first, second);
    });

    test('not equal', () {
      final first = TheaterListViewModel(
        currentTheater: Theater(id: 'abc123', name: 'Test 1'),
        theaters: listOf(
          Theater(id: 'abc123', name: 'Test 1'),
          Theater(id: 'xyz456', name: 'Test 2'),
        ),
        changeCurrentTheater: (Theater newTheater) {},
      );

      final second = TheaterListViewModel(
        currentTheater: Theater(id: 'abc123', name: 'Test 1'),
        theaters: listOf(
          Theater(id: 'efg123', name: 'Test 3'),
          Theater(id: 'hjk456', name: 'Test 4'),
        ),
        changeCurrentTheater: (Theater newTheater) {},
      );

      expect(first, isNot(second));
    });
  });
}
