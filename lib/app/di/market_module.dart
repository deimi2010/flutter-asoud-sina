import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/features/market/data/data_source/product_api_service.dart';
import 'package:asood/features/market/data/repository/product_repository_imp.dart';
import 'package:asood/features/market/domain/repository/product_repository.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';
import 'package:asood/features/market/presentation/blocs/bloc/market_bloc.dart';
import 'package:asood/features/market/presentation/blocs/comment/comment_bloc.dart';
import 'package:asood/features/market/presentation/blocs/theme/theme_bloc.dart';
import 'package:get_it/get_it.dart';

void registerMarketModule(GetIt locator) {
  locator.registerFactory(
    () => ProductApiService(dioClient: locator<DioClient>()),
  );
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImp(locator<ProductApiService>()),
  );
  locator.registerFactory(() => AddProductBloc(locator<ProductRepository>()));
  locator.registerFactory(ThemeBloc.new);
  locator.registerFactory(CommentBloc.new);
  locator.registerFactory(
    () => MarketBloc(productRepository: locator<ProductRepository>()),
  );
}
