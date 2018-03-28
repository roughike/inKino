import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:inkino/data/actor.dart';
import 'package:inkino/data/event.dart';

class TMDBApi {
  static final String apiKey = '<YOUR_API_KEY_HERE>';
  static final String baseUrl = 'api.themoviedb.org';

  Future<List<Actor>> findAvatarsForActors(
      Event event, List<Actor> actors) async {
    var searchUri = new Uri.https(
      baseUrl,
      '3/search/movie',
      <String, String>{
        'api_key': apiKey,
        'query': event.originalTitle,
      },
    );

    var movieSearchJson = JSON.decode(await _performGetRequest(searchUri));
    var movieId = movieSearchJson['results'].first['id'];

    if (movieId == null) {
      return actors;
    }

    var actorUri = new Uri.https(
      baseUrl,
      '3/movie/$movieId/credits',
      <String, String>{'api_key': apiKey},
    );

    var movieActors = JSON.decode(await _performGetRequest(actorUri));
    var actorsWithAvatars = <Actor>[];

    // TODO: Use the "get configuration" method for TMDB api
    movieActors['cast'].forEach((castMember) {
      var pp = castMember['profile_path'];
      var profilePath =
          pp != null ? 'https://image.tmdb.org/t/p/w500$pp' : null;

      actorsWithAvatars.add(new Actor(
        name: castMember['name'],
        avatarUrl: profilePath,
      ));
    });

    return actorsWithAvatars;
  }

  Future<String> _performGetRequest(Uri uri) async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(uri);
    var response = await request.close();

    return response.transform(UTF8.decoder).join();
  }
}
