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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Event &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              title == other.title &&
              originalTitle == other.originalTitle &&
              genres == other.genres &&
              directors == other.directors &&
              lengthInMinutes == other.lengthInMinutes &&
              shortSynopsis == other.shortSynopsis &&
              synopsis == other.synopsis &&
              images == other.images &&
              youtubeTrailers == other.youtubeTrailers &&
              actors == other.actors;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      originalTitle.hashCode ^
      genres.hashCode ^
      directors.hashCode ^
      lengthInMinutes.hashCode ^
      shortSynopsis.hashCode ^
      synopsis.hashCode ^
      images.hashCode ^
      youtubeTrailers.hashCode ^
      actors.hashCode;
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is EventImageData &&
              runtimeType == other.runtimeType &&
              portraitSmall == other.portraitSmall &&
              portraitMedium == other.portraitMedium &&
              portraitLarge == other.portraitLarge &&
              landscapeSmall == other.landscapeSmall &&
              landscapeBig == other.landscapeBig;

  @override
  int get hashCode =>
      portraitSmall.hashCode ^
      portraitMedium.hashCode ^
      portraitLarge.hashCode ^
      landscapeSmall.hashCode ^
      landscapeBig.hashCode;
}
