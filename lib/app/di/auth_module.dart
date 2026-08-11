import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/features/auth/data/data_source/auth_api_service.dart';
import 'package:asood/features/auth/data/repository/auth_repository_imp.dart';
import 'package:asood/features/auth/domain/repository/auth_repository.dart';
import 'package:asood/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:get_it/get_it.dart';

void registerAuthModule(GetIt locator) {
  locator.registerFactory(
    () => AuthApiService(dioClient: locator<DioClient>()),
  );
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(locator<AuthApiService>()),
  );
  locator.registerFactory(
    () => AuthBloc(authRepository: locator<AuthRepository>()),
  );
}
