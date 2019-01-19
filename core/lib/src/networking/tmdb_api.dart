import 'dart:async';
import 'dart:convert';

import 'package:core/src/models/actor.dart';
import 'package:core/src/models/event.dart';
import 'package:core/src/tmdb_config.dart';
import 'package:http/http.dart';
import 'package:kt_dart/collection.dart';

/// If this has a red underline, it means that the lib/tmdb_config.dart file
/// is not present on the project. Refer to the README for instructions
/// on how to do so.

class TMDBApi {
  TMDBApi(this.client);
  final Client client;

  static final String baseUrl = 'api.themoviedb.org';

  Future<KtList<Actor>> findAvatarsForActors(
      Event event, KtList<Actor> actors) async {
    int movieId = await _findMovieId(event.originalTitle);

    if (movieId != null) {
      return _getActorAvatars(movieId);
    }

    return actors;
  }

  Future<int> _findMovieId(String movieTitle) async {
    final searchUri = Uri.https(baseUrl, '3/search/movie', {
      'api_key': TMDBConfig.apiKey,
      'query': movieTitle,
    });

    final response = await client.get(searchUri);
    Map<String, dynamic> movieSearchJson =
        json.decode(utf8.decode(response.bodyBytes));
    final searchResults =
        (movieSearchJson['results'] as List).cast<Map<String, dynamic>>();

    if (searchResults.isNotEmpty) {
      return searchResults.first['id'];
    }

    return null;
  }

  Future<KtList<Actor>> _getActorAvatars(int movieId) async {
    final actorUri = Uri.https(
      baseUrl,
      '3/movie/$movieId/credits',
      {'api_key': TMDBConfig.apiKey},
    );

    final response = await client.get(actorUri);
    Map<String, dynamic> movieActors =
        json.decode(utf8.decode(response.bodyBytes));

    return _parseActorAvatars(
        (movieActors['cast'] as List).cast<Map<String, dynamic>>());
  }

  KtList<Actor> _parseActorAvatars(List<Map<String, dynamic>> movieCast) {
    final actorsWithAvatars = mutableListOf<Actor>();

    movieCast.forEach((Map<String, dynamic> castMember) {
      String pp = castMember['profile_path'];
      final profilePath =
          pp != null ? 'https://image.tmdb.org/t/p/w200$pp' : null;

      actorsWithAvatars.add(Actor(
        name: castMember['name'],
        avatarUrl: profilePath,
      ));
    });

    return actorsWithAvatars;
  }
}
