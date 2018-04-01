import 'dart:async';
import 'dart:io';

import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/theater/theater_middleware.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  group('TheaterMiddleware', () {
    final log = <dynamic>[];
    final next = (action) => log.add(action);

    MockAssetBundle mockAssetBundle;
    TheaterMiddleware sut;

    setUp(() {
      mockAssetBundle = new MockAssetBundle();
      //sut = new TheaterMiddleware(mockAssetBundle);

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

      final InitCompleteAction initComplete = log.single;
      expect(initComplete.theaters.length, 3);
    });
  });
}
