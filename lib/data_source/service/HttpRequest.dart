import 'dart:convert' as Convert;

import 'package:http/http.dart' as http;
import 'package:movie/utils/ErrorCallBack.dart';

class HttpRequest {
  final baseUrl;

  HttpRequest(this.baseUrl);

  Future<dynamic> get(String uri, {Map<String, String>? headers}) async {
    try {
      http.Response response = await http.get(baseUrl + uri, headers: headers);
      final body = response.body;
      var result = Convert.jsonDecode(body);
      return result;
    } on Exception catch (e) {
      return e;
    }
  }

  Future<dynamic> query(String uri,
      {Map<String, String>? queryParameters,
      Map<String, String>? headers}) async {
    try {
      final uriRq = Uri.https(baseUrl, uri, queryParameters);
      http.Response response = await http.get(uriRq, headers: headers);
      final body = response.body;
      var result = Convert.jsonDecode(body);
      return result;
    } on Exception catch (e) {
      return e;
    }
  }

  Future<dynamic> getResponseBody(String uri,
      {Map<String, String>? headers}) async {
    try {
      http.Response response = await http.get(baseUrl + uri, headers: headers);
      final body = response.body;
      return body;
    } on Exception catch (e) {
      return e;
    }
  }
}
