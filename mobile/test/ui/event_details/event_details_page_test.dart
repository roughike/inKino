import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:inkino/main.dart';
import 'package:inkino/ui/event_details/event_details_page.dart'
    as eventDetails;
import 'package:inkino/ui/events/event_poster.dart';
import 'package:inkino/ui/events/event_poster.dart' as eventPoster;
import 'package:inkino/ui/showtimes/showtime_list_tile.dart'
    as showtimeListTile;
import 'package:inkino/ui/showtimes/showtime_list_tile.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';

void main() {
  group('EventDetailsPage', () {
    final showId = '123';
    final ticketsButtonKey = Key('${showId}-tickets');
    final show = Show(
      id: showId,
      title: 'Test show',
      start: DateTime(2018),
      end: DateTime(2018),
      presentationMethod: '2D',
      theaterAndAuditorium: 'Test theater',
      url: 'https://finnkino.fi/test-tickets-url',
    );

    String lastLaunchedTicketsUrl;
    String lastLaunchedTrailerUrl;

    setUp(() {
      showtimeListTile.launchTicketsUrl = (url) => lastLaunchedTicketsUrl = url;
      eventPoster.launchTrailerVideo = (url) => lastLaunchedTrailerUrl = url;
    });

    tearDown(() {
      lastLaunchedTicketsUrl = null;
      lastLaunchedTrailerUrl = null;
    });

    Future<void> _buildEventDetailsPage(
      WidgetTester tester, {
      @required KtList<String> trailers,
      @required Show show,
    }) {
      return provideMockedNetworkImages(() async {
        return tester.pumpWidget(MaterialApp(
          supportedLocales: supportedLocales,
          localizationsDelegates: localizationsDelegates,
          home: eventDetails.EventDetailsPage(
            Event(
              id: '1',
              title: 'Test Title',
              genres: 'Test Genres',
              directors: emptyList(),
              actors: emptyList(),
              images: EventImageData.empty(),
              galleryImages: emptyList(),
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
        await _buildEventDetailsPage(tester, trailers: emptyList(), show: null);
        await tester.pump();

        expect(find.byType(ShowtimeListTile), findsNothing);
      },
    );

    testWidgets(
      'when navigated to with a non-null show, should display the showtime information in the UI',
      (WidgetTester tester) async {
        await _buildEventDetailsPage(
          tester,
          trailers: emptyList(),
          show: show,
        );

        await tester.pump();

        final showtimeInfoFinder = find.byType(ShowtimeListTile);
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
          trailers: emptyList(),
          show: show,
        );

        await tester.pump();
        await tester.tap(find.byKey(ticketsButtonKey));
        await tester.pumpAndSettle();

        expect(lastLaunchedTicketsUrl, 'https://finnkino.fi/test-tickets-url');
      },
    );

    testWidgets(
      'when pressing the play trailer button, should open the trailer link',
      (WidgetTester tester) async {
        await _buildEventDetailsPage(
          tester,
          trailers: listOf('https://youtube.com/?v=test-trailer'),
          show: show,
        );

        await tester.pump();
        await tester.tap(find.byKey(EventPoster.playButtonKey));

        expect(lastLaunchedTrailerUrl, 'https://youtube.com/?v=test-trailer');
      },
    );
  });
}
