import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import 'package:flutter_jukebox/webaccess/servicecontroller.dart';
import 'potentiallibrary/webaccess/webaccess.dart';
import 'webaccess/jukeboxdatabaseapiaccess.dart';
import 'webaccess/mp3playeraccess.dart';

class Dependencies {
  static const String mp3PlayerIpAddress = '192.168.1.125:5001';
  static const String jbdbApiIpAddress = '192.168.1.125:5003';
  //One instance, needs factory
  static Dependencies? _instance;
  factory Dependencies() => _instance ??= Dependencies._();
  Dependencies._() {
    var testing = false;
    testing = true;
    var mp3WebAccess = WebAccess(mp3PlayerIpAddress);
    var jbdbWebAccess = WebAccess(jbdbApiIpAddress);
    if (testing) {
      var testIp = '192.168.1.142';
      mp3WebAccess = WebAccess('$testIp:5001');
      jbdbWebAccess = WebAccess('$testIp:5003');
    }
    var mp3WebRequestor = WebRequestor(mp3WebAccess);
    mp3PlayerAccess = MP3PlayerAccess(mp3WebRequestor);
    var jbdbWebRequestor = WebRequestor(jbdbWebAccess);
    jukeboxDatabaseApiAccess = JukeboxDatabaseApiAccess(jbdbWebRequestor);
    serviceController =
        ServiceController(jukeboxDatabaseApiAccess, mp3PlayerAccess);
  }
  late IMP3PlayerAccess mp3PlayerAccess;
  late IJukeboxDatabaseApiAccess jukeboxDatabaseApiAccess;
  late IServiceController serviceController;
}
