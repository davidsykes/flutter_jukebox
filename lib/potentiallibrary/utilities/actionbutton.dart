class ActionButton {
  bool value = false;
  final void Function() updateFunction;

  ActionButton(this.updateFunction);

  void toggle() {
    value = !value;
    updateFunction();
  }
}
