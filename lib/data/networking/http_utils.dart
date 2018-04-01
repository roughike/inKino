import 'dart:async';
import 'dart:convert';
import 'dart:io';

final _httpClient = new HttpClient();

Future<String> getRequest(Uri uri) async {
  var request = await _httpClient.getUrl(uri);
  var response = await request.close();

  return response.transform(UTF8.decoder).join();
}
