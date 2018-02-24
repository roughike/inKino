import 'dart:io';

import 'package:inkino/data/event.dart';
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
      expect(paris1517.genres, 'Draama, Jännitys');
      expect(
        paris1517.images.portraitSmall,
        'http://media.finnkino.fi/1012/Event_11881/portrait_small/The1517toParis_1080.jpg',
      );
    });
  });
}
