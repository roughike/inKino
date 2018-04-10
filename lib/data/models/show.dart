import 'package:inkino/utils/event_name_cleaner.dart';
import 'package:inkino/utils/xml_utils.dart';
import 'package:xml/xml.dart' as xml;

class Show {
  Show({
    this.id,
    this.eventId,
    this.title,
    this.originalTitle,
    this.url,
    this.presentationMethod,
    this.theaterAndAuditorium,
    this.start,
    this.end,
  });

  final String id;
  final String eventId;
  final String title;
  final String originalTitle;
  final String url;
  final String presentationMethod;
  final String theaterAndAuditorium;
  final DateTime start;
  final DateTime end;

  static List<Show> parseAll(String xmlString) {
    var document = xml.parse(xmlString);
    var shows = document.findAllElements('Show');

    return shows.map((node) {
      var title = tagContents(node, 'Title');
      var originalTitle = tagContents(node, 'OriginalTitle');

      return new Show(
        id: tagContents(node, 'ID'),
        eventId: tagContents(node, 'EventID'),
        title: EventNameCleaner.cleanup(title),
        originalTitle: EventNameCleaner.cleanup(originalTitle),
        url: tagContents(node, 'ShowURL'),
        presentationMethod: tagContents(node, 'PresentationMethod'),
        theaterAndAuditorium: tagContents(node, 'TheatreAndAuditorium'),
        start: DateTime.parse(tagContents(node, 'dttmShowStart')),
        end: DateTime.parse(tagContents(node, 'dttmShowEnd')),
      );
    }).toList();
  }
}
