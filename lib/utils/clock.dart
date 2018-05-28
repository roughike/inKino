typedef DateTime DateTimeGetter();

/// A class that has only one purpose: getting the current time.
///
/// Why? Because otherwise it's hard to test any code that depends on
/// the current time.
///
/// To see how to test with this, see:
///
/// * [test/redux/show_middleware_test.dart]
///
/// "Show usages" of [Clock.resetDateTimeGetter] will yield an up to date
/// list of all tests that use this class.
class Clock {
  /// The default date time getter, which returns the current date and time.
  static final defaultDateTimeGetter = () => DateTime.now();

  /// Resets the current mock implementation (if any) for [getCurrentTime]
  /// method back to an implementation that returns the current date and time.
  static void resetDateTimeGetter() => getCurrentTime = defaultDateTimeGetter;

  /// Used by production code to check the current date and time.
  ///
  /// Switch this to custom implementation in tests in order to test production
  /// code that depends on current date and time.
  static DateTimeGetter getCurrentTime = defaultDateTimeGetter;
}