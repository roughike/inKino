import 'package:inkino/data/theater.dart';
import 'package:test/test.dart';
import 'package:inkino/redux/selectors.dart';
import '../mocks.dart';
import '../test_utils.dart';

void main() {
  group('Selector tests', () {
    test('showsForTheaterSelector does not return null shows', () {
      var firstShow = new MockShow();
      var secondShow = new MockShow();
      var shows = showsForTheaterSelector(
        showState(
          allShowsById: {
            '1': firstShow,
            '2': null,
            '3': secondShow,
          },
          showIdsByTheaterId: {
            'test': ['1', '2', '3'],
          },
        ),
        new Theater(id: 'test', name: 'Test theater'),
      );

      expect(shows.length, 2);
      expect(shows[0], firstShow);
      expect(shows[1], secondShow);
    });
  });
}
