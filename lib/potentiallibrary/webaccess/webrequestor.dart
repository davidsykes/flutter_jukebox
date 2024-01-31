import 'dart:convert';
import 'package:flutter_jukebox/potentiallibrary/programexception.dart';
import 'package:flutter_jukebox/potentiallibrary/webaccess/webapirequest.dart';
import 'webaccess.dart';

abstract class IWebRequestor {
  Future<T> get<T>(
      String url, T Function(Map<String, dynamic> data) deserialise);
  Future<TResponse> postApiRequest<TRequest, TResponse>(
      String url,
      TRequest request,
      TResponse Function(Map<String, dynamic> data) deserialiseResponse);
}

class WebRequestor extends IWebRequestor {
  final IWebAccess _webAccess;

  WebRequestor(this._webAccess);

  @override
  Future<T> get<T>(
      String url, T Function(Map<String, dynamic> data) deserialise) async {
    var requestJson = await _webAccess.get(url);

    return decodeResponse(requestJson, deserialise);
  }

  T decodeResponse<T>(
      String responseJson, T Function(Map<String, dynamic> data) deserialise) {
    var response = decodeJson(responseJson);

    var error = response['error'];
    if (error != null) {
      throw ProgramException('WebRequest error: $error');
    }

    var responseBody = deserialise(response['response']);

    return responseBody;
  }

  dynamic decodeJson(String json) {
    try {
      return jsonDecode(json);
    } on FormatException catch (e) {
      throw ProgramException('WebApi malformed response ${e.toString()}');
    }
  }

  @override
  Future<TResponse> postApiRequest<TRequest, TResponse>(
      String url,
      TRequest request,
      TResponse Function(Map<String, dynamic> data) deserialiseResponse) async {
    var requestJson = jsonEncode(request);
    var api = WebApiRequest(requestJson);
    var json = jsonEncode(api);
    var postResponse = await _webAccess.postText(url, json);

    return decodeResponse(postResponse, deserialiseResponse);
  }
}
