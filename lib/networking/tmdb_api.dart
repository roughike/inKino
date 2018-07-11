import 'dart:async';
import 'dart:convert';

import 'package:inkino/models/actor.dart';
import 'package:inkino/models/event.dart';
/// If this has a red underline, it means that the lib/tmdb_config.dart file
/// is not present on the project. Refer to the README for instructions
/// on how to do so.
import 'package:inkino/tmdb_config.dart';
import 'package:inkino/utils/http_utils.dart';
/// If this has a red underline, it means that the lib/tmdb_config.dart file
/// is not present on the project. Refer to the README for instructions
/// on how to do so.

/// If this has a red underline, it means that the lib/tmdb_config.dart file
/// is not present on the project. Refer to the README for instructions
/// on how to do so.



class TMDBApi {
  static final String baseUrl = 'api.themoviedb.org';

  Future<List<Actor>> findAvatarsForActors(
      Event event, List<Actor> actors) async {
    int movieId = await _findMovieId(event.originalTitle, event.productionYear);

    if (movieId != null) {
      return _getActorAvatars(movieId);
    }

    return actors;
  }

  Future<int> _findMovieId(String movieTitle, String movieYear) async {
    var searchUri = Uri.https(
      baseUrl,
      '3/search/movie',
      <String, String>{
        'api_key': TMDBConfig.apiKey,
        'query': movieTitle,
        'year': movieYear,
      },
    );

    var response = await getRequest(searchUri);
    Map<String, dynamic> movieSearchJson = json.decode(response);
    var searchResults =
        (movieSearchJson['results'] as List).cast<Map<String, dynamic>>();

    if (searchResults.isNotEmpty) {
      return searchResults.first['id'];
    }

    return null;
  }

  Future<List<Actor>> _getActorAvatars(int movieId) async {
    var actorUri = Uri.https(
      baseUrl,
      '3/movie/$movieId/credits',
      <String, String>{'api_key': TMDBConfig.apiKey},
    );

    var response = await getRequest(actorUri);
    Map<String, dynamic> movieActors = json.decode(response);

    return _parseActorAvatars(
        (movieActors['cast'] as List).cast<Map<String, dynamic>>());
  }

  List<Actor> _parseActorAvatars(List<Map<String, dynamic>> movieCast) {
    var actorsWithAvatars = <Actor>[];

    movieCast.forEach((Map<String, dynamic> castMember) {
      String pp = castMember['profile_path'];
      var profilePath =
          pp != null ? 'https://image.tmdb.org/t/p/w200$pp' : null;

      actorsWithAvatars.add(Actor(
        name: castMember['name'],
        avatarUrl: profilePath,
      ));
    });

    return actorsWithAvatars;
  }
}
