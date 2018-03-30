import 'dart:io';

import 'package:inkino/data/models/theater.dart';
import 'package:test/test.dart';

void main() {
  group('Theater model', () {
    test('parsing test', () {
      var theaters = new File('test_assets/theaters.xml').readAsStringSync();

      List<Theater> deserialized = Theater.parseAll(theaters);
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