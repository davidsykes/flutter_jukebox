import 'potentiallibrary/webaccess/webaccess.dart';

class Dependencies {
  static const String ipAddress = '192.168.1.125:5001';
  //One instance, needs factory
  static Dependencies? _instance;
  factory Dependencies() => _instance ??= Dependencies._();
  Dependencies._();

  WebAccess webAccess = WebAccess(ipAddress);
}
