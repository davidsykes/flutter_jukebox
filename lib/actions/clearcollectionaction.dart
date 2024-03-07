import '../potentiallibrary/utilities/actionhandler.dart';
import '../webaccess/microservicecontroller.dart';

class ClearCollectionAction extends ActionHandler {
  final IMicroServiceController _serviceController;
  ClearCollectionAction(this._serviceController);

  @override
  Future<bool> action() {
    return _serviceController.clearPlaylist();
  }
}
