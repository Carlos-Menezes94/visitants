class DataSourceResponse<T> {
  DataSourceResponse({
    required this.success,
    required this.data,
  });
  bool success;
  T data;
}
