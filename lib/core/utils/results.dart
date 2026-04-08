sealed class Results<T> {
  const Results();
}

class Success<T> extends Results<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Results<T> {
  final String message;
  const Failure(this.message);
}
