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
    var shows = <Show>[];
    var document = xml.parse(xmlString);

    document.findAllElements('Show').forEach((node) {
      shows.add(new Show(
        id: tagContents(node, 'ID'),
        eventId: tagContents(node, 'EventID'),
        title: tagContents(node, 'Title'),
        originalTitle: tagContents(node, 'OriginalTitle'),
        url: tagContents(node, 'ShowURL'),
        presentationMethod: tagContents(node, 'PresentationMethod'),
        theaterAndAuditorium: tagContents(node, 'TheatreAndAuditorium'),
        start: DateTime.parse(tagContents(node, 'dttmShowStart')),
        end: DateTime.parse(tagContents(node, 'dttmShowEnd')),
      ));
    });

    return shows;
  }
}
