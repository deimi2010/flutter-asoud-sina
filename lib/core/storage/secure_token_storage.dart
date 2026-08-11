import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/storage/token_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class SecureTokenStorage implements TokenStorage {
  SecureTokenStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  static const refreshTokenKey = 'jwt_refresh';

  final FlutterSecureStorage _storage;

  @override
  Future<String?> readAccessToken() => _readToken(Keys.token);

  @override
  Future<String?> readRefreshToken() => _readToken(refreshTokenKey);

  @override
  Future<void> writeTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _storage.write(key: Keys.token, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: refreshTokenKey, value: refreshToken);
    }
  }

  @override
  Future<void> clearTokens() async {
    await _storage.delete(key: Keys.token);
    await _storage.delete(key: refreshTokenKey);
  }

  Future<String?> _readToken(String key) async {
    final value = await _storage.read(key: key);
    if (value == null || value.isEmpty || value == 'ND') {
      return null;
    }
    return value;
  }
}
