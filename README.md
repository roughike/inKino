# inkino

## Building the project

To get the project to build, you need to add the following file:

**lib/tmdb_config.dart**

```dart
class TMDBConfig {
  /// The TMDB API is mostly used for loading actor avatars.
  ///
  /// Having a real API key here is optional; if this doesn't 
  /// contain the real API key, the app will still work, but 
  /// the actor avatars won't load.
  static final String apiKey = '<YOUR_API_KEY_HERE>';
}
```

That's all! Everything else is how you would build any other Flutter project.