class LocalStorageData<T> {
  T? data;

  bool get isEmpty {
    return data != null;
  }

  LocalStorageData({this.data});
}
