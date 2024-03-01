import '../dataobjects/jukeboxtrackpathandsilename.dart';
import '../potentiallibrary/utilities/actionhandler.dart';
import '../webaccess/microservicecontroller.dart';

class PlaySingleMP3Action extends ActionHandler {
  final IMicroServiceController _serviceController;
  final JukeboxTrackPathAndFileName _track;
  PlaySingleMP3Action(this._serviceController, this._track);

  @override
  Future<bool> action() {
    return _serviceController.playMp3s([_track]);
  }
}
