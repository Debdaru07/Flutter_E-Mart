enum UiResultState {
  loading,
  completed,
  success,
  error,
}

class EmailNotifierUiModel {
  String? message;
  bool? isLoading;
  UiResultState? resultState;

  EmailNotifierUiModel({
    required this.message,
    required this.isLoading,
    required this.resultState,
  });
}
