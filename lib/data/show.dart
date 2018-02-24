import 'package:meta/meta.dart';
import 'package:xml/xml.dart' as xml;
import 'package:inkino/utils.dart';

class Show {
  Show({
    @required this.id,
    @required this.title,
    @required this.presentationMethod,
    @required this.theaterAndAuditorium,
    @required this.start,
    @required this.end,
  });

  final String id;
  final String title;
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
        title: tagContents(node, 'Title'),
        presentationMethod: tagContents(node, 'PresentationMethod'),
        theaterAndAuditorium: tagContents(node, 'TheatreAndAuditorium'),
        start: DateTime.parse(tagContents(node, 'dttmShowStart')),
        end: DateTime.parse(tagContents(node, 'dttmShowEnd')),
      ));
    });

    return shows;
  }
}
