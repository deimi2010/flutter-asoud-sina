import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import 'package:asood/core/constants/endpoints.dart';
import 'package:asood/core/network/auth_interceptor.dart';
import 'package:asood/core/network/safe_log_interceptor.dart';
import 'package:asood/core/network/token_refresh_interceptor.dart';
import 'package:asood/core/storage/secure_token_storage.dart';
import 'package:asood/core/storage/token_storage.dart';

import 'error_response.dart';

class DioClient {
  final String appBaseUrl;
  static const int timeoutInSeconds = 30;
  final Dio dio;

  DioClient({required this.appBaseUrl, Dio? dio, TokenStorage? tokenStorage})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: appBaseUrl,
              connectTimeout: Duration(seconds: timeoutInSeconds),
              receiveTimeout: Duration(seconds: timeoutInSeconds),
              headers: {'Content-Type': 'application/json; charset=utf-8'},
            ),
          ) {
    final resolvedTokenStorage = tokenStorage ?? SecureTokenStorage();
    this.dio.interceptors.addAll([
      AuthInterceptor(tokenStorage: resolvedTokenStorage),
      TokenRefreshInterceptor(
        client: this.dio,
        tokenStorage: resolvedTokenStorage,
        baseUrl: appBaseUrl,
        refreshPath: Endpoints.jwtRefresh,
      ),
      const SafeLogInterceptor(),
    ]);
  }

  // Perform a GET request
  Future<Response> getData(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse(response, uri);
    } on DioException catch (e) {
      return _handleDioException(e, uri);
    }
  }

  // Perform a POST request
  Future<Response> postData(
    String uri,
    dynamic data, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await dio.post(
        uri,
        data: data,
        options: Options(headers: headers),
      );
      return _handleResponse(response, uri);
    } on DioException catch (e) {
      return _handleDioException(e, uri);
    }
  }

  // Perform a POST request with multipart data (e.g., file upload)
  Future<Response> postMultipartData(
    String uri,
    Map<String, dynamic> data,
    List<MultipartBody> multipartBody, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      FormData formData = FormData();
      // Add text fields
      data.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });
      // Add files
      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          String fileName = multipart.file!.name;
          formData.files.add(
            MapEntry(
              multipart.key,
              await MultipartFile.fromFile(
                multipart.file!.path,
                filename: fileName,
              ),
            ),
          );
        }
      }
      Response response = await dio.post(
        uri,
        data: formData,
        options: Options(headers: headers),
      );
      return _handleResponse(response, uri);
    } on DioException catch (e) {
      return _handleDioException(e, uri);
    }
  }

  // Perform a PATCH request with multipart data (e.g., file update)
  Future<Response> patchMultipartData(
    String uri,
    Map<String, String> data,
    List<MultipartBody> multipartBody, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      FormData formData = FormData();
      // Add text fields
      data.forEach((key, value) {
        formData.fields.add(MapEntry(key, value));
      });
      // Add files
      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          String fileName = multipart.file!.name;
          formData.files.add(
            MapEntry(
              multipart.key,
              await MultipartFile.fromFile(
                multipart.file!.path,
                filename: fileName,
              ),
            ),
          );
        }
      }
      Response response = await dio.patch(
        uri,
        data: formData,
        options: Options(headers: headers),
      );
      return _handleResponse(response, uri);
    } on DioException catch (e) {
      return _handleDioException(e, uri);
    }
  }

  // Perform a PUT request
  Future<Response> putData(
    String uri,
    dynamic data, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await dio.put(
        uri,
        data: data,
        options: Options(headers: headers),
      );
      return _handleResponse(response, uri);
    } on DioException catch (e) {
      return _handleDioException(e, uri);
    }
  }

  // Perform a PATCH request
  Future<Response> patchData(
    String uri,
    dynamic data, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await dio.patch(
        uri,
        data: data,
        options: Options(headers: headers),
      );
      return _handleResponse(response, uri);
    } on DioException catch (e) {
      return _handleDioException(e, uri);
    }
  }

  // Perform a DELETE request
  Future<Response> deleteData(
    String uri, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await dio.delete(
        uri,
        options: Options(headers: headers),
      );
      return _handleResponse(response, uri);
    } on DioException catch (e) {
      return _handleDioException(e, uri);
    }
  }

  // Handle API responses (success or failure)
  Response _handleResponse(Response response, String uri) {
    final statusCode = response.statusCode;
    if (statusCode != null && statusCode >= 200 && statusCode < 300) {
      return response;
    } else {
      // Convert HTTP error code to readable message
      String errorMessage = handleHttpError(statusCode ?? 500);
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: errorMessage,
      );
    }
  }

  // Handle Dio errors (network or server-related issues)
  Never _handleDioException(DioException error, String uri) {
    // Provide an appropriate error message
    String errorMessage =
        error.response != null
            ? handleHttpError(error.response!.statusCode ?? 500)
            : 'Unable to connect to the server';
    throw DioException(
      requestOptions: error.requestOptions,
      error: errorMessage,
      response: error.response,
    );
  }
}

// Model for handling multipart file uploads
class MultipartBody {
  final String key;
  final XFile? file;
  MultipartBody(this.key, this.file);
}
