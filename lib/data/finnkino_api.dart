import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:inkino/data/event.dart';
import 'package:inkino/data/theater.dart';
import 'package:intl/intl.dart';

class FinnkinoApi {
  static final Uri kScheduleBaseUrl =
      new Uri.https('www.finnkino.fi', '/en/xml/Schedule');
  static final Uri kEventsBaseUrl =
      new Uri.https('www.finnkino.fi', '/en/xml/Events');

  Future<String> getSchedule(Theater theater, DateTime date) async {
    var thing = date ?? new DateTime.now();
    var dt = new DateFormat('dd.MM.yyyy').format(thing);

    return _performGetRequest(
      kScheduleBaseUrl.replace(queryParameters: {
        'area': theater.id,
        'dt': dt,
      }),
    );
  }

  Future<String> getNowInTheatersEvents(Theater theater) async {
    return _performGetRequest(
      kEventsBaseUrl.replace(queryParameters: {
        'area': theater.id,
        'listType': 'NowInTheatres',
      }),
    );
  }

  Future<String> getUpcomingEvents() async {
    return _performGetRequest(
      kEventsBaseUrl.replace(queryParameters: {
        'listType': 'ComingSoon',
      }),
    );
  }

  Future<String> _performGetRequest(Uri uri) async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(uri);
    var response = await request.close();

    return response.transform(UTF8.decoder).join();
  }
}
