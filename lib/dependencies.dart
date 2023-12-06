import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import 'package:flutter_jukebox/webaccess/servicecontroller.dart';
import 'potentiallibrary/webaccess/webaccess.dart';
import 'version.dart';
import 'webaccess/jukeboxdatabaseapiaccess.dart';
import 'webaccess/mp3playeraccess.dart';

class Dependencies {
  //One instance, needs factory
  static Dependencies? _instance;
  factory Dependencies() => _instance ??= Dependencies._();
  Dependencies._() {
    var mp3WebAccess = WebAccess(Version().version.mp3PlayerIpAddress);
    var jbdbWebAccess = WebAccess(Version().version.jbdbApiIpAddress);
    var mp3WebRequestor = WebRequestor(mp3WebAccess);
    mp3PlayerAccess = MP3PlayerAccess(
        mp3WebRequestor, Version().version.currentlyPlayingTrackId);
    var jbdbWebRequestor = WebRequestor(jbdbWebAccess);
    jukeboxDatabaseApiAccess = JukeboxDatabaseApiAccess(jbdbWebRequestor);
    serviceController =
        ServiceController(jukeboxDatabaseApiAccess, mp3PlayerAccess);
  }
  late IMP3PlayerAccess mp3PlayerAccess;
  late IJukeboxDatabaseApiAccess jukeboxDatabaseApiAccess;
  late IServiceController serviceController;
}
