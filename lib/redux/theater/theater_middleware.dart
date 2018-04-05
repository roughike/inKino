import 'dart:async';

import 'package:flutter/services.dart';
import 'package:inkino/assets.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:inkino/data/models/theater.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TheaterMiddleware extends MiddlewareClass<AppState> {
  static const String kDefaultTheaterId = 'default_theater_id';

  final AssetBundle bundle;
  final SharedPreferences preferences;

  TheaterMiddleware(this.bundle, this.preferences);

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is InitAction) {
      await _init(action, next);
    } else if (action is ChangeCurrentTheaterAction) {
      await _changeCurrentTheater(action, next);
    } else {
      next(action);
    }
  }

  Future<Null> _init(
    InitAction action,
    NextDispatcher next,
  ) async {
    var theaterXml = await bundle.loadString(OtherAssets.preloadedTheaters);
    var theaters = Theater.parseAll(theaterXml);
    var currentTheater = _getDefaultTheater(theaters);

    next(new InitCompleteAction(theaters, currentTheater));
  }

  Future<Null> _changeCurrentTheater(
    ChangeCurrentTheaterAction action,
    NextDispatcher next,
  ) async {
    preferences.setString(kDefaultTheaterId, action.selectedTheater.id);
    next(action);
  }

  Theater _getDefaultTheater(List<Theater> allTheaters) {
    var persistedTheaterId = preferences.getString(kDefaultTheaterId);

    if (persistedTheaterId != null) {
      return allTheaters.singleWhere((theater) {
        return theater.id == persistedTheaterId;
      });
    }

    return allTheaters.first;
  }
}
