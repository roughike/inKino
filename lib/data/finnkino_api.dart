import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:inkino/data/show.dart';
import 'package:inkino/data/theater.dart';

class FinnkinoApi {
  static final Uri kScheduleBaseUrl =
      new Uri.https('www.finnkino.fi', '/xml/Schedule');

  Future<List<Show>> getSchedule(Theater theater) async {
    var xml = await _performGetRequest(
      kScheduleBaseUrl.replace(queryParameters: {
        'area': theater.id,
      }),
    );

    return Show.parseAll(xml);
  }

  Future<String> _performGetRequest(Uri uri) async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(uri);
    var response = await request.close();

    return await response.transform(UTF8.decoder).join();
  }
}
