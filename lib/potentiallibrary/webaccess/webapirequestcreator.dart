import 'dart:convert';

import 'package:flutter_jukebox/potentiallibrary/webaccess/webapirequest.dart';

abstract class IWebApiRequestCreator {
  String createWebApiRequestJson(request);
}

class WebApiRequestCreator extends IWebApiRequestCreator {
  @override
  String createWebApiRequestJson(request) {
    var webApiRequest = createWebApiRequest(request);
    return jsonEncode(webApiRequest);
  }

  WebApiRequest createWebApiRequest(request) {
    return WebApiRequest(request);
  }
}
