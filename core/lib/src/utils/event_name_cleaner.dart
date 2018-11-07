class EventNameCleaner {
  /// Strips unneeded noise out of the event names.
  ///
  /// For example:
  ///
  /// "Avengers: Infinity War (2D)" -> "Avengers: Infinity War"
  /// "Avengers: Infinity War (2D dub)" -> "Avengers: Infinity War"
  ///
  /// For more, see test/event_name_cleaner_test.dart.
  static final _pattern = RegExp(
    r"(\s([23]D$|\(([23]D|dub|orig|spanish|swe|sing-along).*|\s*-\s*erikoisnäytös|\s*-\s*preview))",
    caseSensitive: false,
  );

  static String cleanup(String name) {
    final matches = _pattern.allMatches(name);
    final hasNoise = matches.isNotEmpty;

    if (hasNoise) {
      // "noise" means (2D dub), (3D dub), etc.
      final noise = matches.first.group(1);
      return name.replaceFirst(noise, '');
    }

    return name;
  }
}
