import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inkino/data/models/actor.dart';
import 'package:inkino/data/models/event.dart';

class TMDBApi {
  static final String apiKey = '49a380e638f1a16af9deb353fe640d51';
  static final String baseUrl = 'api.themoviedb.org';

  Future<List<Actor>> findAvatarsForActors(
      Event event, List<Actor> actors) async {
    int movieId = await _findMovieId(event.cleanedUpOriginalTitle);

    if (movieId != null) {
      return _getActorAvatars(movieId);
    }

    return actors;
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

    var response = await http.get(searchUri);
    var movieSearchJson = JSON.decode(response.body);
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

    var response = await http.get(actorUri);
    var movieActors = JSON.decode(response.body);

    return _parseActorAvatars(movieActors['cast']);
  }

  List<Actor> _parseActorAvatars(List<Map<String, dynamic>> movieCast) {
    var actorsWithAvatars = <Actor>[];

    movieCast.forEach((castMember) {
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
