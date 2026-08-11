import 'package:asood/core/error/failure.dart';
import 'package:asood/core/network/network_failure_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mapper = NetworkFailureMapper();

  test('maps connection errors to NetworkFailure', () {
    final error = DioException(
      requestOptions: RequestOptions(path: '/test'),
      type: DioExceptionType.connectionError,
    );

    expect(mapper.fromException(error), isA<NetworkFailure>());
  });

  test('maps unauthorized responses to UnauthorizedFailure', () {
    final request = RequestOptions(path: '/test');
    final error = DioException(
      requestOptions: request,
      response: Response<dynamic>(requestOptions: request, statusCode: 401),
      type: DioExceptionType.badResponse,
    );

    expect(mapper.fromException(error), isA<UnauthorizedFailure>());
  });

  test('maps other responses to ServerFailure with status code', () {
    final request = RequestOptions(path: '/test');
    final error = DioException(
      requestOptions: request,
      response: Response<dynamic>(requestOptions: request, statusCode: 503),
      type: DioExceptionType.badResponse,
    );

    final failure = mapper.fromException(error);

    expect(failure, isA<ServerFailure>());
    expect((failure as ServerFailure).statusCode, 503);
  });
}
