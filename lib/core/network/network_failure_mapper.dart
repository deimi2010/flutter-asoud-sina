import 'dart:io';

import 'package:asood/core/error/failure.dart';
import 'package:dio/dio.dart';

final class NetworkFailureMapper {
  const NetworkFailureMapper();

  AppFailure fromException(Object error) {
    if (error is! DioException) {
      return UnexpectedFailure(
        message: 'Unexpected application error',
        cause: error,
      );
    }

    final statusCode = error.response?.statusCode;
    if (statusCode == HttpStatus.unauthorized ||
        statusCode == HttpStatus.forbidden) {
      return UnauthorizedFailure(
        message: 'Authentication is required',
        code: statusCode?.toString(),
        cause: error,
      );
    }

    if (statusCode != null) {
      return ServerFailure(
        message: 'The server could not complete the request',
        code: statusCode.toString(),
        statusCode: statusCode,
        cause: error,
      );
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError) {
      return NetworkFailure(
        message: 'Unable to connect to the server',
        code: error.type.name,
        cause: error,
      );
    }

    return UnexpectedFailure(
      message: 'Unexpected network error',
      code: error.type.name,
      cause: error,
    );
  }
}
