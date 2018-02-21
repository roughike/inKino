import 'dart:async';

import 'package:flutter/services.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/app_state.dart';
import 'package:inkino/data/theater.dart';
import 'package:redux/redux.dart';

class TheaterMiddleware extends MiddlewareClass<AppState> {
  final AssetBundle bundle;
  TheaterMiddleware(this.bundle);

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is InitAction) {
      await _init(store, action, next);
    } else {
      next(action);
    }
  }

  Future<Null> _init(
    Store<AppState> store,
    InitAction action,
    NextDispatcher next,
  ) async {
    var theaterXml =
        await bundle.loadString('assets/preloaded_data/theaters.xml');
    var theaters = Theater.parseAll(theaterXml);

    next(new InitCompleteAction(theaters));
  }
}
