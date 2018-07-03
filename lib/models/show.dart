class Show {
  Show({
    this.id,
    this.eventId,
    this.title,
    this.originalTitle,
    this.url,
    this.presentationMethod,
    this.theaterAndAuditorium,
    this.start,
    this.end,
  });

  final String id;
  final String eventId;
  final String title;
  final String originalTitle;
  final String url;
  final String presentationMethod;
  final String theaterAndAuditorium;
  final DateTime start;
  final DateTime end;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Show &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          eventId == other.eventId &&
          title == other.title &&
          originalTitle == other.originalTitle &&
          url == other.url &&
          presentationMethod == other.presentationMethod &&
          theaterAndAuditorium == other.theaterAndAuditorium &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode =>
      id.hashCode ^
      eventId.hashCode ^
      title.hashCode ^
      originalTitle.hashCode ^
      url.hashCode ^
      presentationMethod.hashCode ^
      theaterAndAuditorium.hashCode ^
      start.hashCode ^
      end.hashCode;
}
