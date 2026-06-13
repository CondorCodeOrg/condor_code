sealed class DataResult<T> {
  void fold({required Function(T) onSuccess, Function(ErrorResult)? onError}) {
    switch (this) {
      case SuccessResult<T>():
        onSuccess((this as SuccessResult<T>).data as T);
        break;
      case ErrorResult<T>():
        if (onError != null) {
          onError(this as ErrorResult<T>);
        }
        break;
    }
  }
}

class SuccessResult<T> extends DataResult<T> {
  final T? data;

  SuccessResult(this.data);
}

class ErrorResult<T> extends DataResult<T> {
  final String message;

  ErrorResult({required this.message});

  @override
  String toString() => 'ErrorResult(message: $message)';
}
