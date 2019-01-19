import 'package:core/src/models/theater.dart';
import 'package:core/src/utils/xml_utils.dart';
import 'package:kt_dart/collection.dart';
import 'package:xml/xml.dart' as xml;

final RegExp _nameExpr = new RegExp(r'([A-Z])([A-Z]+)');

class TheaterParser {
  /// Entirely redundant theater, which isn't actually even a theater.
  /// The API returns this as "Valitse alue/teatteri", which means "choose a
  /// theater". Thanks Finnkino.
  static const String kChooseTheaterId = '1029';

  static KtList<Theater> parse(String xmlString) {
    final document = xml.parse(xmlString);
    final theaters = document.findAllElements('TheatreArea').map((node) {
      final id = tagContents(node, 'ID');
      var normalizedName = _normalize(tagContents(node, 'Name'));

      if (id == kChooseTheaterId) {
        normalizedName = 'All theaters';
      }

      return Theater(
        id: id,
        name: normalizedName,
      );
    });

    return listFrom(theaters);
  }

  static String _normalize(String text) {
    return text.replaceAllMapped(_nameExpr, (match) {
      return '${match.group(1)}${match.group(2).toLowerCase()}';
    });
  }
}
