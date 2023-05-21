// https://dart.dev/guides/libraries/library-tour#http-client
//  dart 3_library/http/http_client.dart

import 'dart:io';
import 'dart:convert';

void main() async {
  var url = Uri.parse('http://localhost:8888/dart');
  var httpClient = HttpClient();
  var request = await httpClient.getUrl(url);
  var response = await request.close();
  var data = await utf8.decoder.bind(response).toList();
  print('Response ${response.statusCode}: $data');
  httpClient.close();
}
