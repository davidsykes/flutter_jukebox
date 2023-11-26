import 'package:universal_io/io.dart';
import 'dart:io';
import '../tools/logger.dart';

class EnvironmentValues {
  late String jbdbApiIpAddress;
  late String mp3PlayerIpAddress;

  //One instance, needs factory
  static EnvironmentValues? _instance;
  factory EnvironmentValues() => _instance ??= EnvironmentValues._();
  EnvironmentValues._() {
    var testIp = '192.168.1.142';
    jbdbApiIpAddress = '$testIp:5003';
    mp3PlayerIpAddress = '$testIp:5001';

    try {
      var b = Platform.executable;
      Logger().log('an app $b');
      //env.forEach((k, v) => Logger().log("Key=$k Value=$v"));
    } on Exception catch (e) {
      Logger().log('an exception $e');
    }

    Map<String, String> env = Platform.environment;
    if (env.containsKey('JukeboxApiServerUrl')) {
      jbdbApiIpAddress = env['JukeboxApiServerUrl']!;
      Logger().log('Jb api found: $jbdbApiIpAddress');
    } else {
      jbdbApiIpAddress = '$testIp:5003';
      Logger().log('Jb api not found. Set to: $jbdbApiIpAddress');
    }
    if (env.containsKey('MP3PlayerServerUrl')) {
      mp3PlayerIpAddress = env['MP3PlayerServerUrl']!;
      Logger().log('mp3 player url found: $mp3PlayerIpAddress');
    } else {
      mp3PlayerIpAddress = '$testIp:5001';
      Logger().log('mp3 player url not found. Set to: $mp3PlayerIpAddress');
    }
  }
}
