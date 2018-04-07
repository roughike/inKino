class EventNameCleaner {
  /// Strips unneeded noise out of the event names.
  ///
  /// For example:
  ///
  /// "Avengers: Infinity War (2D)" -> "Avengers: Infinity War"
  /// "Avengers: Infinity War (2D dub)" -> "Avengers: Infinity War"
  ///
  /// This is probably one of the most horrible regexes I've ever had to come up with.
  ///
  /// For more, see test/event_name_cleaner_test.dart.
  static final RegExp _pattern = new RegExp(
      r"(\s+(\(((([23]D)?\s*(dub|orig|spanish)?)|[23]D)\)\s*(\((dub|orig|spanish)?\))?|[23]D))");

  static String cleanup(String name) {
    var matches = _pattern.allMatches(name);
    var hasNoise = matches.isNotEmpty;

    if (hasNoise) {
      // "noise" means (2D dub), (3D dub), etc.
      var noise = matches.first.group(1);
      return name.replaceFirst(noise, '');
    }

    return name;
  }
}
