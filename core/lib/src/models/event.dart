import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';

import 'actor.dart';
import 'content_descriptor.dart';

enum EventListType {
  nowInTheaters,
  comingSoon,
}

class Event {
  Event({
    this.id,
    this.title,
    this.originalTitle,
    this.releaseDate,
    this.ageRating,
    this.ageRatingUrl,
    this.genres,
    this.directors,
    this.actors,
    this.lengthInMinutes,
    this.shortSynopsis,
    this.synopsis,
    this.images,
    this.contentDescriptors,
    this.youtubeTrailers,
    this.galleryImages,
  });

  final String id;
  final String title;
  final String originalTitle;
  final DateTime releaseDate;
  final String ageRating;
  final String ageRatingUrl;
  final String genres;
  final KtList<String> directors;
  final String lengthInMinutes;
  final String shortSynopsis;
  final String synopsis;
  final EventImageData images;
  final KtList<ContentDescriptor> contentDescriptors;
  final KtList<String> youtubeTrailers;
  final KtList<GalleryImage> galleryImages;

  String get director => directors.firstOrNull((e) => e != null);
  KtList<Actor> actors;
  KtList<String> get genresSeparated => listFrom(genres.split(', '));

  bool get hasSynopsis =>
      (shortSynopsis != null && shortSynopsis.isNotEmpty) ||
      (synopsis != null && synopsis.isNotEmpty);
  bool get hasMediumPortraitImage => images.portraitMedium != null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          originalTitle == other.originalTitle &&
          releaseDate == other.releaseDate &&
          ageRating == other.ageRating &&
          ageRatingUrl == other.ageRatingUrl &&
          genres == other.genres &&
          directors == other.directors &&
          lengthInMinutes == other.lengthInMinutes &&
          shortSynopsis == other.shortSynopsis &&
          synopsis == other.synopsis &&
          images == other.images &&
          contentDescriptors == other.contentDescriptors &&
          youtubeTrailers == other.youtubeTrailers &&
          actors == other.actors;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      originalTitle.hashCode ^
      releaseDate.hashCode ^
      ageRating.hashCode ^
      ageRatingUrl.hashCode ^
      genres.hashCode ^
      directors.hashCode ^
      lengthInMinutes.hashCode ^
      shortSynopsis.hashCode ^
      synopsis.hashCode ^
      images.hashCode ^
      contentDescriptors.hashCode ^
      youtubeTrailers.hashCode ^
      actors.hashCode;
}

class GalleryImage {
  GalleryImage({
    this.location,
    this.thumbnailLocation,
  });

  final String location;
  final String thumbnailLocation;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GalleryImage &&
          runtimeType == other.runtimeType &&
          location == other.location &&
          thumbnailLocation == other.thumbnailLocation;

  @override
  int get hashCode => location.hashCode ^ thumbnailLocation.hashCode;
}

class EventImageData {
  EventImageData({
    @required this.portraitSmall,
    @required this.portraitMedium,
    @required this.portraitLarge,
    @required this.landscapeSmall,
    @required this.landscapeBig,
    @required this.landscapeHd,
    @required this.landscapeHd2,
  });

  final String portraitSmall;
  final String portraitMedium;
  final String portraitLarge;
  final String landscapeSmall;
  final String landscapeBig;
  final String landscapeHd;
  final String landscapeHd2;

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
        landscapeBig = null,
        landscapeHd = null,
        landscapeHd2 = null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventImageData &&
          runtimeType == other.runtimeType &&
          portraitSmall == other.portraitSmall &&
          portraitMedium == other.portraitMedium &&
          portraitLarge == other.portraitLarge &&
          landscapeSmall == other.landscapeSmall &&
          landscapeBig == other.landscapeBig &&
          landscapeHd == other.landscapeHd &&
          landscapeHd2 == other.landscapeHd2;

  @override
  int get hashCode =>
      portraitSmall.hashCode ^
      portraitMedium.hashCode ^
      portraitLarge.hashCode ^
      landscapeSmall.hashCode ^
      landscapeBig.hashCode ^
      landscapeHd.hashCode ^
      landscapeHd2.hashCode;
}
