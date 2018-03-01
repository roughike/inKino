import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:inkino/data/theater.dart';

class FinnkinoApi {
  static final Uri kScheduleBaseUrl =
      new Uri.https('www.finnkino.fi', '/xml/Schedule');
  static final Uri kEventsBaseUrl =
      new Uri.https('www.finnkino.fi', '/xml/Events');

  Future<String> getSchedule(Theater theater) async {
    return _performGetRequest(
      kScheduleBaseUrl.replace(queryParameters: {
        'area': theater.id,
      }),
    );
  }

  Future<String> getEvents(Theater theater) async {
    return _performGetRequest(
      kEventsBaseUrl.replace(queryParameters: {
        'area': theater.id,
      }),
    );
  }

  Future<String> _performGetRequest(Uri uri) async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(uri);
    var response = await request.close();

    return await response.transform(UTF8.decoder).join();
  }
}
