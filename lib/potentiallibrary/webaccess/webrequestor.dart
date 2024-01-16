import 'dart:convert';
import 'package:flutter_jukebox/potentiallibrary/programexception.dart';
import 'webaccess.dart';

abstract class IWebRequestor {
  Future<T> get<T>(
      String url, T Function(Map<String, dynamic> data) deserialise);
  Future<String> post(String url);
}

class WebRequestor extends IWebRequestor {
  final IWebAccess _webAccess;

  WebRequestor(this._webAccess);

  @override
  Future<T> get<T>(
      String url, T Function(Map<String, dynamic> data) deserialise) async {
    var requestJson = await _webAccess.getTextWebData(url);
    var request = jsonDecode(requestJson);

    var error = request['error'];
    if (error != null) {
      throw ProgramException('WebRequest error: $error');
    }

    var response = deserialise(request['response']);

    return response;
  }

  @override
  Future<String> post(String url) async {
    return _webAccess.post(url);
  }
}
