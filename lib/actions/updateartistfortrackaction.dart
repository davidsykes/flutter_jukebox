import 'package:flutter_jukebox/potentiallibrary/utilities/actionhandler.dart';
import 'package:flutter_jukebox/webaccess/microservicecontroller.dart';

class UpdateArtistForTrackAction extends ActionHandler {
  final IMicroServiceController _serviceController;
  final int _trackId;
  UpdateArtistForTrackAction(this._serviceController, this._trackId);

  @override
  Future<bool> action(int value) {
    return _serviceController.updateArtistForTrack(_trackId, value);
  }
}
