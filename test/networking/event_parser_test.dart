import 'package:inkino/models/event.dart';
import 'package:inkino/networking/event_parser.dart';
import 'package:test/test.dart';

void main() {
  group('EventParser', () {
    test('parsing tests', () {
      List<Event> deserialized = EventParser.parse(eventsXml);
      expect(deserialized.length, 3);

      var paris1517 = deserialized.first;
      expect(paris1517.id, '302535');
      expect(paris1517.title, '15:17 Pariisiin');
      expect(paris1517.originalTitle, 'The 15:17 to Paris');
      expect(paris1517.productionYear, '2018');
      expect(paris1517.genres, 'Draama, Jännitys');
      expect(paris1517.directors.length, 1);
      expect(paris1517.directors.first, 'Clint Eastwood');
      expect(paris1517.actors.length, 11);
      expect(paris1517.actors.first.name, 'Anthony Sadler');
      expect(paris1517.lengthInMinutes, '94');
      expect(paris1517.shortSynopsis, 'Short synopsis goes here.');
      expect(paris1517.synopsis, 'Synopsis goes here.');
      expect(paris1517.youtubeTrailers.length, 1);
      expect(paris1517.youtubeTrailers.first,
          'https://youtube.com/watch?v=oFa4C6OcuM4');
      expect(
        paris1517.images.portraitSmall,
        'http://media.finnkino.fi/1012/Event_11881/portrait_small/The1517toParis_1080.jpg',
      );
    });
  });
}

