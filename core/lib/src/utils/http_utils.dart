import 'dart:async';
import 'dart:convert';
import 'dart:io';

final _httpClient = HttpClient();

Future<String> getRequest(Uri uri) async {
  final request = await _httpClient.getUrl(uri);
  final response = await request.close();

  return response.transform(utf8.decoder).join();
}
