import 'package:inkino/models/theater.dart';
import 'package:inkino/networking/theater_parser.dart';
import 'package:test/test.dart';

void main() {
  group('TheaterParser', () {
    test('parsing test', () {
      List<Theater> deserialized = TheaterParser.parse(theatersXml);
      expect(deserialized.length, 3);

      expect(deserialized[0].id, '1029');
      expect(deserialized[0].name, 'All theaters');

      expect(deserialized[1].id, '001');
      expect(deserialized[1].name, 'Gotham: Theater One');

      expect(deserialized[2].id, '002');
      expect(deserialized[2].name, 'Gotham: Theater Two');
    });
  });
}

const String theatersXml = '''<?xml version="1.0"?>
<TheatreAreas xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <TheatreArea>
        <ID>1029</ID>
        <Name>Valitse alue/teatteri</Name>
    </TheatreArea>
    <TheatreArea>
        <ID>001</ID>
        <Name>Gotham: THEATER ONE</Name>
    </TheatreArea>
    <TheatreArea>
        <ID>002</ID>
        <Name>Gotham: THEATER TWO</Name>
    </TheatreArea>
</TheatreAreas>''';
