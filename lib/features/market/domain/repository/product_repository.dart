import 'package:asood/features/market/data/model/product_model.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';

abstract class ProductRepository {
  Future<dynamic> productList(productId) async {}
  Future<dynamic> createProduct(ProductModel product) async {}
  Future<dynamic> createProductDiscount(
    productId,
    PositionEnum position,
    int percent,
    int days,
  ) async {}
  Future<dynamic> createMarketTheme(String marketId, int order) async {}
  Future<dynamic> getMarketTheme(String marketId) async {}
  Future<dynamic> updateMarketTheme({
    required String productId,
    required String themeId,
    required String themeIndex,
  }) async {}
}
