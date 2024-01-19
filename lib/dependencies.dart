import 'package:flutter_jukebox/potentiallibrary/webaccess/webrequestor.dart';
import 'package:flutter_jukebox/tools/logger.dart';
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
    var logger = Logger();
    var mp3WebAccess = WebAccess(Version().version.mp3PlayerIpAddress, logger);
    var jbdbWebAccess = WebAccess(Version().version.jbdbApiIpAddress, logger);
    var mp3WebRequestor = WebRequestor(mp3WebAccess);
    mp3PlayerAccess = MP3PlayerAccess(
        mp3WebRequestor, Version().version.currentlyPlayingTrackId);
    var jbdbWebRequestor = WebRequestor(jbdbWebAccess);
    jukeboxDatabaseApiAccess =
        JukeboxDatabaseApiAccess(jbdbWebRequestor, logger);
    serviceController =
        ServiceController(jukeboxDatabaseApiAccess, mp3PlayerAccess);
  }

  late IMP3PlayerAccess mp3PlayerAccess;
  late IJukeboxDatabaseApiAccess jukeboxDatabaseApiAccess;
  late IServiceController serviceController;
}
