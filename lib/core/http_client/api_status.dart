import 'dart:developer';

import 'package:dio/dio.dart';

class Success {
  int? code;
  Object? response;
  String? message;

  Success({this.code, this.response, this.message});
}

class Failure {
  int? code;
  Object? errorResponse;

  Failure({this.code, this.errorResponse});
}

// Handles API responses using Dio
apiStatus(Response response) {
  try {
    var res = response.data;

    if (res['success'] == true) {
      log("__________new data in api status___________");
      log(res.toString());
      return Success(
        code: res['code'],
        response: res['data'],
        message: res['message'],
      );
    } else {
      return Failure(
        code: res['code'],
        errorResponse: res['error']?['detail'] ?? 'خطای نامشخص!',
      );
    }
  } catch (e) {
    print("------------------");
    print(e.toString());
    return Failure(
      code: response.statusCode ?? 500,
      errorResponse: 'خطای پردازش پاسخ سرور',
    );
  }
}

// Handles API errors in case of network failure or other issues
customApiStatus() {
  return Failure(code: 301, errorResponse: 'عدم برقراری ارتباط با سرور');
}

enum CWSStatus { initial, loading, success, failure }
