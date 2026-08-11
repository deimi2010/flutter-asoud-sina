abstract class CartRepository {
  Future<dynamic> sendCode(String number);
  Future<dynamic> verifyCode(String number, String code);
}
