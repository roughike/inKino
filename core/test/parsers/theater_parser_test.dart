import 'package:core/src/models/theater.dart';
import 'package:core/src/parsers/theater_parser.dart';
import 'package:kt_dart/collection.dart';
import 'package:test/test.dart';

import 'theater_test_seeds.ignore.dart';

void main() {
  group('TheaterParser', () {
    test('parsing test', () {
      KtList<Theater> deserialized = TheaterParser.parse(theatersXml);
      expect(deserialized.size, 3);

      expect(deserialized[0].id, '1029');
      expect(deserialized[0].name, 'All theaters');

      expect(deserialized[1].id, '001');
      expect(deserialized[1].name, 'Gotham: Theater One');

      expect(deserialized[2].id, '002');
      expect(deserialized[2].name, 'Gotham: Theater Two');
    });
  });
}
