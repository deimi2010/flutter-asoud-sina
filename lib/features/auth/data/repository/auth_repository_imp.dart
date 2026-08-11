import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/features/auth/data/data_source/auth_api_service.dart';
import 'package:asood/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthApiService authApiService;

  AuthRepositoryImp(this.authApiService);
  @override
  //logout user
  Future<dynamic> logout() async {
    var res = await authApiService.logout();
    if (res is Success) {
      return res;
    } else {
      return res;
    }
  }

  @override
  Future sendCode(String number) async {
    return await authApiService.userAuth(number);
  }

  @override
  //verify user and if user had data save in its model
  Future<dynamic> verifyCode(String number, String code) async {
    return await authApiService.verifyUser(number, code);
  }
}
