import 'package:core/src/utils/event_name_cleaner.dart';
import 'package:test/test.dart';

void main() {
  group('$EventNameCleaner', () {
    String cleanup(String noise) => EventNameCleaner.cleanup(noise);

    test('cleans up unneeded noise from movie names', () {
      expect(cleanup('Avengers: Infinity War (2D)'), 'Avengers: Infinity War');
      expect(cleanup('Avengers: Infinity War (3D)'), 'Avengers: Infinity War');
      expect(cleanup('Avengers: Infinity War 2D'), 'Avengers: Infinity War');
      expect(cleanup('Avengers: Infinity War 3D'), 'Avengers: Infinity War');
      expect(cleanup('Avengers: Infinity War (dub)'), 'Avengers: Infinity War');
      expect(cleanup('Avengers: Infinity War (2D dub)'), 'Avengers: Infinity War');
      expect(cleanup('Avengers: Infinity War (2D orig)'), 'Avengers: Infinity War');
      expect(cleanup('Avengers: Infinity War (2D spanish)'), 'Avengers: Infinity War');
      expect(cleanup('Avengers: Infinity War (2D) (dub)'), 'Avengers: Infinity War');
      expect(cleanup('Avengers: Infinity War (2D) (orig)'), 'Avengers: Infinity War');
      expect(cleanup('Avengers: Infinity War (2D) (spanish)'), 'Avengers: Infinity War');
      expect(cleanup('Avengers: Infinity War (3D dub)'), 'Avengers: Infinity War');
      expect(cleanup('Avengers: Infinity War (3D orig)'), 'Avengers: Infinity War');
      expect(cleanup('Avengers: Infinity War (3D spanish)'), 'Avengers: Infinity War');
      expect(cleanup('Avengers: Infinity War (swe)'), 'Avengers: Infinity War');
      expect(cleanup('Bohemian Rhapsody -erikoisnäytös'), 'Bohemian Rhapsody');
      expect(cleanup('Mamma Mia! Here We Go Again (SING-ALONG)'), 'Mamma Mia! Here We Go Again');
      expect(cleanup('Fantastic Beasts: The Crimes of Grindelwald - preview'), 'Fantastic Beasts: The Crimes of Grindelwald');

      // These should stay the same
      expect(cleanup('BPM (beats per minute)'), 'BPM (beats per minute)');
      expect(cleanup('That awesome spanish girl'), 'That awesome spanish girl');
      expect(cleanup('The 3D movie'), 'The 3D movie');
    });
  });
}
