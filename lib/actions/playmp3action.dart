import '../dataobjects/jukeboxtrackpathandsilename.dart';
import '../potentiallibrary/utilities/actionhandler.dart';
import '../webaccess/microservicecontroller.dart';

class PlayMP3Action extends ActionHandler {
  final IMicroServiceController _serviceController;
  final JukeboxTrackPathAndFileName _track;
  PlayMP3Action(this._serviceController, this._track);

  @override
  Future<bool> action(int value) {
    return _serviceController.playMp3s([_track]);
  }
}
