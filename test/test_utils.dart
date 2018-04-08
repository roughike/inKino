import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as http;

/// This replaces the built-in HTTP client with a mocked one. The mocked client
/// will always return a transparent image.
///
/// This is a workaround needed for widget tests that use network images,
/// otherwise the test will crash.
///
/// For more context:
///
/// * https://github.com/flutter/flutter/issues/13433
/// * https://github.com/flutter/flutter_markdown/pull/17
void mockAllImageResponses() {
  createHttpClient = createMockImageHttpClient;
}

ValueGetter<http.Client> createMockImageHttpClient = () {
  return new http.MockClient((http.BaseRequest request) {
    return new Future<http.Response>.value(
        new http.Response.bytes(_transparentImage, 200, request: request),
    );
  });
};

const List<int> _transparentImage = const <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49,
  0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06,
  0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44,
  0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D,
  0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE
];
