import 'package:core/src/models/event.dart';
import 'package:core/src/networking/image_url_rewriter.dart';
import 'package:core/src/utils/xml_utils.dart';
import 'package:kt_dart/collection.dart';
import 'package:xml/xml.dart';

class GalleryParser {
  static KtList<GalleryImage> parse(Iterable<XmlElement> roots) {
    if (roots == null || roots.isEmpty) {
      return emptyList();
    }

    var galleryImage = listFrom(roots).first().findElements('GalleryImage');
    return listFrom(galleryImage).map((node) {
      return GalleryImage(
        thumbnailLocation:
            rewriteImageUrl(tagContents(node, 'ThumbnailLocation')),
        location: rewriteImageUrl(tagContents(node, 'Location')),
      );
    });
  }
}
