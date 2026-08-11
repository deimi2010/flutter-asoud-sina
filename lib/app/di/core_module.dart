import 'package:asood/core/config/app_config.dart';
import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/core/network/network_failure_mapper.dart';
import 'package:asood/core/storage/secure_token_storage.dart';
import 'package:asood/core/storage/token_storage.dart';
import 'package:get_it/get_it.dart';

void registerCoreModule(GetIt locator) {
  locator.registerLazySingleton<AppConfig>(AppConfig.fromEnvironment);
  locator.registerLazySingleton<TokenStorage>(SecureTokenStorage.new);
  locator.registerLazySingleton<NetworkFailureMapper>(NetworkFailureMapper.new);
  locator.registerLazySingleton<DioClient>(
    () => DioClient(
      appBaseUrl: locator<AppConfig>().apiBaseUrl,
      tokenStorage: locator<TokenStorage>(),
    ),
  );
}
