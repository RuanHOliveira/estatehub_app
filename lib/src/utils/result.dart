import 'package:estatehub_app/src/utils/app_exception.dart';

sealed class Result<T> {
  const Result();

  factory Result.success(T value) = Success._;
  factory Result.error(AppException error) = Error._;
}

final class Success<T> extends Result<T> {
  const Success._(this.value);
  final T value;
}

final class Error<T> extends Result<T> {
  const Error._(this.error);
  final AppException error;
}
