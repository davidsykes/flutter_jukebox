import 'dart:convert';

import 'webrapiresponse.dart';

abstract class IWebApiResponseCreator {
  WebApiResponse createWebApiResponse(String textResponse);
}

class WebApiResponseCreator extends IWebApiResponseCreator {
  @override
  WebApiResponse createWebApiResponse(String textResponse) {
    var response = jsonDecode(textResponse);

    var error = response['error'];
    if (error != null) {
      return WebApiResponse(error);
    }
    return WebApiResponse();
  }
}
