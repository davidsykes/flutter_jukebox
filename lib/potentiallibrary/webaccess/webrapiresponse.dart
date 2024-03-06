class WebApiResponse {
  late bool success;
  String? _error;
  WebApiResponse([String? error]) {
    if (error == null) {
      success = true;
    } else {
      success = false;
      _error = error;
    }
  }

  String get error => _error ?? '';
}
