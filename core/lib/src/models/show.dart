import 'package:kt_dart/collection.dart';

import 'content_descriptor.dart';
import 'event.dart';

class Show {
  Show({
    this.id,
    this.eventId,
    this.title,
    this.originalTitle,
    this.ageRating,
    this.ageRatingUrl,
    this.url,
    this.presentationMethod,
    this.theaterAndAuditorium,
    this.start,
    this.end,
    this.images,
    this.contentDescriptors,
  });

  final String id;
  final String eventId;
  final String title;
  final String originalTitle;
  final String ageRating;
  final String ageRatingUrl;
  final String url;
  final String presentationMethod;
  final String theaterAndAuditorium;
  final DateTime start;
  final DateTime end;
  final EventImageData images;
  final KtList<ContentDescriptor> contentDescriptors;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Show &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          eventId == other.eventId &&
          title == other.title &&
          originalTitle == other.originalTitle &&
          ageRating == other.ageRating &&
          ageRatingUrl == other.ageRatingUrl &&
          url == other.url &&
          presentationMethod == other.presentationMethod &&
          theaterAndAuditorium == other.theaterAndAuditorium &&
          start == other.start &&
          end == other.end &&
          images == other.images &&
          contentDescriptors == other.contentDescriptors;

  @override
  int get hashCode =>
      id.hashCode ^
      eventId.hashCode ^
      title.hashCode ^
      originalTitle.hashCode ^
      ageRating.hashCode ^
      ageRatingUrl.hashCode ^
      url.hashCode ^
      presentationMethod.hashCode ^
      theaterAndAuditorium.hashCode ^
      start.hashCode ^
      end.hashCode ^
      images.hashCode ^
      contentDescriptors.hashCode;
}
