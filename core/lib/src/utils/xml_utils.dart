import 'package:xml/xml.dart' as xml;

String tagContents(xml.XmlElement node, String tagName) {
  final contents = tagContentsOrNull(node, tagName);

  if (contents == null) {
    throw ArgumentError('Contents for $tagName were unexpectedly null.');
  }

  return contents;
}

String tagContentsOrNull(xml.XmlElement node, String tagName) {
  final matches = node.findElements(tagName);

  if (matches.isNotEmpty) {
    return matches.single.text;
  }

  return null;
}