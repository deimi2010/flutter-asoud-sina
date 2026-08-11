sealed class AppFailure {
  const AppFailure({required this.message, this.code, this.cause});

  final String message;
  final String? code;
  final Object? cause;
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure({required super.message, super.code, super.cause});
}

final class ServerFailure extends AppFailure {
  const ServerFailure({
    required super.message,
    super.code,
    this.statusCode,
    super.cause,
  });

  final int? statusCode;
}

final class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure({required super.message, super.code, super.cause});
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure({
    required super.message,
    super.code,
    this.fieldErrors = const {},
    super.cause,
  });

  final Map<String, List<String>> fieldErrors;
}

final class StorageFailure extends AppFailure {
  const StorageFailure({required super.message, super.code, super.cause});
}

final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure({required super.message, super.code, super.cause});
}
