import 'package:meta/meta.dart';
import 'package:xml/xml.dart' as xml;

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
        id: _findTagContents(node, 'ID'),
        title: _findTagContents(node, 'Title'),
        presentationMethod: _findTagContents(node, 'PresentationMethod'),
        theaterAndAuditorium: _findTagContents(node, 'TheatreAndAuditorium'),
        start: DateTime.parse(_findTagContents(node, 'dttmShowStart')),
        end: DateTime.parse(_findTagContents(node, 'dttmShowEnd')),
      ));
    });

    return shows;
  }

  static String _findTagContents(xml.XmlElement node, String tagName) {
    return node.findElements(tagName).single.text;
  }
}
