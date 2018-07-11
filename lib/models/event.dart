import 'package:inkino/models/actor.dart';
import 'package:meta/meta.dart';

enum EventListType {
  nowInTheaters,
  comingSoon,
}

class Event {
  Event({
    this.id,
    this.title,
    this.originalTitle,
    this.productionYear,
    this.genres,
    this.directors,
    this.actors,
    this.lengthInMinutes,
    this.shortSynopsis,
    this.synopsis,
    this.images,
    this.youtubeTrailers,
  });

  final String id;
  final String title;
  final String originalTitle;
  final String productionYear;
  final String genres;
  final List<String> directors;
  final String lengthInMinutes;
  final String shortSynopsis;
  final String synopsis;
  final EventImageData images;
  final List<String> youtubeTrailers;

  List<Actor> actors;

  bool get hasSynopsis =>
      (shortSynopsis != null && shortSynopsis.isNotEmpty) ||
      (synopsis != null && synopsis.isNotEmpty);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          originalTitle == other.originalTitle &&
          productionYear == other.productionYear &&
          genres == other.genres &&
          directors == other.directors &&
          lengthInMinutes == other.lengthInMinutes &&
          shortSynopsis == other.shortSynopsis &&
          synopsis == other.synopsis &&
          images == other.images &&
          youtubeTrailers == other.youtubeTrailers &&
          actors == other.actors;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      originalTitle.hashCode ^
      productionYear.hashCode ^
      genres.hashCode ^
      directors.hashCode ^
      lengthInMinutes.hashCode ^
      shortSynopsis.hashCode ^
      synopsis.hashCode ^
      images.hashCode ^
      youtubeTrailers.hashCode ^
      actors.hashCode;
}

class EventImageData {
  EventImageData({
    @required this.portraitSmall,
    @required this.portraitMedium,
    @required this.portraitLarge,
    @required this.landscapeSmall,
    @required this.landscapeBig,
  });

  final String portraitSmall;
  final String portraitMedium;
  final String portraitLarge;
  final String landscapeSmall;
  final String landscapeBig;

  String get anyAvailableImage =>
      portraitSmall ??
      portraitMedium ??
      portraitLarge ??
      landscapeSmall ??
      landscapeBig;

  EventImageData.empty()
      : portraitSmall = null,
        portraitMedium = null,
        portraitLarge = null,
        landscapeSmall = null,
        landscapeBig = null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventImageData &&
          runtimeType == other.runtimeType &&
          portraitSmall == other.portraitSmall &&
          portraitMedium == other.portraitMedium &&
          portraitLarge == other.portraitLarge &&
          landscapeSmall == other.landscapeSmall &&
          landscapeBig == other.landscapeBig;

  @override
  int get hashCode =>
      portraitSmall.hashCode ^
      portraitMedium.hashCode ^
      portraitLarge.hashCode ^
      landscapeSmall.hashCode ^
      landscapeBig.hashCode;
}
