import 'package:meta/meta.dart';
import 'package:xml/xml.dart' as xml;
import 'package:inkino/utils.dart';

final RegExp _nameExpr = new RegExp(r'([A-Z])([A-Z]+)');

class Theater {
  /// Entirely redundant theater, which isn't actually even a theater.
  /// The API returns this as "Valitse alue/teatteri", which means "choose a
  /// theater". Thanks Finnkino.
  static const String kChooseTheaterId = '1029';

  Theater({
    @required this.id,
    @required this.name,
  });

  final String id;
  final String name;

  static List<Theater> parseAll(String xmlString) {
    var theaters = <Theater>[];
    var document = xml.parse(xmlString);

    document.findAllElements('TheatreArea').forEach((node) {
      var id = tagContents(node, 'ID');
      var normalizedName = _normalize(tagContents(node, 'Name'));

      if (id == kChooseTheaterId) {
        normalizedName = 'All theaters';
      }

      theaters.add(new Theater(
        id: id,
        name: normalizedName,
      ));
    });

    return theaters;
  }

  static _normalize(String text) {
    return text.replaceAllMapped(_nameExpr, (match) {
      return '${match.group(1)}${match.group(2).toLowerCase()}';
    });
  }
}
