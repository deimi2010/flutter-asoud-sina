import 'package:asood/core/constants/endpoints.dart';
import 'package:asood/core/helper/enum_changer.dart';
import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/features/market/data/model/product_model.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ProductApiService {
  DioClient dioClient;
  ProductApiService({required this.dioClient});

  //get products
  Future getProducts(marketId) async {
    try {
      Response res = await dioClient.getData(
        "${Endpoints.ownerProductListById}$marketId/",
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  //get product by id
  Future getProductById(productId) async {
    var uri = 'owner/product/detail/$productId/';
    try {
      Response res = await dioClient.getData(uri);
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // create product

  Future createProduct(ProductModel product) async {
    print('product image is ${product.image}');
    List<MultipartBody> images = [];

    // Handle multiple images
    if (product.image != null && product.image!.isNotEmpty) {
      for (XFile image in product.image!) {
        images.add(MultipartBody('uploaded_images', image));
      }
    }
    try {
      print('sina you wanna send this product');
      print(product.toString());
      print(product.mainPrice.toString());
      Response res = await dioClient.postMultipartData(
        Endpoints.createProduct,
        product.toJson(),
        images,
      );

      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  //get product comments
  Future getProductComments(productId) async {
    try {
      Response res = await dioClient.getData(
        '${Endpoints.productCommentById}/$productId/',
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  //get product comments
  Future createProductDiscount(
    productId,
    PositionEnum position,
    int percent,
    int days,
  ) async {
    try {
      Response res = await dioClient
          .postData('${Endpoints.createProductDiscount}$productId/', {
            "users": [],
            "position": tagPositionEnumChanger(position),
            "percentage": percent,
            "duration": days,
          });
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  Future createMarketTheme(String marketId, int order) async {
    try {
      Response res = await dioClient.postData(
        "${Endpoints.ownerProductThemeCreate}$marketId/",
        {"name": "test", "order": order},
      );

      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  Future getMarketTheme(String marketId) async {
    try {
      Response res = await dioClient.getData(
        "${Endpoints.ownerProductThemeList}$marketId/",
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  Future updateMarketTheme(
    String productId,
    String themeId,
    String themeIndex,
  ) async {
    try {
      Response res = await dioClient.putData(
        "${Endpoints.ownerProductThemeUpdate}$themeId/",
        {"product": productId, "index": int.parse(themeIndex)},
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }
}
