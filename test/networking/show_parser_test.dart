import 'package:inkino/models/show.dart';
import 'package:inkino/networking/show_parser.dart';
import 'package:test/test.dart';

void main() {
  group('ShowParser', () {
    test('parsing test', () {
      List<Show> deserialized = ShowParser.parse(showsXml);
      expect(deserialized.length, 3);

      var jumanji = deserialized.first;
      expect(jumanji.id, '1155306');
      expect(jumanji.eventId, '302419');
      expect(jumanji.title, 'Jumanji: Welcome to the Jungle');
      expect(jumanji.originalTitle, 'Jumanji: Welcome to the Jungle (Original title)');
      expect(jumanji.url, 'http://www.finnkino.fi/websales/show/1155306/');
      expect(jumanji.presentationMethod, '2D');
      expect(jumanji.theaterAndAuditorium, 'Tennispalatsi, Helsinki, sali 6');
      expect(jumanji.start, new DateTime(2018, 02, 21, 10, 30));
      expect(jumanji.end, new DateTime(2018, 02, 21, 12, 39));
    });
  });
}

const String showsXml = '''<?xml version="1.0"?>
<Schedule xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <PubDate>2018-02-21T00:00:00+02:00</PubDate>
    <Shows>
        <Show>
            <ID>1155306</ID>
            <dtAccounting>2018-02-21T00:00:00</dtAccounting>
            <dttmShowStart>2018-02-21T10:30:00</dttmShowStart>
            <dttmShowStartUTC>2018-02-21T08:30:00Z</dttmShowStartUTC>
            <dttmShowEnd>2018-02-21T12:39:00</dttmShowEnd>
            <dttmShowEndUTC>2018-02-21T10:39:00Z</dttmShowEndUTC>
            <ShowSalesStartTime>2000-01-01T00:00:00</ShowSalesStartTime>
            <ShowSalesStartTimeUTC>2000-01-01T00:00:00Z</ShowSalesStartTimeUTC>
            <ShowSalesEndTime>2018-02-21T10:15:00</ShowSalesEndTime>
            <ShowSalesEndTimeUTC>2018-02-21T08:15:00Z</ShowSalesEndTimeUTC>
            <ShowReservationStartTime>2000-01-01T00:00:00</ShowReservationStartTime>
            <ShowReservationStartTimeUTC>2000-01-01T00:00:00Z</ShowReservationStartTimeUTC>
            <ShowReservationEndTime>2018-02-21T09:00:00</ShowReservationEndTime>
            <ShowReservationEndTimeUTC>2018-02-21T07:00:00Z</ShowReservationEndTimeUTC>
            <EventID>302419</EventID>
            <Title>Jumanji: Welcome to the Jungle</Title>
            <OriginalTitle>Jumanji: Welcome to the Jungle (Original title)</OriginalTitle>
            <ProductionYear>2017</ProductionYear>
            <LengthInMinutes>119</LengthInMinutes>
            <dtLocalRelease>2017-12-22T00:00:00</dtLocalRelease>
            <Rating>12</Rating>
            <RatingLabel>12</RatingLabel>
            <RatingImageUrl>https://media.finnkino.fi/images/rating_large_12.png</RatingImageUrl>
            <EventType>Movie</EventType>
            <Genres>Komedia, Toiminta, Seikkailu, Fantasia</Genres>
            <TheatreID>1038</TheatreID>
            <TheatreAuditriumID>1279</TheatreAuditriumID>
            <Theatre>Tennispalatsi, Helsinki</Theatre>
            <TheatreAuditorium>sali 6</TheatreAuditorium>
            <TheatreAndAuditorium>Tennispalatsi, Helsinki, sali 6</TheatreAndAuditorium>
            <PresentationMethodAndLanguage>2D</PresentationMethodAndLanguage>
            <PresentationMethod>2D</PresentationMethod>
            <EventSeries />
            <ShowURL>http://www.finnkino.fi/websales/show/1155306/</ShowURL>
            <EventURL>http://www.finnkino.fi/event/302419/title/jumanji_welcome_to_the_jungle/</EventURL>
            <Images>
                <EventMicroImagePortrait>http://media.finnkino.fi/1012/Event_11765/portrait_micro/Jumanji_1080u.jpg</EventMicroImagePortrait>
                <EventSmallImagePortrait>http://media.finnkino.fi/1012/Event_11765/portrait_small/Jumanji_1080u.jpg</EventSmallImagePortrait>
                <EventMediumImagePortrait>http://media.finnkino.fi/1012/Event_11765/portrait_medium/Jumanji_1080u.jpg</EventMediumImagePortrait>
                <EventLargeImagePortrait>http://media.finnkino.fi/1012/Event_11765/portrait_small/Jumanji_1080u.jpg</EventLargeImagePortrait>
                <EventSmallImageLandscape>http://media.finnkino.fi/1012/Event_11765/landscape_small/Jumanji_444.jpg</EventSmallImageLandscape>
                <EventLargeImageLandscape>http://media.finnkino.fi/1012/Event_11765/landscape_large/Jumanji_670.jpg</EventLargeImageLandscape>
            </Images>
            <ContentDescriptors>
                <ContentDescriptor>
                    <Name>Violence</Name>
                    <ImageURL>https://media.finnkino.fi/images/content_Violence.png</ImageURL>
                </ContentDescriptor>
                <ContentDescriptor>
                    <Name>Disturbing</Name>
                    <ImageURL>https://media.finnkino.fi/images/content_Disturbing.png</ImageURL>
                </ContentDescriptor>
            </ContentDescriptors>
        </Show>
        <Show>
            <ID>1154395</ID>
            <dtAccounting>2018-02-21T00:00:00</dtAccounting>
            <dttmShowStart>2018-02-21T10:30:00</dttmShowStart>
            <dttmShowStartUTC>2018-02-21T08:30:00Z</dttmShowStartUTC>
            <dttmShowEnd>2018-02-21T12:34:00</dttmShowEnd>
            <dttmShowEndUTC>2018-02-21T10:34:00Z</dttmShowEndUTC>
            <ShowSalesStartTime>2000-01-01T00:00:00</ShowSalesStartTime>
            <ShowSalesStartTimeUTC>2000-01-01T00:00:00Z</ShowSalesStartTimeUTC>
            <ShowSalesEndTime>2018-02-21T10:15:00</ShowSalesEndTime>
            <ShowSalesEndTimeUTC>2018-02-21T08:15:00Z</ShowSalesEndTimeUTC>
            <ShowReservationStartTime>2000-01-01T00:00:00</ShowReservationStartTime>
            <ShowReservationStartTimeUTC>2000-01-01T00:00:00Z</ShowReservationStartTimeUTC>
            <ShowReservationEndTime>2018-02-21T09:00:00</ShowReservationEndTime>
            <ShowReservationEndTimeUTC>2018-02-21T07:00:00Z</ShowReservationEndTimeUTC>
            <EventID>302486</EventID>
            <Title>Wonder</Title>
            <OriginalTitle>Wonder</OriginalTitle>
            <ProductionYear>2017</ProductionYear>
            <LengthInMinutes>114</LengthInMinutes>
            <dtLocalRelease>2018-01-05T00:00:00</dtLocalRelease>
            <Rating>S</Rating>
            <RatingLabel>S</RatingLabel>
            <RatingImageUrl>https://media.finnkino.fi/images/rating_large_S.png</RatingImageUrl>
            <EventType>Movie</EventType>
            <Genres>Draama</Genres>
            <TheatreID>1034</TheatreID>
            <TheatreAuditriumID>1207</TheatreAuditriumID>
            <Theatre>Kinopalatsi, Helsinki</Theatre>
            <TheatreAuditorium>sali 10</TheatreAuditorium>
            <TheatreAndAuditorium>Kinopalatsi, Helsinki, sali 10</TheatreAndAuditorium>
            <PresentationMethodAndLanguage>2D</PresentationMethodAndLanguage>
            <PresentationMethod>2D</PresentationMethod>
            <EventSeries />
            <ShowURL>http://www.finnkino.fi/websales/show/1154395/</ShowURL>
            <EventURL>http://www.finnkino.fi/event/302486/title/wonder/</EventURL>
            <Images>
                <EventMicroImagePortrait>http://media.finnkino.fi/1012/Event_11832/portrait_micro/Wonder_1080.jpg</EventMicroImagePortrait>
                <EventSmallImagePortrait>http://media.finnkino.fi/1012/Event_11832/portrait_small/Wonder_1080.jpg</EventSmallImagePortrait>
                <EventMediumImagePortrait>http://media.finnkino.fi/1012/Event_11832/portrait_medium/Wonder_1080.jpg</EventMediumImagePortrait>
                <EventLargeImagePortrait>http://media.finnkino.fi/1012/Event_11832/portrait_small/Wonder_1080.jpg</EventLargeImagePortrait>
                <EventSmallImageLandscape>http://media.finnkino.fi/1012/Event_11832/landscape_small/Wonder_444.jpg</EventSmallImageLandscape>
                <EventLargeImageLandscape>http://media.finnkino.fi/1012/Event_11832/landscape_large/Wonder_670.jpg</EventLargeImageLandscape>
            </Images>
            <ContentDescriptors />
        </Show>
        <Show>
            <ID>1153867</ID>
            <dtAccounting>2018-03-21T00:00:00</dtAccounting>
            <dttmShowStart>2018-03-21T10:30:00</dttmShowStart>
            <dttmShowStartUTC>2018-03-21T08:30:00Z</dttmShowStartUTC>
            <dttmShowEnd>2018-03-21T12:25:00</dttmShowEnd>
            <dttmShowEndUTC>2018-03-21T10:25:00Z</dttmShowEndUTC>
            <ShowSalesStartTime>2000-01-01T00:00:00</ShowSalesStartTime>
            <ShowSalesStartTimeUTC>2000-01-01T00:00:00Z</ShowSalesStartTimeUTC>
            <ShowSalesEndTime>2018-02-21T10:15:00</ShowSalesEndTime>
            <ShowSalesEndTimeUTC>2018-02-21T08:15:00Z</ShowSalesEndTimeUTC>
            <ShowReservationStartTime>2000-01-01T00:00:00</ShowReservationStartTime>
            <ShowReservationStartTimeUTC>2000-01-01T00:00:00Z</ShowReservationStartTimeUTC>
            <ShowReservationEndTime>2018-02-21T09:00:00</ShowReservationEndTime>
            <ShowReservationEndTimeUTC>2018-02-21T07:00:00Z</ShowReservationEndTimeUTC>
            <EventID>302492</EventID>
            <Title>The Greatest Showman</Title>
            <OriginalTitle>The Greatest Showman</OriginalTitle>
            <ProductionYear>2017</ProductionYear>
            <LengthInMinutes>105</LengthInMinutes>
            <dtLocalRelease>2018-01-19T00:00:00</dtLocalRelease>
            <Rating>7</Rating>
            <RatingLabel>7</RatingLabel>
            <RatingImageUrl>https://media.finnkino.fi/images/rating_large_7.png</RatingImageUrl>
            <EventType>Movie</EventType>
            <Genres>Draama, Musikaali, Elämäkerta</Genres>
            <TheatreID>1034</TheatreID>
            <TheatreAuditriumID>1266</TheatreAuditriumID>
            <Theatre>Kinopalatsi, Helsinki</Theatre>
            <TheatreAuditorium>sali 9</TheatreAuditorium>
            <TheatreAndAuditorium>Kinopalatsi, Helsinki, sali 9</TheatreAndAuditorium>
            <PresentationMethodAndLanguage>2D</PresentationMethodAndLanguage>
            <PresentationMethod>2D</PresentationMethod>
            <EventSeries />
            <ShowURL>http://www.finnkino.fi/websales/show/1153867/</ShowURL>
            <EventURL>http://www.finnkino.fi/event/302492/title/the_greatest_showman/</EventURL>
            <Images>
                <EventMicroImagePortrait>http://media.finnkino.fi/1012/Event_11838/portrait_micro/TheGreatestShowman_1080.jpg</EventMicroImagePortrait>
                <EventSmallImagePortrait>http://media.finnkino.fi/1012/Event_11838/portrait_small/TheGreatestShowman_1080.jpg</EventSmallImagePortrait>
                <EventMediumImagePortrait>http://media.finnkino.fi/1012/Event_11838/portrait_medium/TheGreatestShowman_1080.jpg</EventMediumImagePortrait>
                <EventLargeImagePortrait>http://media.finnkino.fi/1012/Event_11838/portrait_small/TheGreatestShowman_1080.jpg</EventLargeImagePortrait>
                <EventSmallImageLandscape>http://media.finnkino.fi/1012/Event_11838/landscape_small/TheGreatestShowman_444.jpg</EventSmallImageLandscape>
                <EventLargeImageLandscape>http://media.finnkino.fi/1012/Event_11838/landscape_large/TheGreatestShowman_670.jpg</EventLargeImageLandscape>
            </Images>
            <ContentDescriptors>
                <ContentDescriptor>
                    <Name>Violence</Name>
                    <ImageURL>https://media.finnkino.fi/images/content_Violence.png</ImageURL>
                </ContentDescriptor>
                <ContentDescriptor>
                    <Name>Disturbing</Name>
                    <ImageURL>https://media.finnkino.fi/images/content_Disturbing.png</ImageURL>
                </ContentDescriptor>
            </ContentDescriptors>
        </Show>
    </Shows>
</Schedule>''';