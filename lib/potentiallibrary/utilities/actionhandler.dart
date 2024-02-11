abstract class ActionHandler {
  Future<bool> action();
}

class ActionReturningVoid extends ActionHandler {
  final void Function() _action;

  ActionReturningVoid(this._action);

  @override
  Future<bool> action() {
    _action();
    return Future(() => true);
  }
}
