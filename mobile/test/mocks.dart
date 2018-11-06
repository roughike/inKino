import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockFile extends Mock implements File {}

class MockAssetBundle extends Mock implements AssetBundle {}

class MockPreferences extends Mock implements SharedPreferences {}
