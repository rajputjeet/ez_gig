enum ViewStatus { initial, loading, success, error }

class ViewState<T> {
  final ViewStatus status;
  final T? data;
  final String? message;

  const ViewState._({required this.status, this.data, this.message});

  factory ViewState.initial() =>
      const ViewState._(status: ViewStatus.initial);
  factory ViewState.loading() =>
      const ViewState._(status: ViewStatus.loading);
  factory ViewState.success(T data) =>
      ViewState._(status: ViewStatus.success, data: data);
  factory ViewState.error(String msg) =>
      ViewState._(status: ViewStatus.error, message: msg);

  bool get isInitial => status == ViewStatus.initial;
  bool get isLoading => status == ViewStatus.loading;
  bool get isSuccess => status == ViewStatus.success;
  bool get isError   => status == ViewStatus.error;
}
