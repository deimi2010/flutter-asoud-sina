import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final FlutterSecureStorage storage = const FlutterSecureStorage();

  static writeSecureStorage(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static readSecureStorage(String key) async {
    String value = await storage.read(key: key) ?? 'ND';
    return value;
  }

  static deleteSecureStorage(String key) async {
    await storage.delete(key: key);
  }
}
