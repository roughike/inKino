import 'package:meta/meta.dart';
import 'package:xml/xml.dart' as xml;
import 'package:inkino/utils.dart';

class Event {
  Event({
    @required this.id,
    @required this.title,
    @required this.genres,
    @required this.images,
  });

  final String id;
  final String title;
  final String genres;
  final EventImageData images;

  static List<Event> parseAll(String xmlString) {
    var events = <Event>[];
    var document = xml.parse(xmlString);

    document.findAllElements('Event').forEach((node) {
      events.add(new Event(
        id: tagContents(node, 'ID'),
        title: tagContents(node, 'Title'),
        genres: tagContents(node, 'Genres'),
        images: EventImageData.parseAll(node.findElements('Images')),
      ));
    });

    return events;
  }
}

class EventImageData {
  EventImageData({
    @required this.portraitSmall,
    @required this.portraitMedium,
    @required this.portraitLarge,
    @required this.landscapeSmall,
    @required this.landscapeBig,
  });

  final String portraitSmall;
  final String portraitMedium;
  final String portraitLarge;
  final String landscapeSmall;
  final String landscapeBig;

  EventImageData.empty()
      : portraitSmall = null,
        portraitMedium = null,
        portraitLarge = null,
        landscapeSmall = null,
        landscapeBig = null;

  static EventImageData parseAll(Iterable<xml.XmlElement> roots) {
    if (roots == null || roots.isEmpty) {
      return new EventImageData.empty();
    }

    var root = roots.first;

    return new EventImageData(
      portraitSmall: tagContentsOrNull(root, 'EventSmallImagePortrait'),
      portraitMedium: tagContentsOrNull(root, 'EventMediumImagePortrait'),
      portraitLarge: tagContentsOrNull(root, 'EventLargeImagePortrait'),
      landscapeSmall: tagContentsOrNull(root, 'EventSmallImageLandscape'),
      landscapeBig: tagContentsOrNull(root, 'EventLargeImageLandscape'),
    );
  }
}
