import 'package:core/src/models/show.dart';
import 'package:core/src/parsers/show_parser.dart';
import 'package:kt_dart/collection.dart';
import 'package:test/test.dart';

import 'show_test_seeds.ignore.dart';

void main() {
  group('ShowParser', () {
    test('parsing test', () {
      KtList<Show> deserialized = ShowParser.parse(showsXml);
      expect(deserialized.size, 3);

      final jumanji = deserialized.first();
      expect(jumanji.id, '1155306');
      expect(jumanji.eventId, '302419');
      expect(jumanji.title, 'Jumanji: Welcome to the Jungle');
      expect(jumanji.originalTitle,
          'Jumanji: Welcome to the Jungle (This is the original title)');
      expect(jumanji.ageRating, '12');
      expect(jumanji.ageRatingUrl,
          'https://inkino.imgix.net/images/rating_large_12.png?auto=format,compress');
      expect(jumanji.url, 'http://www.finnkino.fi/websales/show/1155306/');
      expect(jumanji.presentationMethod, '2D');
      expect(jumanji.theaterAndAuditorium, 'Tennispalatsi, Helsinki, sali 6');
      expect(jumanji.start, new DateTime(2018, 02, 21, 10, 30));
      expect(jumanji.end, new DateTime(2018, 02, 21, 12, 39));

      final images = jumanji.images;
      expect(
        images.portraitSmall,
        'https://inkino.imgix.net/1012/Event_11765/portrait_small/Jumanji_1080u.jpg?auto=format,compress',
      );
      expect(
        images.portraitMedium,
        'https://inkino.imgix.net/1012/Event_11765/portrait_medium/Jumanji_1080u.jpg?auto=format,compress',
      );
      expect(
        images.portraitLarge,
        'https://inkino.imgix.net/1012/Event_11765/portrait_small/Jumanji_1080u.jpg?auto=format,compress',
      );
      expect(
        images.landscapeSmall,
        'https://inkino.imgix.net/1012/Event_11765/landscape_small/Jumanji_444.jpg?auto=format,compress',
      );
      expect(
        images.landscapeBig,
        'https://inkino.imgix.net/1012/Event_11765/landscape_large/Jumanji_670.jpg?auto=format,compress',
      );
      expect(
        images.landscapeHd,
        'https://inkino.imgix.net/1012/Event_11765/landscape_hd/Jumanji_1920_.jpg?auto=format,compress',
      );
      expect(
        images.landscapeHd2,
        'https://inkino.imgix.net/1012/Event_11765/landscape_hd/Jumanji_1920.jpg?auto=format,compress',
      );

      final contentDescriptors = jumanji.contentDescriptors;
      expect(contentDescriptors.size, 2);
      expect(contentDescriptors[0].name, 'Violence');
      expect(contentDescriptors[0].imageUrl,
          'https://inkino.imgix.net/images/content_Violence.png?auto=format,compress');
    });
  });
}
