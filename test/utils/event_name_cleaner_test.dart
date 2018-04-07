import 'package:inkino/utils/event_name_cleaner.dart';
import 'package:test/test.dart';

void main() {
  group('$EventNameCleaner', () {
    test('cleans up unneeded noise from movie names', () {
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (2D)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (3D)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War 2D'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War 3D'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (dub)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (2D dub)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (2D orig)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (2D spanish)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (2D) (dub)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (2D) (orig)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (2D) (spanish)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (3D dub)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (3D orig)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (3D spanish)'), 'Avengers: Infinity War');
      expect(EventNameCleaner.cleanup('Avengers: Infinity War (swe)'), 'Avengers: Infinity War');

      // These should stay the same
      expect(EventNameCleaner.cleanup('BPM (beats per minute)'), 'BPM (beats per minute)');
      expect(EventNameCleaner.cleanup('That awesome spanish girl'), 'That awesome spanish girl');
      expect(EventNameCleaner.cleanup('The 3D movie'), 'The 3D movie');
    });
  });
}