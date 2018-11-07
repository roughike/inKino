import 'package:core/src/networking/image_url_rewriter.dart';
import 'package:test/test.dart';

void main() {
  group('ImgixUrlRewriter', () {
    test('url rewriting tests', () {
      expect(
        rewriteImageUrl(
          'http://media.finnkino.fi/1012/Event_11960/gallery/THUMB_AntManAndTheWasp_1200d.jpg',
        ),
        'https://inkino.imgix.net/1012/Event_11960/gallery/THUMB_AntManAndTheWasp_1200d.jpg?auto=format,compress',
      );

      expect(
        rewriteImageUrl(
          'https://media.finnkino.fi/1012/Event_11960/gallery/THUMB_AntManAndTheWasp_1200d.jpg',
        ),
        'https://inkino.imgix.net/1012/Event_11960/gallery/THUMB_AntManAndTheWasp_1200d.jpg?auto=format,compress',
      );

      expect(rewriteImageUrl(null), null);
      expect(
        rewriteImageUrl('Not yet rated'),
        'https://inkino.imgix.net/images/rating_large_Tulossa.png?auto=format,compress',
      );
      expect(
        rewriteImageUrl('https://media.finnkino.fi/images/rating_large_Not%20yet%20rated.png'),
        'https://inkino.imgix.net/images/rating_large_Tulossa.png?auto=format,compress',
      );
    });
  });
}
