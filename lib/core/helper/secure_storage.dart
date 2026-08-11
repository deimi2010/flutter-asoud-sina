import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<void> writeSecureStorage(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static Future<String?> readSecureStorage(String key) async {
    return await storage.read(key: key) ?? 'ND';
  }

  static Future<void> deleteSecureStorage(String key) async {
    await storage.delete(key: key);
  }
}
