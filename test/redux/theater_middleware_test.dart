import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:inkino/redux/actions.dart';
import 'package:inkino/redux/theater/theater_middleware.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockAssetBundle extends Mock implements AssetBundle {}

void main() {
  group('TheaterMiddleware', () {
    final log = <dynamic>[];
    final next = (action) => log.add(action);

    MockAssetBundle mockAssetBundle;
    TheaterMiddleware sut;

    setUp(() {
      mockAssetBundle = new MockAssetBundle();
      sut = new TheaterMiddleware(mockAssetBundle);

      log.clear();
    });

    test('when called with InitAction, loads the preloaded theaters', () async {
      var theaters = new File('test_assets/theaters.xml').readAsStringSync();
      when(mockAssetBundle.loadString(any))
          .thenReturn(new Future.value(theaters));

      await sut.call(null, new InitAction(), next);

      var requestedPath =
          verify(mockAssetBundle.loadString(captureAny)).captured.first;
      expect(requestedPath, 'assets/preloaded_data/theaters.xml');

      InitCompleteAction action = log.single;
      expect(action.theaters.length, 3);
    });
  });
}
