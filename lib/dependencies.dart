import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import 'potentiallibrary/webaccess/webaccess.dart';

class Dependencies {
  static const String ipAddress = '192.168.1.125:5001';
  //One instance, needs factory
  static Dependencies? _instance;
  factory Dependencies() => _instance ??= Dependencies._();
  Dependencies._() {
    webAccess = WebAccess(ipAddress);
    webRequestor = WebRequestor(webAccess);
  }

  late WebAccess webAccess;
  late IWebRequestor webRequestor;
}
