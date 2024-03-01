import '../potentiallibrary/utilities/actionhandler.dart';
import '../webaccess/microservicecontroller.dart';

class UndeleteTrack extends ActionHandler {
  final IMicroServiceController _serviceController;
  final int _trackId;
  UndeleteTrack(this._serviceController, this._trackId);

  @override
  Future<bool> action() {
    return _serviceController.unDeleteTrack(_trackId);
  }
}
