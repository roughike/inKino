import 'package:inkino/models/actor.dart';
import 'package:inkino/models/event.dart';
import 'package:inkino/utils/event_name_cleaner.dart';
import 'package:inkino/utils/xml_utils.dart';
import 'package:xml/xml.dart' as xml;

class EventParser {
  static List<Event> parse(String xmlString) {
    var document = xml.parse(xmlString);
    var events = document.findAllElements('Event');

    return events.map((node) {
      var title = tagContents(node, 'Title');
      var originalTitle = tagContents(node, 'OriginalTitle');

      return Event(
        id: tagContents(node, 'ID'),
        title: EventNameCleaner.cleanup(title),
        originalTitle: EventNameCleaner.cleanup(originalTitle),
        productionYear: tagContents(node, 'ProductionYear'),
        genres: tagContents(node, 'Genres'),
        directors: _parseDirectors(node.findAllElements('Director')),
        actors: _parseActors(node.findAllElements('Actor')),
        lengthInMinutes: tagContents(node, 'LengthInMinutes'),
        shortSynopsis: tagContents(node, 'ShortSynopsis'),
        synopsis: tagContents(node, 'Synopsis'),
        images: EventImageDataParser.parse(node.findElements('Images')),
        youtubeTrailers: _parseTrailers(node.findAllElements('EventVideo')),
      );
    }).toList();
  }

  static List<String> _parseDirectors(Iterable<xml.XmlElement> nodes) {
    return nodes.map((node) {
      var first = tagContents(node, 'FirstName');
      var last = tagContents(node, 'LastName');

      return '$first $last';
    }).toList();
  }

  static List<Actor> _parseActors(Iterable<xml.XmlElement> nodes) {
    return nodes.map((node) {
      var first = tagContents(node, 'FirstName');
      var last = tagContents(node, 'LastName');

      return Actor(name: '$first $last');
    }).toList();
  }

  static List<String> _parseTrailers(Iterable<xml.XmlElement> nodes) {
    return nodes.map((node) {
      return 'https://youtube.com/watch?v=' + tagContents(node, 'Location');
    }).toList();
  }
}

class EventImageDataParser {
  static EventImageData parse(Iterable<xml.XmlElement> roots) {
    if (roots == null || roots.isEmpty) {
      return EventImageData.empty();
    }

    var root = roots.first;

    return EventImageData(
      portraitSmall: tagContentsOrNull(root, 'EventSmallImagePortrait'),
      portraitMedium: tagContentsOrNull(root, 'EventMediumImagePortrait'),
      portraitLarge: tagContentsOrNull(root, 'EventLargeImagePortrait'),
      landscapeSmall: tagContentsOrNull(root, 'EventSmallImageLandscape'),
      landscapeBig: tagContentsOrNull(root, 'EventLargeImageLandscape'),
    );
  }
}
