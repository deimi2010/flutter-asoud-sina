import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/features/auth/data/datasources/auth_api_service.dart';
import 'package:asood/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:asood/features/auth/domain/repositories/auth_repository.dart';
import 'package:asood/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

void registerAuthModule(GetIt locator) {
  locator.registerFactory(
    () => AuthApiService(dioClient: locator<DioClient>()),
  );
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(locator<AuthApiService>()),
  );
  locator.registerFactory(
    () => AuthBloc(authRepository: locator<AuthRepository>()),
  );
}
