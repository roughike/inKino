import 'package:xml/xml.dart' as xml;

class ScheduleDate {
  ScheduleDate(this.dateTime);
  final DateTime dateTime;

  static List<ScheduleDate> parseAll(String xmlString) {
    var scheduleDates = <ScheduleDate>[];
    var document = xml.parse(xmlString);
    
    document.findAllElements('dateTime').forEach((node) {
      var text = node.text;
      scheduleDates.add(new ScheduleDate(DateTime.parse(text)));
    });
    
    return scheduleDates;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ScheduleDate &&
              runtimeType == other.runtimeType &&
              dateTime == other.dateTime;

  @override
  int get hashCode => dateTime.hashCode;
}