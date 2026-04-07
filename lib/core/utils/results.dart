sealed class Results<T> {
  const Results();
}
class Success<T> extends Results{
  final T data;
  const Success(this.data);
}
class Failure<T> extends Results{
  final String message;
  const Failure(this.message);
}