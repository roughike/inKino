import 'dart:io';

import 'package:core/src/networking/finnkino_api.dart';
import 'package:core/src/redux/app/app_state.dart';
import 'package:key_value_store/key_value_store.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

class MockFile extends Mock implements File {}

class MockFinnkinoApi extends Mock implements FinnkinoApi {}

class MockStore extends Mock implements Store<AppState> {}
class MockKeyValueStore extends Mock implements KeyValueStore {}