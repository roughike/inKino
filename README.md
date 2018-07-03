# inKino - a showtime browser for Finnkino cinemas

[![Build Status](https://travis-ci.org/roughike/inKino.svg?branch=development)](https://travis-ci.org/roughike/inKino) [![Coverage Status](https://coveralls.io/repos/github/roughike/inKino/badge.svg?branch=development)](https://coveralls.io/github/roughike/inKino?branch=development)

<img src="https://github.com/roughike/inKino/blob/development/screenshots/now_in_theaters.png" width="33%" /> <img src="https://github.com/roughike/inKino/blob/development/screenshots/showtimes.png" width="33%" /> <img src="https://github.com/roughike/inKino/blob/development/screenshots/event_details.png" width="33%" />

## What is inKino?

inKino is a minimal app for browsing movies and showtimes for [Finnkino](https://finnkino.fi/) cinemas. It's made with [Flutter](https://flutter.io/), uses [flutter_redux](https://github.com/brianegan/flutter_redux),  and has an [extensive set of unit and widget tests](https://github.com/roughike/inKino/tree/development/test). It also has smooth transition animations and handles offline use cases gracefully.

While I built inKino for my own needs, it is also intented to showcase good app structure and a clean, well-organized Flutter codebase. The app uses the [Finnkino XML API](https://finnkino.fi/xml) for fetching movies and showtimes, and the [TMDB API](https://www.themoviedb.org/documentation/api) for fetching the actor avatars.

The source code is **100% Dart**, and everything resides in the [/lib](https://github.com/roughike/inKino/tree/development/lib) folder.

<div>
<a href='https://play.google.com/store/apps/details?id=com.roughike.inkino'><img alt='Get it on Google Play' src='https://github.com/roughike/inKino/blob/development/screenshots/google_play.png' height='40px'/></a> <a href='https://itunes.apple.com/us/app/inkino/id1367181450'><img alt='Get it on the App Store' src='https://github.com/roughike/inKino/blob/development/screenshots/app_store.png' height='40px'/></a>
</div>

## Building the project

### Renaming the TMDB configuration file

If you try to build the project straight away, you'll get an error complaining that a `tmdb_config.dart` file is missing. To resolve that, run this on your terminal in the project root:

```bash
cd lib && mv tmdb_config.dart.sample tmdb_config.dart && cd ..
```

**OR**

If you don't trust in random bash scripts copied from the Internet, you can just rename the `tmdb_config.dart.sample` to `tmdb_config.dart` manually.

### Building from source

To build the project, ensure that you have a recent version of the Flutter SDK installed. Then either run `flutter run` in the project root or use your IDE of choice. To run the tests, run `flutter test` in the project root.

## Contributing

Contributions are welcome! However, if it's going to be a major change, please create an issue first. Before starting to work on something, please comment on a specific issue and say you'd like to work on it.

## Thanks

Special thanks to [Thibaud Colas](https://twitter.com/thibaud_colas), [Brian Egan](https://twitter.com/brianegan), [Alessandro Aime](https://twitter.com/aimealessandro) and [Juho Rautioaho](https://github.com/Jraut) for giving their extra pair of eyes for reviewing the source code.
