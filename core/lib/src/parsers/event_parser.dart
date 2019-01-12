import 'package:core/src/models/actor.dart';
import 'package:core/src/models/event.dart';
import 'package:core/src/networking/image_url_rewriter.dart';
import 'package:core/src/parsers/content_descriptor_parser.dart';
import 'package:core/src/parsers/gallery_parser.dart';
import 'package:core/src/utils/event_name_cleaner.dart';
import 'package:core/src/utils/xml_utils.dart';
import 'package:kt_dart/collection.dart';
import 'package:xml/xml.dart' as xml;

class EventParser {
  static KtList<Event> parse(String xmlString) {
    final document = xml.parse(xmlString);
    final events = document.findAllElements('Event');

    return listFrom(events).map((node) {
      final title = tagContents(node, 'Title');
      final originalTitle = tagContents(node, 'OriginalTitle');

      return Event(
        id: tagContents(node, 'ID'),
        title: EventNameCleaner.cleanup(title),
        originalTitle: EventNameCleaner.cleanup(originalTitle),
        releaseDate:
            _parseReleaseDate(tagContentsOrNull(node, 'dtLocalRelease')),
        ageRating: tagContentsOrNull(node, 'Rating'),
        ageRatingUrl:
            rewriteImageUrl(tagContentsOrNull(node, 'RatingImageUrl')),
        genres: tagContents(node, 'Genres'),
        directors: _parseDirectors(node.findAllElements('Director')),
        actors: _parseActors(node.findAllElements('Actor')),
        lengthInMinutes: tagContents(node, 'LengthInMinutes'),
        shortSynopsis: tagContents(node, 'ShortSynopsis'),
        synopsis: tagContents(node, 'Synopsis'),
        images: EventImageDataParser.parse(node.findElements('Images')),
        contentDescriptors: ContentDescriptorParser.parse(
            node.findElements('ContentDescriptors')),
        youtubeTrailers: _parseTrailers(node.findAllElements('EventVideo')),
        galleryImages: GalleryParser.parse(node.findElements('Gallery')),
      );
    });
  }

  static DateTime _parseReleaseDate(String rawDate) {
    try {
      return DateTime.parse(rawDate);
    } catch (e) {
      return null;
    }
  }

  static KtList<String> _parseDirectors(Iterable<xml.XmlElement> nodes) {
    return listFrom(nodes).map((node) {
      final first = tagContents(node, 'FirstName');
      final last = tagContents(node, 'LastName');

      return '$first $last';
    });
  }

  static KtList<Actor> _parseActors(Iterable<xml.XmlElement> nodes) {
    return listFrom(nodes).map((node) {
      final first = tagContents(node, 'FirstName');
      final last = tagContents(node, 'LastName');

      return Actor(name: '$first $last');
    });
  }

  static KtList<String> _parseTrailers(Iterable<xml.XmlElement> nodes) {
    return listFrom(nodes).map((node) {
      return 'https://youtube.com/watch?v=' + tagContents(node, 'Location');
    });
  }
}

class EventImageDataParser {
  static EventImageData parse(Iterable<xml.XmlElement> roots) {
    if (roots == null || roots.isEmpty) {
      return EventImageData.empty();
    }

    final root = roots.first;
    final landscapeBig =
        rewriteImageUrl(tagContentsOrNull(root, 'EventLargeImageLandscape'));

    return EventImageData(
      portraitSmall:
          rewriteImageUrl(tagContentsOrNull(root, 'EventSmallImagePortrait')),
      portraitMedium:
          rewriteImageUrl(tagContentsOrNull(root, 'EventMediumImagePortrait')),
      portraitLarge:
          rewriteImageUrl(tagContentsOrNull(root, 'EventLargeImagePortrait')),
      landscapeSmall:
          rewriteImageUrl(tagContentsOrNull(root, 'EventSmallImageLandscape')),
      landscapeBig: landscapeBig,
      landscapeHd: _getHdImageUrl(landscapeBig),
      landscapeHd2: _getHdImageUrl2(landscapeBig),
    );
  }

  ///
  /// This hacky hack only exists because Finnkino API doesn't return HD
  /// landscape images without also increasing the response size by 47,4% on
  /// average. Yes, it really does that by including bunch of other unnecessary
  /// images.
  ///
  /// In order to circumvent this, we "calculate" the HD landscape image url from
  /// the large landscape url.
  ///
  /// For example, the url:
  ///
  /// https://media.finnkino.fi/1012/Event_11881/landscape_large/BookClub_670_kke.jpg
  ///
  /// converted to landscape HD url becomes:
  ///
  /// https://media.finnkino.fi//1012/Event_11881/landscape_hd/BookClub_1920_kke.jpg
  ///
  /// OR
  ///
  /// https://media.finnkino.fi//1012/Event_11881/landscape_hd/BookClub_1920_kke_.jpg
  ///
  /// Yep. That's right. It could be either one of those. So we just try loading the other
  /// and if it fails, we try loading the second one.
  ///
  /// The one with the "_" is more common, but the other one appears too.
  ///
  /// TODO: This is ugly and I should feel ugly. Make this more efficient and
  /// pretty. And DRY.
  /// FIXME. please.
  ///
  static final _regex = RegExp(r'_670([^.]*)');

  static String _getHdImageUrl(String bigUrl) {
    return bigUrl
        ?.replaceFirst('landscape_large', 'landscape_hd')
        ?.replaceFirstMapped(_regex, (match) => '_1920${match.group(1)}_');
  }

  static String _getHdImageUrl2(String bigUrl) {
    return bigUrl
        ?.replaceFirst('landscape_large', 'landscape_hd')
        ?.replaceFirstMapped(_regex, (match) => '_1920${match.group(1)}');
  }
}
