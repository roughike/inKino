import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:inkino/models/actor.dart';
import 'package:inkino/models/event.dart';
import 'package:inkino/models/show.dart';
import 'package:inkino/ui/event_details/event_details_page.dart'
    as eventDetails;
import 'package:inkino/ui/event_details/showtime_information.dart';
import 'package:inkino/ui/event_details/showtime_information.dart'
    as showtimeInfo;
import 'package:inkino/ui/events/event_poster.dart';
import 'package:inkino/ui/events/event_poster.dart' as eventPoster;
import 'package:meta/meta.dart';

void main() {
  group('EventDetailsPage', () {
    String lastLaunchedTicketsUrl;
    String lastLaunchedTrailerUrl;

    setUp(() {
      showtimeInfo.launchTicketsUrl = (url) => lastLaunchedTicketsUrl = url;
      eventPoster.launchTrailerVideo = (url) => lastLaunchedTrailerUrl = url;
    });

    tearDown(() {
      lastLaunchedTicketsUrl = null;
      lastLaunchedTrailerUrl = null;
    });

    Future<Null> _buildEventDetailsPage(
      WidgetTester tester, {
      @required List<String> trailers,
      @required Show show,
    }) {
      return provideMockedNetworkImages(() async {
        return tester.pumpWidget(MaterialApp(
          home: eventDetails.EventDetailsPage(
            Event(
              id: '1',
              title: 'Test Title',
              genres: 'Test Genres',
              directors: <String>[],
              actors: <Actor>[],
              images: EventImageData.empty(),
              youtubeTrailers: trailers,
            ),
            show: show,
          ),
        ));
      });
    }

    testWidgets(
      'when navigated to with a null show, should not display showtime information widget in the UI',
      (WidgetTester tester) async {
        await _buildEventDetailsPage(tester, trailers: <String>[], show: null);

        expect(find.byType(ShowtimeInformation), findsNothing);
      },
    );

    testWidgets(
      'when navigated to with a non-null show, should display the showtime information in the UI',
      (WidgetTester tester) async {
        await _buildEventDetailsPage(
          tester,
          trailers: <String>[],
          show: Show(
            start: DateTime(2018),
            theaterAndAuditorium: 'Test theater',
          ),
        );

        var showtimeInfoFinder = find.byType(ShowtimeInformation);
        expect(showtimeInfoFinder, findsOneWidget);
        expect(
          find.descendant(
            of: showtimeInfoFinder,
            matching: find.text('Test theater'),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'when pressing tickets button, should open the tickets link',
      (WidgetTester tester) async {
        await _buildEventDetailsPage(
          tester,
          trailers: <String>[],
          show: Show(
            start: DateTime(2018),
            theaterAndAuditorium: 'Test theater',
            url: 'https://finnkino.fi/test-tickets-url',
          ),
        );

        await tester.tap(find.byKey(ShowtimeInformation.ticketsButtonKey));
        expect(lastLaunchedTicketsUrl, 'https://finnkino.fi/test-tickets-url');
      },
    );

    testWidgets(
      'when pressing the play trailer button, should open the trailer link',
      (WidgetTester tester) async {
        await _buildEventDetailsPage(
          tester,
          trailers: <String>['https://youtube.com/?v=test-trailer'],
          show: Show(
            start: DateTime(2018),
            theaterAndAuditorium: 'Test theater',
          ),
        );

        await tester.tap(find.byKey(EventPoster.playButtonKey));
        await tester.pumpAndSettle();

        expect(lastLaunchedTrailerUrl, 'https://youtube.com/?v=test-trailer');
      },
    );
  });
}
