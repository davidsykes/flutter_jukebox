import 'package:flutter_jukebox/potentiallibrary/utilities/actionhandler.dart';
import 'package:flutter_jukebox/webaccess/servicecontroller.dart';

class UpdateArtistForTrackAction extends ActionHandler {
  final IServiceController _serviceController;
  final int _trackId;
  UpdateArtistForTrackAction(this._serviceController, this._trackId);

  @override
  void action(int value) {
    _serviceController.updateArtistForTrack(_trackId, value);
  }
}
