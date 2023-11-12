import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import 'potentiallibrary/webaccess/mp3playeraccess.dart';
import 'potentiallibrary/webaccess/webaccess.dart';
import 'tests/webaccess/jukeboxdatabaseapiaccess.dart';

class Dependencies {
  static const String mp3PlayerIpAddress = '192.168.1.125:5001';
  //One instance, needs factory
  static Dependencies? _instance;
  factory Dependencies() => _instance ??= Dependencies._();
  Dependencies._() {
    var mp3WebAccess = WebAccess(mp3PlayerIpAddress);
    var mp3WebRequestor = WebRequestor(mp3WebAccess);
    mp3PlayerAccess = MP3PlayerAccess(mp3WebRequestor);
    jukeboxDatabaseApiAccess = JukeboxDatabaseApiAccess();
  }
  late IMP3PlayerAccess mp3PlayerAccess;
  late IJukeboxDatabaseApiAccess jukeboxDatabaseApiAccess;
}
