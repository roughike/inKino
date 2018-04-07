class TMDBConfig {
  /// The TMDB API is mostly used for loading actor avatars.
  ///
  /// Adding this is optional; if this doesn't contain the real API key, the
  /// app will still work, but the actor avatars won't load.
  static final String apiKey = '<YOUR_API_KEY_HERE>';
}