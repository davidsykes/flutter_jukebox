import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
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
    var mp3WebAccess = WebAccess(mp3PlayerIpAddress);
    var mp3WebRequestor = WebRequestor(mp3WebAccess);
    mp3PlayerAccess = MP3PlayerAccess(mp3WebRequestor);
    var jbdbWebAccess = WebAccess(jbdbApiIpAddress);
    var jbdbWebRequestor = WebRequestor(jbdbWebAccess);
    jukeboxDatabaseApiAccess = JukeboxDatabaseApiAccess(jbdbWebRequestor);
  }
  late IMP3PlayerAccess mp3PlayerAccess;
  late IJukeboxDatabaseApiAccess jukeboxDatabaseApiAccess;
}
