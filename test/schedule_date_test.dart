import 'dart:io';

import 'package:inkino/data/schedule_date.dart';
import 'package:test/test.dart';

void main() {
  group('Schedule date model', () {
    test('parsing test', () {
      var scheduleDates = new File('test_assets/schedule_dates.xml').readAsStringSync();

      List<ScheduleDate> deserialized = ScheduleDate.parseAll(scheduleDates);
      expect(deserialized.length, 3);

      expect(deserialized[0].dateTime, new DateTime(2018, 02, 20));
      expect(deserialized[1].dateTime, new DateTime(2011, 03, 10));
      expect(deserialized[2].dateTime, new DateTime(2013, 06, 12));
    });
  });
}