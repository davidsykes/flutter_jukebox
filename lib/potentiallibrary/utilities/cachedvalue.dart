class CachedValue<T> {
  final Future<T> Function() fetchDataFunction;
  Future<T>? _getDataFuture;

  CachedValue(this.fetchDataFunction);

  Future<T> getDataFuture() {
    _getDataFuture ??= fetchDataFunction();
    return _getDataFuture!;
  }

  Future<T> getData() async {
    try {
      return await getDataFuture();
    } catch (e) {
      _getDataFuture = null;
      rethrow;
    }
  }

  void reset() {
    _getDataFuture = null;
  }
}
