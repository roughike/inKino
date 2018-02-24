import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:inkino/data/event.dart';
import 'package:inkino/data/show.dart';
import 'package:inkino/data/theater.dart';

class FinnkinoApi {
  static final Uri kScheduleBaseUrl =
      new Uri.https('www.finnkino.fi', '/xml/Schedule');
  static final Uri kEventsBaseUrl =
      new Uri.https('www.finnkino.fi', '/xml/Events');

  Future<List<Show>> getSchedule(Theater theater) async {
    var xml = await _performGetRequest(
      kScheduleBaseUrl.replace(queryParameters: {
        'area': theater.id,
      }),
    );

    return Show.parseAll(xml);
  }

  Future<List<Event>> getEvents(Theater theater) async {
    var xml = await _performGetRequest(
      kEventsBaseUrl.replace(queryParameters: {
        'area': theater.id,
      }),
    );

    return Event.parseAll(xml);
  }

  Future<String> _performGetRequest(Uri uri) async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(uri);
    var response = await request.close();

    return await response.transform(UTF8.decoder).join();
  }
}
