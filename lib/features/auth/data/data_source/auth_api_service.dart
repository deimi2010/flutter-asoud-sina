import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/constants/endpoints.dart';
import 'package:dio/dio.dart';

import 'package:asood/core/helper/secure_storage.dart';
import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/core/http_client/api_status.dart';

class AuthApiService {
  final DioClient dioClient;
  AuthApiService({required this.dioClient});

  Future userAuth(String number) async {
    var body = {"mobile_number": number};

    try {
      Response res = await dioClient.postData(
        Endpoints.loginCreate,
        body,
        headers: Endpoints.simpleHeader,
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  Future verifyUser(String number, String code) async {
    final body = {"mobile_number": number, 'pin': code};

    try {
      final res = await dioClient.postData(
        Endpoints.loginVerify,
        body,
        headers: Endpoints.simpleHeader,
      );
      
      if (res.data['data']?['jwt']?['access'] != null) {
        final jwtAccess = res.data['data']['jwt']['access'];
        await SecureStorage.writeSecureStorage(Keys.token, jwtAccess);
        
        if (res.data['data']['jwt']?['refresh'] != null) {
          await SecureStorage.writeSecureStorage('jwt_refresh', res.data['data']['jwt']['refresh']);
        }
      } else if (res.data['data']?['token'] != null) {
        await SecureStorage.writeSecureStorage(Keys.token, res.data['data']['token']);
      }
      
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  Future getAdvertises() async {
    try {
      Response res = await dioClient.getData(Endpoints.userAdvertise);
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  Future getContacts() async {
    try {
      Response res = await dioClient.getData(Endpoints.userContact);
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  Future logout() async {
    try {
      final refreshToken = await SecureStorage.readSecureStorage('jwt_refresh');
      final accessToken = await SecureStorage.readSecureStorage(Keys.token);
      
      if ((refreshToken != null && refreshToken != "ND") || 
          (accessToken != null && accessToken != "ND")) {
        try {
          final logoutData = refreshToken != null && refreshToken != "ND" 
              ? {'refresh': refreshToken} 
              : {};
          
          final headers = accessToken != null && accessToken != "ND"
              ? {
                  ...Endpoints.simpleHeader,
                  'Authorization': 'Bearer $accessToken',
                }
              : Endpoints.simpleHeader;
          
          await dioClient.postData(
            Endpoints.jwtLogout,
            logoutData,
            headers: headers,
          );
        } catch (e) {
          if (kDebugMode) {
            debugPrint('Logout API error: $e');
          }
        }
      }
      
      await SecureStorage.deleteSecureStorage('jwt_refresh');
      await SecureStorage.writeSecureStorage(Keys.token, "ND");
      
      return Success(code: 200, response: {}, message: 'Logged out successfully');
    } catch (e) {
      return customApiStatus();
    }
  }
}
