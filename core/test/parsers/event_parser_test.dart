import 'package:core/src/models/event.dart';
import 'package:core/src/parsers/event_parser.dart';
import 'package:kt_dart/collection.dart';
import 'package:test/test.dart';

import 'event_test_seeds.ignore.dart';

void main() {
  group('EventParser', () {
    test('parsing tests', () {
      KtList<Event> deserialized = EventParser.parse(eventsXml);
      expect(deserialized.size, 3);

      final paris1517 = deserialized.first();
      expect(paris1517.id, '302535');
      expect(paris1517.title, '15:17 Pariisiin');
      expect(paris1517.originalTitle, 'The 15:17 to Paris');
      expect(paris1517.releaseDate, DateTime(2018, 02, 16));
      expect(paris1517.ageRating, '12');
      expect(paris1517.ageRatingUrl,
          'https://inkino.imgix.net/images/rating_large_12.png?auto=format,compress');
      expect(paris1517.genres, 'Draama, Jännitys');
      expect(paris1517.directors.size, 1);
      expect(paris1517.directors.first(), 'Clint Eastwood');
      expect(paris1517.actors.size, 11);
      expect(paris1517.actors.first().name, 'Anthony Sadler');
      expect(paris1517.lengthInMinutes, '94');
      expect(paris1517.shortSynopsis, 'Short synopsis goes here.');
      expect(paris1517.synopsis, 'Synopsis goes here.');
      expect(paris1517.youtubeTrailers.size, 1);
      expect(paris1517.youtubeTrailers.first(),
          'https://youtube.com/watch?v=oFa4C6OcuM4');

      final images = paris1517.images;
      expect(
        images.portraitSmall,
        'https://inkino.imgix.net/1012/Event_11881/portrait_small/The1517toParis_1080.jpg?auto=format,compress',
      );
      expect(
        images.portraitMedium,
        'https://inkino.imgix.net/1012/Event_11881/portrait_medium/The1517toParis_1080.jpg?auto=format,compress',
      );
      expect(
        images.portraitLarge,
        'https://inkino.imgix.net/1012/Event_11881/portrait_large/The1517toParis_1080.jpg?auto=format,compress',
      );
      expect(
        images.landscapeSmall,
        'https://inkino.imgix.net/1012/Event_11881/landscape_small/The1517toParis_444.jpg?auto=format,compress',
      );
      expect(
        images.landscapeBig,
        'https://inkino.imgix.net/1012/Event_11881/landscape_large/BookClub_670_kke.jpg?auto=format,compress',
      );
      expect(
        images.landscapeHd,
        'https://inkino.imgix.net/1012/Event_11881/landscape_hd/BookClub_1920_kke_.jpg?auto=format,compress',
      );
      expect(
        images.landscapeHd2,
        'https://inkino.imgix.net/1012/Event_11881/landscape_hd/BookClub_1920_kke.jpg?auto=format,compress',
      );

      final contentDescriptors = paris1517.contentDescriptors;
      expect(contentDescriptors.size, 2);
      expect(contentDescriptors[0].name, 'Violence');
      expect(contentDescriptors[0].imageUrl,
          'https://inkino.imgix.net/images/content_Violence.png?auto=format,compress');

      final gallery = paris1517.galleryImages;
      expect(gallery.size, 8);
      expect(gallery.first().thumbnailLocation,
          'https://inkino.imgix.net/1012/Event_12007/gallery/THUMB_Adrift_800a.jpg?auto=format,compress');
      expect(gallery.first().location,
          'https://inkino.imgix.net/1012/Event_12007/gallery/Adrift_800a.jpg?auto=format,compress');

      expect(
        deserialized[1].ageRatingUrl,
        'https://inkino.imgix.net/images/rating_large_Tulossa.png?auto=format,compress',
      );

      expect(deserialized[1].actors, emptyList());
    });
  });
}
