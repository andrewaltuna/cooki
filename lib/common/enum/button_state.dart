enum ButtonState {
  idle,
  loading;

  bool get isIdle => this == idle;
  bool get isLoading => this == loading;
}
