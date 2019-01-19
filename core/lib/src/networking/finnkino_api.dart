import 'dart:async';
import 'dart:convert';

import 'package:core/src/models/event.dart';
import 'package:core/src/models/show.dart';
import 'package:core/src/models/theater.dart';
import 'package:core/src/parsers/event_parser.dart';
import 'package:core/src/parsers/show_parser.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:kt_dart/collection.dart';

class FinnkinoApi {
  static final ddMMyyyy = DateFormat('dd.MM.yyyy');
  static final enBaseUrl = 'https://www.finnkino.fi/en/xml';
  static final fiBaseUrl = 'https://www.finkino.fi/xml';

  static bool useFinnish = false;

  FinnkinoApi(this.client);

  final Client client;

  String get localizedPath => useFinnish ? '' : '/en';

  Uri get kScheduleBaseUrl =>
      Uri.https('www.finnkino.fi', '$localizedPath/xml/Schedule');

  Uri get kEventsBaseUrl =>
      Uri.https('www.finnkino.fi', '$localizedPath/xml/Events');

  Future<KtList<Show>> getSchedule(Theater theater, DateTime date) async {
    final dt = ddMMyyyy.format(date ?? new DateTime.now());
    final response = await client.get(
      kScheduleBaseUrl.replace(queryParameters: {
        'area': theater.id,
        'dt': dt,
        'includeGallery': 'true',
      }),
    );

    return ShowParser.parse(utf8.decode(response.bodyBytes));
  }

  Future<KtList<Event>> getNowInTheatersEvents(Theater theater) async {
    final response = await client.get(
      kEventsBaseUrl.replace(queryParameters: {
        'area': theater.id,
        'listType': 'NowInTheatres',
        'includeGallery': 'true',
      }),
    );

    return EventParser.parse(utf8.decode(response.bodyBytes));
  }

  Future<KtList<Event>> getUpcomingEvents() async {
    final response = await client.get(
      kEventsBaseUrl.replace(queryParameters: {
        'listType': 'ComingSoon',
        'includeGallery': 'true',
      }),
    );

    return EventParser.parse(utf8.decode(response.bodyBytes));
  }
}
