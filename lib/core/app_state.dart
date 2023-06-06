class AppState {
  late AppStateEnum _state;

  AppState() : _state = AppStateEnum.idle;

  AppState.idle() : _state = AppStateEnum.idle;
  AppState.loading() : _state = AppStateEnum.loading;
  AppState.error() : _state = AppStateEnum.error;
  AppState.success() : _state = AppStateEnum.success;

  bool isIdle() => _state == AppStateEnum.idle;
  bool isLoading() => _state == AppStateEnum.loading;
  bool hasError() => _state == AppStateEnum.error;
  bool hasSuccess() => _state == AppStateEnum.success;

  void setIdle() => _state = AppStateEnum.idle;
  void setLoading() => _state = AppStateEnum.loading;
  void setError() => _state = AppStateEnum.error;
  void setSuccess() => _state = AppStateEnum.success;
}

enum AppStateEnum {
  idle,
  loading,
  error,
  success,
}
