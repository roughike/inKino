import 'package:inkino/models/theater.dart';
import 'package:inkino/ui/theater_list/theater_list_view_model.dart';
import 'package:test/test.dart';

void main() {
  group('TheaterListViewModel', () {
    test('equal', () {
      var first = TheaterListViewModel(
        currentTheater: Theater(id: 'abc123', name: 'Test 1'),
        theaters: <Theater>[
          Theater(id: 'abc123', name: 'Test 1'),
          Theater(id: 'xyz456', name: 'Test 2'),
        ],
        changeCurrentTheater: (Theater newTheater) {},
      );

      var second = TheaterListViewModel(
        currentTheater: Theater(id: 'abc123', name: 'Test 1'),
        theaters: <Theater>[
          Theater(id: 'abc123', name: 'Test 1'),
          Theater(id: 'xyz456', name: 'Test 2'),
        ],
        changeCurrentTheater: (Theater newTheater) {},
      );

      expect(first, second);
    });

    test('not equal', () {
      var first = TheaterListViewModel(
        currentTheater: Theater(id: 'abc123', name: 'Test 1'),
        theaters: <Theater>[
          Theater(id: 'abc123', name: 'Test 1'),
          Theater(id: 'xyz456', name: 'Test 2'),
        ],
        changeCurrentTheater: (Theater newTheater) {},
      );

      var second = TheaterListViewModel(
        currentTheater: Theater(id: 'abc123', name: 'Test 1'),
        theaters: <Theater>[
          Theater(id: 'efg123', name: 'Test 3'),
          Theater(id: 'hjk456', name: 'Test 4'),
        ],
        changeCurrentTheater: (Theater newTheater) {},
      );

      expect(first, isNot(second));
    });
  });
}
