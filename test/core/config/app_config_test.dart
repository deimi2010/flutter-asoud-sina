import 'package:asood/core/config/app_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses the production API URL when no dart define is provided', () {
    final config = AppConfig.fromEnvironment();

    expect(config.apiBaseUrl, 'https://asoud.ir/api/v1/');
  });
}
