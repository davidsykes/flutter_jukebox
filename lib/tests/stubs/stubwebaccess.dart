import 'package:flutter_jukebox/potentiallibrary/webaccess/webaccess.dart';

class StubWebAccess extends IWebAccess {
  @override
  Future<String> get(String url) {
    throw UnimplementedError();
  }

  @override
  Future<String> postText(String url, String body) {
    throw UnimplementedError();
  }

  @override
  Future<String> putText(String url, String body) {
    throw UnimplementedError();
  }
}
