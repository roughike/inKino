import 'package:meta/meta.dart';
import 'package:xml/xml.dart' as xml;

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
        id: node.findElements('ID').single.text,
        title: node.findElements('Title').single.text,
        genres: node.findElements('Genres').single.text,
        images: new EventImageData.empty() // EventImageData.parseAll(node.findElements('Images')),
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

  EventImageData.empty() :
      portraitSmall = null,
    portraitMedium = null,
    portraitLarge = null,
    landscapeSmall = null,
  landscapeBig = null;

  static EventImageData parseAll(Iterable<xml.XmlElement> roots) {
    if (roots == null || roots.isEmpty) return new EventImageData.empty();

    var root = roots.first;

    return new EventImageData(
      portraitSmall: root.findElements('EventSmallImagePortrait').single.text,
      portraitMedium: root.findElements('EventMediumImagePortrait').single.text,
      portraitLarge: root.findElements('EventLargeImagePortrait').single.text,
      landscapeSmall: root.findElements('EventSmallImageLandscape').single.text,
      landscapeBig: root.findElements('EventLargeImageLandscape').single.text,
    );
  }
}
