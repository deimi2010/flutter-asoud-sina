abstract class AuthRepository {
  Future<dynamic> sendCode(String number);
  Future<dynamic> verifyCode(String number, String code);
  Future<dynamic> logout();
}
