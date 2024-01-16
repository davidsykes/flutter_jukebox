class CachedValue<T> {
  Future<T> Function() fetchDataFunction;
  Future<T>? getDataFuture;

  CachedValue(this.fetchDataFunction);

  Future<T> getData() {
    getDataFuture ??= fetchDataFunction();
    return getDataFuture!;
  }
}
