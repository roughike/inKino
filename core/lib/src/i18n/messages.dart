import 'package:intl/intl.dart';

class Messages {
  String get appName => Intl.message('inKino', name: 'appName');
  String get nowInTheaters => Intl.message(
        'Now in theaters',
        name: 'nowInTheaters',
      );
  String get showtimes => Intl.message(
        'Showtimes',
        name: 'showtimes',
      );
  String get comingSoon => Intl.message(
        'Coming soon',
        name: 'comingSoon',
      );

  String get oops => Intl.message('Oops!', name: 'oops');
  String get loadingMoviesError => Intl.message(
        'There was an error while\nloading movies.',
        name: 'loadingMoviesError',
      );
  String get tryAgain => Intl.message('TRY AGAIN', name: 'tryAgain');

  String get director => Intl.message('Director', name: 'director');
  String get storyline => Intl.message('Storyline', name: 'storyline');
  String get collapseStoryline =>
      Intl.message('touch to collapse', name: 'collapseStoryline');
  String get expandStoryline =>
      Intl.message('touch to expand', name: 'expandStoryline');
  String get cast => Intl.message('Cast', name: 'cast');
  String get gallery => Intl.message('Gallery', name: 'gallery');

  String get releaseDate => Intl.message('Release date', name: 'releaseDate');
  String get at => Intl.message(
        'at',
        name: 'at',
        meaning: 'Means time. For example, "the meeting is at 6PM".',
      );

  String get tickets => Intl.message('Tickets', name: 'tickets');
  String get allEmpty => Intl.message('All empty!', name: 'allEmpty');
  String get noMovies =>
      Intl.message('Didn\'t find any movies at\nall.', name: 'noMovies');
  String get errorLoadingEvents =>
      Intl.message('Error loading events.', name: 'errorLoadingEvents');

  String get noMoviesForToday => Intl.message(
        'Didn\'t find any movies\nabout to start for today. ¯\\_(ツ)_/¯',
        name: 'noMoviesForToday',
      );
  String get about => Intl.message('About', name: 'about');
  String get aboutInKino => Intl.message('About inKino', name: 'aboutInKino');
  String get gotIt => Intl.message('Okay, got it!', name: 'gotIt');
  String get aboutInKinoDescription => Intl.message(
        'inKino is the unofficial Finnkino client that is minimalistic, fast, and delightful to use.',
        name: 'aboutInKinoDescription',
      );
  String get appDevelopedWith => Intl.message(
        'The app was developed with',
        name: 'appDevelopedWith',
      );
  String get checkoutRepo => Intl.message(
        'and it\'s open source; check out the source code yourself from',
        name: 'checkoutRepo',
      );
  String get githubRepo => Intl.message('the GitHub repo', name: 'githubRepo');
  String get tmdbAttribution => Intl.message(
        'This product uses the TMDb API but is not endorsed or certified by TMDb.',
        name: 'tmdbAttribution',
      );

  String get searchHint =>
      Intl.message('Search movies & showtimes...', name: 'searchHint');
}
