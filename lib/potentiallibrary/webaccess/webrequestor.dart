import 'dart:convert';
import 'package:flutter_jukebox/potentiallibrary/programexception.dart';
import 'package:flutter_jukebox/potentiallibrary/webaccess/webapirequest.dart';
import 'webaccess.dart';
import 'webrequestorresponse.dart';

abstract class IWebRequestor {
  Future<T> get<T>(
      String url, T Function(Map<String, dynamic> data) deserialise);
  Future<TResponse> postRequestResponse<TRequest, TResponse>(
      String url,
      TRequest request,
      TResponse Function(Map<String, dynamic> data) deserialiseResponse);
  Future<WebRequesterResponse> postRequestOk<TRequest, TResponse>(
      String url, TRequest request);
}

class WebRequestor extends IWebRequestor {
  final IWebAccess _webAccess;

  WebRequestor(this._webAccess);

  @override
  Future<T> get<T>(
      String url, T Function(Map<String, dynamic> data) deserialise) async {
    var webApiResponse = await _webAccess.get(url);
    var response = getResponseFromWebApiResponse(webApiResponse);
    if (response == null) {
      throw ProgramException('WebApi missing response.');
    } else {
      return deserialise(response);
    }
  }

  @override
  Future<TResponse> postRequestResponse<TRequest, TResponse>(
      String url,
      TRequest request,
      TResponse Function(Map<String, dynamic> data) deserialiseResponse) async {
    var postResponse = await getPostResponseFromPostRequest(url, request);
    var response = getResponseFromWebApiResponse(postResponse);
    if (response == null) {
      throw ProgramException('WebApi missing response.');
    } else {
      return deserialiseResponse(response);
    }
  }

  @override
  Future<WebRequesterResponse> postRequestOk<TRequest, TResponse>(
      String url, TRequest request) async {
    var postResponse = await getPostResponseFromPostRequest(url, request);
    var response = decodeJson(postResponse);

    var error = response['error'];
    if (error != null) {
      return WebRequesterResponse(error);
    }
    return WebRequesterResponse();
  }

  Future<String> getPostResponseFromPostRequest(String url, request) async {
    var api = WebApiRequest(request);
    var json = jsonEncode(api);
    return _webAccess.postText(url, json);
  }

  Map<String, dynamic>? getResponseFromWebApiResponse(String responseJson) {
    var response = decodeJson(responseJson);

    var error = response['error'];
    if (error != null) {
      throw ProgramException('WebRequest error: $error');
    }

    return response['response'];
  }

  dynamic decodeJson(String json) {
    try {
      return jsonDecode(json);
    } on FormatException catch (e) {
      throw ProgramException('WebApi malformed response ${e.toString()}');
    }
  }
}
