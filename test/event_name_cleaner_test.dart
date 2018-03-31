import 'package:inkino/event_name_cleaner.dart';
import 'package:test/test.dart';

void main() {
  group('$EventNameCleaner', () {
    test('test', () {
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (2D)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (3D)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War 2D'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War 3D'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (dub)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (2D dub)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (3D dub)'), 'Avengers: Infinity War');
    });
  });
}