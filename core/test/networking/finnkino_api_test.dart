import 'dart:async';

import 'package:core/src/models/theater.dart';
import 'package:core/src/networking/finnkino_api.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:utf/utf.dart';

import '../parsers/event_test_seeds.ignore.dart';
import '../parsers/show_test_seeds.ignore.dart';

void main() {
  group('FinnkinoApi', () {
    final date = DateTime(2018);
    final theater = Theater(
      id: 'abc123',
      name: 'Test theater',
    );

    List<Request> requestLog = [];

    setUp(() {
      requestLog.clear();
    });

    MockClient _clientWithResponse(String value) {
      return MockClient((request) {
        requestLog.add(request);

        return Future(() {
          /// Have to do this "toBytes" dance because apparently, it's hard to
          /// get the Response do the encoding with utf8 instead of Latin 1.
          return Response.bytes(encodeUtf8(value), 200);
        });
      });
    }

    test('now in theaters', () async {
      final api = FinnkinoApi(_clientWithResponse(eventsXml));
      await api.getNowInTheatersEvents(theater);

      final expectedUrl =
          'https://www.finnkino.fi/en/xml/Events?area=abc123&listType=NowInTheatres&includeGallery=true';

      expect(requestLog.single.url.toString(), expectedUrl);
    });

    test('schedule', () async {
      final api = FinnkinoApi(_clientWithResponse(showsXml));
      await api.getSchedule(theater, date);

      final expectedUrl =
          'https://www.finnkino.fi/en/xml/Schedule?area=abc123&dt=01.01.2018&includeGallery=true';

      expect(requestLog.single.url.toString(), expectedUrl);
    });

    test('coming soon', () async {
      final api = FinnkinoApi(_clientWithResponse(eventsXml));
      await api.getUpcomingEvents();

      final expectedUrl =
          'https://www.finnkino.fi/en/xml/Events?listType=ComingSoon&includeGallery=true';

      expect(requestLog.single.url.toString(), expectedUrl);
    });

    test('finnish api requests', () async {
      final api = FinnkinoApi(_clientWithResponse(eventsXml));
      FinnkinoApi.useFinnish = true;

      await api.getNowInTheatersEvents(theater);
      await api.getSchedule(theater, date);
      await api.getUpcomingEvents();

      expect(requestLog.length, 3);

      expect(
        requestLog[0].url.toString(),
        'https://www.finnkino.fi/xml/Events?area=abc123&listType=NowInTheatres&includeGallery=true',
      );

      expect(
        requestLog[1].url.toString(),
        'https://www.finnkino.fi/xml/Schedule?area=abc123&dt=01.01.2018&includeGallery=true',
      );

      expect(
        requestLog[2].url.toString(),
        'https://www.finnkino.fi/xml/Events?listType=ComingSoon&includeGallery=true',
      );
    });
  });
}
