import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/features/create_workspace/data/datasources/market_api_service.dart';
import 'package:asood/features/create_workspace/data/datasources/region_api_services.dart';
import 'package:asood/features/create_workspace/data/repositories/create_market_repository_imp.dart';
import 'package:asood/features/create_workspace/data/repositories/region_repository_imp.dart';
import 'package:asood/features/create_workspace/data/repositories/shared_preferences_workspace_draft_repository.dart';
import 'package:asood/features/create_workspace/domain/repositories/create_market_repository.dart';
import 'package:asood/features/create_workspace/domain/repositories/region_repository.dart';
import 'package:asood/features/create_workspace/domain/repositories/workspace_draft_repository.dart';
import 'package:asood/features/create_workspace/presentation/bloc/create_workspace_bloc.dart';
import 'package:asood/features/job_managment/data/data_source/category_api_service.dart';
import 'package:asood/features/job_managment/data/repository/category_repository_imp.dart';
import 'package:asood/features/job_managment/domain/repository/category_repository.dart';
import 'package:asood/features/job_managment/presentation/bloc/jobmanagment_bloc.dart';
import 'package:asood/features/vendor/presentation/bloc/vendor/vendor_bloc.dart';
import 'package:asood/features/vendor/presentation/bloc/workspace/workspace_bloc.dart';
import 'package:get_it/get_it.dart';

void registerWorkspaceModule(GetIt locator) {
  locator.registerFactory(
    () => CategoryApiService(dioClient: locator<DioClient>()),
  );
  locator.registerFactory(
    () => CreateMarketApiService(dioClient: locator<DioClient>()),
  );
  locator.registerFactory(
    () => RegionApiServices(dioClient: locator<DioClient>()),
  );

  locator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImp(locator<CategoryApiService>()),
  );
  locator.registerLazySingleton<CreateMarketRepository>(
    () => CreateMarketRepositoryImp(locator<CreateMarketApiService>()),
  );
  locator.registerLazySingleton<RegionRepository>(
    () => RegionRepositoryImp(locator<RegionApiServices>()),
  );
  locator.registerLazySingleton<WorkspaceDraftRepository>(
    SharedPreferencesWorkspaceDraftRepository.new,
  );

  locator.registerFactory(
    () => CreateWorkSpaceBloc(
      locator<CreateMarketRepository>(),
      locator<RegionRepository>(),
      locator<WorkspaceDraftRepository>(),
    ),
  );
  locator.registerFactory(
    () => JobmanagmentBloc(locator<CategoryRepository>()),
  );
  locator.registerFactory(() => VendorBloc(locator<CreateMarketRepository>()));
  locator.registerFactory(
    () => WorkspaceBloc(locator<CreateMarketRepository>()),
  );
}
