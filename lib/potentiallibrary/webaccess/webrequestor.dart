import 'dart:convert';

import 'webaccess.dart';

abstract class IWebRequestor {
  Future<T> get<T>(
      String url, T Function(Map<String, dynamic> data) deserialise);
}

class WebRequestor extends IWebRequestor {
  final IWebAccess _webAccess;

  WebRequestor(this._webAccess);

  @override
  Future<T> get<T>(
      String url, T Function(Map<String, dynamic> data) deserialise) async {
    var requestJson = await _webAccess.getTextWebData(url);

    var request = jsonDecode(requestJson);

    var response = deserialise(request['response']);

    return response;
  }
}
