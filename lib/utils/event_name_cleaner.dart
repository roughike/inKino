class EventNameCleaner {
  /// Strips unneeded noise out of the event names.
  ///
  /// For example:
  ///
  /// "Avengers: Infinity War (2D)" -> "Avengers: Infinity War"
  /// "Avengers: Infinity War (2D dub)" -> "Avengers: Infinity War"
  ///
  /// For more, see test/event_name_cleaner_test.dart.
  static final RegExp _pattern = new RegExp(r"(\s+(\(((([23]D)?\s*(dub)?)|[23]D)\)|[23]D))");
  
  static String cleanup(String name) {
    var firstMatches = _pattern.allMatches(name);

    if (firstMatches.isNotEmpty) {
      var shit = firstMatches.first.group(1);
      return name.replaceFirst(shit, '');
    }

    return name;
  }
}