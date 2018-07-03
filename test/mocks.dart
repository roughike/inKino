import 'dart:io';

import 'package:flutter/services.dart';
import 'package:inkino/networking/finnkino_api.dart';
import 'package:inkino/redux/app/app_state.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockFile extends Mock implements File {}

class MockFinnkinoApi extends Mock implements FinnkinoApi {}
class MockAssetBundle extends Mock implements AssetBundle {}

class MockStore extends Mock implements Store<AppState> {}
class MockPreferences extends Mock implements SharedPreferences {}