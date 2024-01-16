import 'package:flutter_jukebox/potentiallibrary/utilities/ilogger.dart';

class Logger extends ILogger {
  static List<String> logs = List.empty(growable: true);

  //One instance, needs factory
  static Logger? _instance;
  factory Logger() => _instance ??= Logger._();
  Logger._();

  @override
  void log(String log) {
    logs.add(log);
  }
}
