import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:inkino/data/models/theater.dart';
import 'package:intl/intl.dart';

class FinnkinoApi {
  static final DateFormat ddMMyyyy = new DateFormat('dd.MM.yyyy');

  static final Uri kScheduleBaseUrl =
      new Uri.https('www.finnkino.fi', '/en/xml/Schedule');
  static final Uri kEventsBaseUrl =
      new Uri.https('www.finnkino.fi', '/en/xml/Events');

  Future<String> getSchedule(Theater theater, DateTime date) async {
    var dt = ddMMyyyy.format(date ?? new DateTime.now());
    var response = await http.get(
      kScheduleBaseUrl.replace(queryParameters: {
        'area': theater.id,
        'dt': dt,
      }),
    );

    return response.body;
  }

  Future<String> getNowInTheatersEvents(Theater theater) async {
    var response = await http.get(
      kEventsBaseUrl.replace(queryParameters: {
        'area': theater.id,
        'listType': 'NowInTheatres',
      }),
    );

    return response.body;
  }

  Future<String> getUpcomingEvents() async {
    var response = await http.get(
      kEventsBaseUrl.replace(queryParameters: {
        'listType': 'ComingSoon',
      }),
    );

    return response.body;
  }
}
