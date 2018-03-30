import 'dart:io';

import 'package:inkino/data/models/event.dart';
import 'package:test/test.dart';

void main() {
  group('Event model', () {
    test('parsing tests', () {
      var events = new File('test_assets/events.xml').readAsStringSync();

      List<Event> deserialized = Event.parseAll(events);
      expect(deserialized.length, 3);

      var paris1517 = deserialized.first;
      expect(paris1517.id, '302535');
      expect(paris1517.title, '15:17 Pariisiin');
      expect(paris1517.originalTitle, 'The 15:17 to Paris');
      expect(paris1517.genres, 'Draama, Jännitys');
      expect(paris1517.directors.length, 1);
      expect(paris1517.directors.first, 'Clint Eastwood');
      expect(paris1517.actors.length, 11);
      expect(paris1517.actors.first, 'Anthony Sadler');
      expect(paris1517.lengthInMinutes, '94');
      expect(paris1517.shortSynopsis, 'Short synopsis goes here.');
      expect(paris1517.synopsis, 'Synopsis goes here.');
      expect(paris1517.youtubeTrailers.length, 1);
      expect(paris1517.youtubeTrailers.first, 'https://youtube.com/watch?v=oFa4C6OcuM4');
      expect(
        paris1517.images.portraitSmall,
        'http://media.finnkino.fi/1012/Event_11881/portrait_small/The1517toParis_1080.jpg',
      );
    });
  });
}
