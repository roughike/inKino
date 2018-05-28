import 'package:inkino/data/models/actor.dart';
import 'package:inkino/utils/event_name_cleaner.dart';
import 'package:inkino/utils/xml_utils.dart';
import 'package:meta/meta.dart';
import 'package:xml/xml.dart' as xml;

enum EventListType {
  nowInTheaters,
  comingSoon,
}

class Event {
  Event({
    this.id,
    this.title,
    this.originalTitle,
    this.genres,
    this.directors,
    this.actors,
    this.lengthInMinutes,
    this.shortSynopsis,
    this.synopsis,
    this.images,
    this.youtubeTrailers,
  });

  final String id;
  final String title;
  final String originalTitle;
  final String genres;
  final List<String> directors;
  final String lengthInMinutes;
  final String shortSynopsis;
  final String synopsis;
  final EventImageData images;
  final List<String> youtubeTrailers;

  List<Actor> actors;

  bool get hasSynopsis =>
      (shortSynopsis != null && shortSynopsis.isNotEmpty) ||
      (synopsis != null && synopsis.isNotEmpty);

  static List<Event> parseAll(String xmlString) {
    var document = xml.parse(xmlString);
    var events = document.findAllElements('Event');

    return events.map((node) {
      var title = tagContents(node, 'Title');
      var originalTitle = tagContents(node, 'OriginalTitle');

      return Event(
        id: tagContents(node, 'ID'),
        title: EventNameCleaner.cleanup(title),
        originalTitle: EventNameCleaner.cleanup(originalTitle),
        genres: tagContents(node, 'Genres'),
        directors: _parseDirectors(node.findAllElements('Director')),
        actors: _parseActors(node.findAllElements('Actor')),
        lengthInMinutes: tagContents(node, 'LengthInMinutes'),
        shortSynopsis: tagContents(node, 'ShortSynopsis'),
        synopsis: tagContents(node, 'Synopsis'),
        images: EventImageData.parseAll(node.findElements('Images')),
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

  String get anyAvailableImage =>
      portraitSmall ??
      portraitMedium ??
      portraitLarge ??
      landscapeSmall ??
      landscapeBig;

  EventImageData.empty()
      : portraitSmall = null,
        portraitMedium = null,
        portraitLarge = null,
        landscapeSmall = null,
        landscapeBig = null;

  static EventImageData parseAll(Iterable<xml.XmlElement> roots) {
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
