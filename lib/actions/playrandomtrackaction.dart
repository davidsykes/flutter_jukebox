import '../potentiallibrary/utilities/actionhandler.dart';
import '../webaccess/microservicecontroller.dart';

class PlayRandomTrackAction extends ActionHandler {
  final IMicroServiceController _serviceController;
  PlayRandomTrackAction(this._serviceController);

  @override
  Future<bool> action() {
    return _serviceController.playRandomTrack();
  }
}
