import 'dart:convert';
import 'package:flutter_jukebox/potentiallibrary/programexception.dart';
import 'package:flutter_jukebox/potentiallibrary/webaccess/webapirequest.dart';
import 'webaccess.dart';
import 'webapirequestcreator.dart';
import 'webapiresponsecreator.dart';
import 'webrapiresponse.dart';

abstract class IWebRequestor {
  Future<T> get<T>(
      String url, T Function(Map<String, dynamic> data) deserialise);
  Future<TResponse> postRequestResponse<TRequest, TResponse>(
      String url,
      TRequest request,
      TResponse Function(Map<String, dynamic> data) deserialiseResponse);
  Future<WebApiResponse> postRequestOk<TRequest>(String url, TRequest request);
  Future<WebApiResponse> putRequestOk<TRequest>(String url, TRequest request);
}

class WebRequestor extends IWebRequestor {
  final IWebAccess _webAccess;
  final IWebApiRequestCreator _webApiRequestCreator;
  final IWebApiResponseCreator _webApiResponseCreator;

  WebRequestor(
      this._webAccess, this._webApiRequestCreator, this._webApiResponseCreator);

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
  Future<WebApiResponse> postRequestOk<TRequest>(
      String url, TRequest request) async {
    var postResponse = await getPostResponseFromPostRequest(url, request);
    var response = decodeJson(postResponse);

    var error = response['error'];
    if (error != null) {
      return WebApiResponse(error);
    }
    return WebApiResponse();
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

  @override
  Future<WebApiResponse> putRequestOk<TRequest>(
      String url, TRequest request) async {
    var webRequest = _webApiRequestCreator.createWebApiRequestJson(request);
    var textResponse = await _webAccess.putText(url, webRequest);
    var webApiResponse =
        _webApiResponseCreator.createWebApiResponse(textResponse);
    return webApiResponse;
  }

  dynamic decodeJson(String json) {
    try {
      return jsonDecode(json);
    } on FormatException catch (e) {
      throw ProgramException('WebApi malformed response ${e.toString()}');
    }
  }
}
