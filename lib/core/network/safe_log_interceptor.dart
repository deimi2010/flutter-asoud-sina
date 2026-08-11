import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

final class SafeLogInterceptor extends Interceptor {
  const SafeLogInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('HTTP ${options.method} ${options.uri}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        'HTTP ${response.statusCode} ${response.requestOptions.method} '
        '${response.requestOptions.uri}',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        'HTTP ERROR ${err.response?.statusCode ?? '-'} '
        '${err.requestOptions.method} ${err.requestOptions.uri} '
        '(${err.type.name})',
      );
    }
    handler.next(err);
  }
}
