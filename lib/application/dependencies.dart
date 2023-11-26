import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import '../potentiallibrary/webaccess/webaccess.dart';
import '../webaccess/jukeboxdatabaseapiaccess.dart';
import '../webaccess/mp3playeraccess.dart';
import 'environmentvalues.dart';

class Dependencies {
  //One instance, needs factory
  static Dependencies? _instance;
  factory Dependencies() => _instance ??= Dependencies._();
  Dependencies._() {
    String jbdbApiIpAddress = EnvironmentValues().jbdbApiIpAddress;
    String mp3PlayerIpAddress = EnvironmentValues().mp3PlayerIpAddress;

    var jbdbWebAccess = WebAccess(jbdbApiIpAddress);
    var jbdbWebRequestor = WebRequestor(jbdbWebAccess);
    jukeboxDatabaseApiAccess = JukeboxDatabaseApiAccess(jbdbWebRequestor);

    var mp3WebAccess = WebAccess(mp3PlayerIpAddress);
    var mp3WebRequestor = WebRequestor(mp3WebAccess);
    mp3PlayerAccess = MP3PlayerAccess(mp3WebRequestor);
  }
  late IMP3PlayerAccess mp3PlayerAccess;
  late IJukeboxDatabaseApiAccess jukeboxDatabaseApiAccess;
}
