import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/secure_storage.dart';

import 'error_response.dart';

class DioClient {
  final String appBaseUrl;
  final int timeoutInSeconds = 30;
  late Dio dio;

  DioClient({required this.appBaseUrl}) {
    // Initialize Dio with base options
    dio = Dio(
      BaseOptions(
        baseUrl: appBaseUrl,
        connectTimeout: Duration(seconds: timeoutInSeconds),
        receiveTimeout: Duration(seconds: timeoutInSeconds),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorage.readSecureStorage(Keys.token);
          if (token != null && token != "ND") {
            options.headers['Authorization'] = 'Bearer $token';
          }
          if (kDebugMode) {
            debugPrint('API Request: ${options.method} ${options.path}');
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            try {
              final refreshToken = await SecureStorage.readSecureStorage('jwt_refresh');
              if (refreshToken != null && refreshToken != "ND") {
                try {
                  final refreshDio = Dio(BaseOptions(
                    baseUrl: appBaseUrl,
                    headers: {'Content-Type': 'application/json; charset=utf-8'},
                  ));
                  
                  final refreshResponse = await refreshDio.post(
                    'user/jwt/refresh/',
                    data: {'refresh': refreshToken},
                  );
                  
                  if (refreshResponse.statusCode == 200 && 
                      refreshResponse.data['success'] == true) {
                    final jwt = refreshResponse.data['data'];
                    final newAccessToken = jwt['access'];
                    final newRefreshToken = jwt['refresh'];
                    
                    await SecureStorage.writeSecureStorage(Keys.token, newAccessToken);
                    await SecureStorage.writeSecureStorage('jwt_refresh', newRefreshToken);
                    
                    error.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
                    final opts = Options(
                      method: error.requestOptions.method,
                      headers: error.requestOptions.headers,
                    );
                    final cloneReq = await dio.request(
                      error.requestOptions.path,
                      options: opts,
                      data: error.requestOptions.data,
                      queryParameters: error.requestOptions.queryParameters,
                    );
                    return handler.resolve(cloneReq);
                  }
                } catch (refreshError) {
                  if (kDebugMode) {
                    debugPrint('Token refresh failed: $refreshError');
                  }
                  await SecureStorage.writeSecureStorage(Keys.token, "ND");
                  await SecureStorage.deleteSecureStorage('jwt_refresh');
                }
              }
            } catch (e) {
              if (kDebugMode) {
                debugPrint('Error in token refresh handler: $e');
              }
            }
          }
          return handler.next(error);
        },
      ),
    );
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );
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
      if (kDebugMode) {
        debugPrint('====> API Body: $data');
      }
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
      if (kDebugMode) {
        debugPrint(
          '====> API Multipart POST: $uri with data: $data and ${multipartBody.length} file(s)',
        );
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
      if (kDebugMode) {
        debugPrint(
          '====> API Multipart PATCH: $uri with data: $data and ${multipartBody.length} file(s)',
        );
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
    if (kDebugMode) {
      debugPrint(
        '====> API Response: [${response.statusCode}] $uri\n${response.data}',
      );
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      // Convert HTTP error code to readable message
      String errorMessage = handleHttpError(response.statusCode!);
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: errorMessage,
      );
    }
  }

  // Handle Dio errors (network or server-related issues)
  Response _handleDioException(DioException error, String uri) {
    if (kDebugMode) {
      debugPrint('====> Error on $uri: ${error.message}');
    }
    // Provide an appropriate error message
    String errorMessage =
        error.response != null
            ? handleHttpError(error.response!.statusCode!)
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
