import 'package:core/src/models/content_descriptor.dart';
import 'package:core/src/networking/image_url_rewriter.dart';
import 'package:core/src/utils/xml_utils.dart';
import 'package:xml/xml.dart';

class ContentDescriptorParser {
  static List<ContentDescriptor> parse(Iterable<XmlElement> roots) {
    if (roots == null) {
      return [];
    }

    return roots.first.findElements('ContentDescriptor').map((element) {
      return ContentDescriptor(
        name: tagContentsOrNull(element, 'Name'),
        imageUrl: rewriteImageUrl(tagContentsOrNull(element, 'ImageURL')),
      );
    }).toList();
  }
}
