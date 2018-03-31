import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:inkino/data/models/actor.dart';
import 'package:inkino/data/models/event.dart';

class TMDBApi {
  static final String apiKey = '<YOUR_API_KEY_HERE>';
  static final String baseUrl = 'api.themoviedb.org';

  Future<List<Actor>> findAvatarsForActors(
      Event event, List<Actor> actors) async {
    int movieId = await _findMovieId(event.cleanedUpOriginalTitle);

    if (movieId != null) {
      return _getActorAvatars(movieId);
    }

    return actors;
  }

  Future<String> _performGetRequest(Uri uri) async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(uri);
    var response = await request.close();

    return response.transform(UTF8.decoder).join();
  }

  Future<int> _findMovieId(String movieTitle) async {
    var searchUri = new Uri.https(
      baseUrl,
      '3/search/movie',
      <String, String>{
        'api_key': apiKey,
        'query': movieTitle,
      },
    );

    var movieSearchJson = JSON.decode(await _performGetRequest(searchUri));
    List<Map<String, dynamic>> searchResults = movieSearchJson['results'];

    if (searchResults.isNotEmpty) {
      return searchResults.first['id'];
    }

    return null;
  }

  Future<List<Actor>> _getActorAvatars(int movieId) async {
    var actorUri = new Uri.https(
      baseUrl,
      '3/movie/$movieId/credits',
      <String, String>{'api_key': apiKey},
    );

    var movieActors = JSON.decode(await _performGetRequest(actorUri));
    var actorsWithAvatars = <Actor>[];

    movieActors['cast'].forEach((castMember) {
      var pp = castMember['profile_path'];
      var profilePath =
          pp != null ? 'https://image.tmdb.org/t/p/w200$pp' : null;

      actorsWithAvatars.add(new Actor(
        name: castMember['name'],
        avatarUrl: profilePath,
      ));
    });

    return actorsWithAvatars;
  }
}
