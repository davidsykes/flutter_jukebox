class WebRequesterResponse {
  late bool success;
  late String? _error;
  WebRequesterResponse([String? error]) {
    if (error == null) {
      success = true;
    } else {
      success = false;
      _error = error;
    }
  }

  String get error => _error ?? '';
}
