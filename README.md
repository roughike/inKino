# inKino - a showtime browser for Finnkino cinemas

<img src="https://github.com/roughike/inKino/blob/development/screenshots/now_in_theaters.png" width="33%" /> <img src="https://github.com/roughike/inKino/blob/development/screenshots/showtimes.png" width="33%" /> <img src="https://github.com/roughike/inKino/blob/development/screenshots/event_details.png" width="33%" />

## What is inKino?

inKino is a minimal app for browsing movies and showtimes for [Finnkino](https://finnkino.fi/) cinemas. It's made with [Flutter](https://flutter.io/), uses [flutter_redux](https://github.com/brianegan/flutter_redux),  and has an [extensive set of unit and widget tests](https://github.com/roughike/inKino/tree/development/test). It also has smooth transition animations and handles offline use cases gracefully.

While I built inKino for my own needs, it is also intented to showcase good app structure and a clean, well-organized Flutter codebase. The app uses the [Finnkino XML API](https://finnkino.fi/xml) for fetching movies and showtimes, and the [TMDB API](https://www.themoviedb.org/documentation/api) for fetching the actor avatars.

The source code is **100% Dart**, and everything resides in the [/lib](https://github.com/roughike/inKino/tree/development/lib) folder.

<div>
<a href='https://play.google.com/store/apps/details?id=com.roughike.inkino'><img alt='Get it on Google Play' src='https://github.com/roughike/inKino/blob/development/screenshots/google_play.png' height='40px'/></a> <a href='https://itunes.apple.com/us/app/inkino/id1367181450'><img alt='Get it on the App Store' src='https://github.com/roughike/inKino/blob/development/screenshots/app_store.png' height='40px'/></a>
</div>

## Building the project

While it should work on older versions as well, the project is currently built with Flutter `v0.2.3` on the `beta` channel.

It won't build unless you add the following file manually:

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

## Contributing

Contributions are welcome! However, if it's going to be a major change, please create an issue first. 
