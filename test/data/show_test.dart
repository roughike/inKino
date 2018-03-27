import 'dart:io';

import 'package:inkino/data/show.dart';
import 'package:test/test.dart';

void main() {
  group('Show model', () {
    test('parsing test', () {
      var shows = new File('test_assets/schedule.xml').readAsStringSync();

      List<Show> deserialized = Show.parseAll(shows);
      expect(deserialized.length, 3);

      var jumanji = deserialized.first;
      expect(jumanji.id, '1155306');
      expect(jumanji.eventId, '302419');
      expect(jumanji.title, 'Jumanji: Welcome to the Jungle');
      expect(jumanji.originalTitle, 'Jumanji: Welcome to the Jungle (Original title)');
      expect(jumanji.url, 'http://www.finnkino.fi/websales/show/1155306/');
      expect(jumanji.presentationMethod, '2D');
      expect(jumanji.theaterAndAuditorium, 'Tennispalatsi, Helsinki, sali 6');
      expect(jumanji.start, new DateTime(2018, 02, 21, 10, 30));
      expect(jumanji.end, new DateTime(2018, 02, 21, 12, 39));
    });
  });
}