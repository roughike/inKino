import 'package:core/src/redux/_common/search.dart';
import 'package:test/test.dart';

void main() {
  group('searchQueryReducer', () {
    test('search reducer tests', () {
      final state = null;
      final reducedState =
          searchQueryReducer(state, SearchQueryChangedAction('test'));

      expect(reducedState, 'test');
    });
  });
}
