import 'dart:async';
import 'dart:io' as io;

import 'package:mockito/mockito.dart';

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
class TestHttpOverrides extends io.HttpOverrides {
  io.HttpClient createHttpClient(io.SecurityContext context) {
    return createMockImageHttpClient(context);
  }
}

class MockHttpClient extends Mock implements io.HttpClient {}
class MockHttpClientRequest extends Mock implements io.HttpClientRequest {}
class MockHttpClientResponse extends Mock implements io.HttpClientResponse {}
class MockHttpHeaders extends Mock implements io.HttpHeaders {}

// Returns a mock HTTP client that responds with an image to all requests.
MockHttpClient createMockImageHttpClient(io.SecurityContext _) {
  final MockHttpClient client = new MockHttpClient();
  final MockHttpClientRequest request = new MockHttpClientRequest();
  final MockHttpClientResponse response = new MockHttpClientResponse();
  final MockHttpHeaders headers = new MockHttpHeaders();

  when(client.getUrl(typed(any))).thenAnswer((_) => new Future<io.HttpClientRequest>.value(request));
  when(request.headers).thenReturn(headers);
  when(request.close()).thenAnswer((_) => new Future<io.HttpClientResponse>.value(response));
  when(response.contentLength).thenReturn(_transparentImage.length);
  when(response.statusCode).thenReturn(io.HttpStatus.OK);
  when(response.listen(typed(any))).thenAnswer((Invocation invocation) {
    final void Function(List<int>) onData = invocation.positionalArguments[0];
    final void Function() onDone = invocation.namedArguments[#onDone];
    final void Function(Object, [StackTrace]) onError = invocation.namedArguments[#onError];
    final bool cancelOnError = invocation.namedArguments[#cancelOnError];

    return new Stream<List<int>>.fromIterable(<List<int>>[_transparentImage])
        .listen(onData, onDone: onDone, onError: onError, cancelOnError: cancelOnError);
  });

  return client;
}

const List<int> _transparentImage = const <int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49,
  0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06,
  0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44,
  0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D,
  0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
];