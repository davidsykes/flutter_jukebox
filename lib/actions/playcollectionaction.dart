import '../potentiallibrary/utilities/actionhandler.dart';
import '../webaccess/microservicecontroller.dart';

class PlayCollectionAction extends ActionHandler {
  final IMicroServiceController _serviceController;
  final int _collectionId;
  PlayCollectionAction(this._serviceController, this._collectionId);

  @override
  Future<bool> action() {
    return _serviceController.playCollection(_collectionId);
  }
}