const String eventsXml = '''<?xml version="1.0"?>
<Events xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <Event>
        <ID>302535</ID>
        <Title>15:17 Pariisiin (2D dub)</Title>
        <OriginalTitle>The 15:17 to Paris (2D dub)</OriginalTitle>
        <ProductionYear>2018</ProductionYear>
        <LengthInMinutes>94</LengthInMinutes>
        <dtLocalRelease>2018-02-16T00:00:00</dtLocalRelease>
        <Rating>12</Rating>
        <RatingLabel>12</RatingLabel>
        <RatingImageUrl>https://media.finnkino.fi/images/rating_large_12.png</RatingImageUrl>
        <LocalDistributorName>SF Film Finland Oy</LocalDistributorName>
        <GlobalDistributorName>SF Film Finland Oy</GlobalDistributorName>
        <ProductionCompanies>-</ProductionCompanies>
        <EventType>Movie</EventType>
        <Genres>Draama, Jännitys</Genres>
        <ShortSynopsis>Short synopsis goes here.</ShortSynopsis>
        <Synopsis>Synopsis goes here.</Synopsis>
        <EventURL>http://www.finnkino.fi/event/302535/title/1517_pariisiin/</EventURL>
        <Images>
            <EventSmallImagePortrait>http://media.finnkino.fi/1012/Event_11881/portrait_small/The1517toParis_1080.jpg</EventSmallImagePortrait>
            <EventMediumImagePortrait>http://media.finnkino.fi/1012/Event_11881/portrait_medium/The1517toParis_1080.jpg</EventMediumImagePortrait>
            <EventLargeImagePortrait>http://media.finnkino.fi/1012/Event_11881/portrait_small/The1517toParis_1080.jpg</EventLargeImagePortrait>
            <EventSmallImageLandscape>http://media.finnkino.fi/1012/Event_11881/landscape_small/The1517toParis_444.jpg</EventSmallImageLandscape>
            <EventLargeImageLandscape>http://media.finnkino.fi/1012/Event_11881/landscape_large/The1517toParis_670.jpg</EventLargeImageLandscape>
        </Images>
        <Videos>
            <EventVideo>
                <Title>Katso traileri</Title>
                <Location>oFa4C6OcuM4</Location>
                <ThumbnailLocation />
                <MediaResourceSubType>EventTrailer</MediaResourceSubType>
                <MediaResourceFormat>YouTubeVideo</MediaResourceFormat>
            </EventVideo>
        </Videos>
        <Cast>
            <Actor>
                <FirstName>Anthony</FirstName>
                <LastName>Sadler</LastName>
            </Actor>
            <Actor>
                <FirstName>Alek</FirstName>
                <LastName>Skarlatos</LastName>
            </Actor>
            <Actor>
                <FirstName>Spencer</FirstName>
                <LastName>Stone</LastName>
            </Actor>
            <Actor>
                <FirstName>Jenna</FirstName>
                <LastName>Fischer</LastName>
            </Actor>
            <Actor>
                <FirstName>Judy</FirstName>
                <LastName>Greer</LastName>
            </Actor>
            <Actor>
                <FirstName>P.J.</FirstName>
                <LastName>Byrne</LastName>
            </Actor>
            <Actor>
                <FirstName>Tony</FirstName>
                <LastName>Hale</LastName>
            </Actor>
            <Actor>
                <FirstName>Thomas</FirstName>
                <LastName>Lennon</LastName>
            </Actor>
            <Actor>
                <FirstName>Paul-Mikél</FirstName>
                <LastName>Williams</LastName>
            </Actor>
            <Actor>
                <FirstName>Bryce</FirstName>
                <LastName>Gheisar</LastName>
            </Actor>
            <Actor>
                <FirstName>William</FirstName>
                <LastName>Jennings</LastName>
            </Actor>
        </Cast>
        <Directors>
            <Director>
                <FirstName>Clint</FirstName>
                <LastName>Eastwood</LastName>
            </Director>
        </Directors>
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
    </Event>
    <Event>
        <ID>302465</ID>
        <Title>95</Title>
        <OriginalTitle>95</OriginalTitle>
        <ProductionYear>2017</ProductionYear>
        <LengthInMinutes>107</LengthInMinutes>
        <dtLocalRelease>2017-12-25T00:00:00</dtLocalRelease>
        <Rating>7</Rating>
        <RatingLabel>7</RatingLabel>
        <RatingImageUrl>https://media.finnkino.fi/images/rating_large_7.png</RatingImageUrl>
        <LocalDistributorName>SF Film Finland Oy</LocalDistributorName>
        <GlobalDistributorName>SF Film Finland Oy</GlobalDistributorName>
        <ProductionCompanies>-</ProductionCompanies>
        <EventType>Movie</EventType>
        <Genres>Draama, Kotimainen</Genres>
        <ShortSynopsis>Vuoden 1995 jääkiekon maailmanmestaruusviikonloppuun sijoittuva 95-elokuva kertoo toisiinsa limittyvien tarinoiden kautta siitä, miksi Suomesta tuli maailmanmestari ja miten se vaikutti koko kansakuntaan. 95 on osa virallista Suomi 100 -juhlavuoden ohjelmistoa.</ShortSynopsis>
        <Synopsis>Vuoden 1995 jääkiekon maailmanmestaruusviikonloppuun sijoittuva 95-elokuva kertoo toisiinsa limittyvien tarinoiden kautta siitä, miksi Suomesta tuli maailmanmestari ja miten se vaikutti koko kansakuntaan.

            95 on osa virallista Suomi 100 -juhlavuoden ohjelmistoa.

            Rooleissa: Curt Lindström – Jens Hulten, Hannu Aravirta – Kari-Pekka Toivonen, Heikki Riihiranta – Pekka Huotari, Saku Koivu – Jon-Jon Geitel, Ville Peltonen – Akseli Kouki, Jere Lehtinen – Kustaa Tuohimaa, Timo Jutila – Joel Hirvonen, Janne Ojanen – Oskari Ojanen, Marko Palo – Valtteri Honka, Marko Kiprusoff – Karlo Haapiainen, Raimo Helminen – Sebastian Rejman, Sami Kapanen – Mikko Laine, Esa Keskinen – Topias Hirvelä, Hannu Virta – Jarkko Järvinen, Mika Nieminen – Victor Paul, Antti Törmänen – Lauri Talvio, Jukka Tammi – Lauri Tilkanen, Raimo Summanen – Akseli Mattila, Ari Sulander – Henri Nyqvist, Mika Strömberg – Rasmus Tarkiainen, Erik Hämäläinen – Tommi Lipasti, Petteri Nummelin – Ronny Roslöf, Janne Niinimaa – Kimi Vilkkula, Juha Ylönen – Mikko Lindbom, Jarmo Myllys – Hannes Suominen, Tero Lehterä – Roman Tiinus</Synopsis>
        <EventURL>http://www.finnkino.fi/event/302465/title/95/</EventURL>
        <Images>
            <!-- Testing empty images element -->
            <SomeOtherImage>test</SomeOtherImage>
        </Images>
        <Videos>
            <EventVideo>
                <Title>Katso traileri</Title>
                <Location>AUlP8Sgzzk0</Location>
                <ThumbnailLocation />
                <MediaResourceSubType>EventTrailer</MediaResourceSubType>
                <MediaResourceFormat>YouTubeVideo</MediaResourceFormat>
            </EventVideo>
        </Videos>
        <Cast>
            <Actor>
                <FirstName>Jens</FirstName>
                <LastName>Hulten</LastName>
            </Actor>
            <Actor>
                <FirstName>Kari-Pekka</FirstName>
                <LastName>Toivonen</LastName>
            </Actor>
            <Actor>
                <FirstName>Jon-Jon</FirstName>
                <LastName>Geitel</LastName>
            </Actor>
            <Actor>
                <FirstName>Akseli</FirstName>
                <LastName>Kouki</LastName>
            </Actor>
            <Actor>
                <FirstName>Kustaa</FirstName>
                <LastName>Tuohimaa</LastName>
            </Actor>
            <Actor>
                <FirstName>Joel</FirstName>
                <LastName>Hirvonen</LastName>
            </Actor>
        </Cast>
        <Directors>
            <!-- Testing empty Directors element -->
            <Test>test</Test>
        </Directors>
        <ContentDescriptors>
            <ContentDescriptor>
                <Name>Disturbing</Name>
                <ImageURL>https://media.finnkino.fi/images/content_Disturbing.png</ImageURL>
            </ContentDescriptor>
        </ContentDescriptors>
    </Event>
    <Event>
        <ID>302478</ID>
        <Title>All the Money in the World</Title>
        <OriginalTitle>All the Money in the World</OriginalTitle>
        <ProductionYear>2017</ProductionYear>
        <LengthInMinutes>133</LengthInMinutes>
        <dtLocalRelease>2018-01-12T00:00:00</dtLocalRelease>
        <Rating>16</Rating>
        <RatingLabel>16</RatingLabel>
        <RatingImageUrl>https://media.finnkino.fi/images/rating_large_16.png</RatingImageUrl>
        <LocalDistributorName>SF Film Finland Oy</LocalDistributorName>
        <GlobalDistributorName>SF Film Finland Oy</GlobalDistributorName>
        <ProductionCompanies>-</ProductionCompanies>
        <EventType>Movie</EventType>
        <Genres>Draama, Jännitys</Genres>
        <ShortSynopsis>Elokuva kertoo 16-vuotiaan John Paul Getty III:n (Charlie Plummer) kidnappauksesta ja hänen omistautuneen äitinsä Gailin (Michelle Williams) epätoivoisesta yrityksestä saada poikansa miljonääri isoisä (Christopher Plummer) maksamaan lunnaat.</ShortSynopsis>
        <Synopsis>Elokuva kertoo 16-vuotiaan John Paul Getty III:n (Charlie Plummer) kidnappauksesta ja hänen omistautuneen äitinsä Gailin (Michelle Williams) epätoivoisesta yrityksestä saada poikansa miljonääri isoisä (Christopher Plummer) maksamaan lunnaat. Getty vanhemman kieltäytyessä, ja sieppaajien muuttuessa yhä epävakaammiksi ja brutaalimmaksi, Gail yrittää vedota häneen. Poikansa elämän ollessa vaakalaudalla, Gailista ja Gettyn neuvonantajasta (Mark Wahlberg) muodostuu epätavalliset liittolaiset kilpailussa aikaa vastaan. Kilpailussa, joka lopulta paljastaa rakkauden todellisen arvon suhteessa rahaan.</Synopsis>
        <EventURL>http://www.finnkino.fi/event/302478/title/all_the_money_in_the_world/</EventURL>

        <!-- Testing event without "Images" tag at all -->

        <Videos>
            <EventVideo>
                <Title>Katso traileri</Title>
                <Location>GKc9LWtlAW4</Location>
                <ThumbnailLocation />
                <MediaResourceSubType>EventTrailer</MediaResourceSubType>
                <MediaResourceFormat>YouTubeVideo</MediaResourceFormat>
            </EventVideo>
        </Videos>
        <Cast>
            <Actor>
                <FirstName>Michelle</FirstName>
                <LastName>Williams</LastName>
            </Actor>
            <Actor>
                <FirstName>Mark</FirstName>
                <LastName>Wahlberg</LastName>
            </Actor>
            <Actor>
                <FirstName>Christopher</FirstName>
                <LastName>Plummer</LastName>
            </Actor>
            <Actor>
                <FirstName>Romain</FirstName>
                <LastName>Duris</LastName>
            </Actor>
            <Actor>
                <FirstName>Charlie</FirstName>
                <LastName>Plummer</LastName>
            </Actor>
            <Actor>
                <FirstName>Timothy</FirstName>
                <LastName>Hutton</LastName>
            </Actor>
            <Actor>
                <FirstName>Dan</FirstName>
                <LastName>Friedkin</LastName>
            </Actor>
        </Cast>
        <Directors>
            <Director>
                <FirstName>Ridley</FirstName>
                <LastName>Scott</LastName>
            </Director>
            <Director>
                <FirstName>Clint</FirstName>
                <LastName>Eastwood</LastName>
            </Director>
        </Directors>
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
    </Event>
</Events>''';
