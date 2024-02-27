class CachedValue<T> {
  final Future<T> Function() fetchDataFunction;
  Future<T>? _getDataFuture;

  CachedValue(this.fetchDataFunction);

  Future<T> _getOrCreateDataFuture() {
    _getDataFuture ??= fetchDataFunction();
    return _getDataFuture!;
  }

  Future<T> getData() async {
    try {
      return await _getOrCreateDataFuture();
    } catch (e) {
      _getDataFuture = null;
      rethrow;
    }
  }

  void clearCache() {
    _getDataFuture = null;
  }
}
