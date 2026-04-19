sealed class Result<T> {
  const Result();

  void fold({
    required void Function(T data) onSuccess,
    required void Function(String message) onFailure,
  }) {
    if (this is Success<T>) {
      onSuccess((this as Success<T>).data);
    } else {
      onFailure((this as Failure<T>).message);
    }
  }
}

final class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

final class Failure<T> extends Result<T> {
  final String message;
  const Failure(this.message);
}
