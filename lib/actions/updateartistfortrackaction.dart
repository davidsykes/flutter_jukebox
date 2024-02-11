import 'package:flutter_jukebox/webaccess/microservicecontroller.dart';

class UpdateArtistForTrackAction {
  final IMicroServiceController _serviceController;
  final int _trackId;
  UpdateArtistForTrackAction(this._serviceController, this._trackId);

  Future<bool> update(int value) {
    return _serviceController.updateArtistForTrack(_trackId, value);
  }
}
