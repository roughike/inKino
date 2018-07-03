import 'package:inkino/models/theater.dart';
import 'package:inkino/utils/xml_utils.dart';
import 'package:xml/xml.dart' as xml;

final RegExp _nameExpr = new RegExp(r'([A-Z])([A-Z]+)');

class TheaterParser {
  /// Entirely redundant theater, which isn't actually even a theater.
  /// The API returns this as "Valitse alue/teatteri", which means "choose a
  /// theater". Thanks Finnkino.
  static const String kChooseTheaterId = '1029';

  static List<Theater> parse(String xmlString) {
    var document = xml.parse(xmlString);
    var theaters = document.findAllElements('TheatreArea');

    return theaters.map((node) {
      var id = tagContents(node, 'ID');
      var normalizedName = _normalize(tagContents(node, 'Name'));

      if (id == kChooseTheaterId) {
        normalizedName = 'All theaters';
      }

      return Theater(
        id: id,
        name: normalizedName,
      );
    }).toList();
  }

  static String _normalize(String text) {
    return text.replaceAllMapped(_nameExpr, (match) {
      return '${match.group(1)}${match.group(2).toLowerCase()}';
    });
  }
}
