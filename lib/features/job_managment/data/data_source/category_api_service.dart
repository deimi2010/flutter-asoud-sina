import 'package:asood/core/constants/endpoints.dart';
import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:dio/dio.dart';

class CategoryApiService {
  DioClient dioClient;
  CategoryApiService({required this.dioClient});

  Future getCategoryList() async {
    try {
      Response res = await dioClient.getData(Endpoints.categoryGroupList);
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  Future getMainSubCategoryList(String categoryId) async {
    try {
      Response res = await dioClient.getData(
        "${Endpoints.categoryList}$categoryId/",
      );

      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  Future getSubCategoryList(String mainSubCategoryId) async {
    try {
      Response res = await dioClient.getData(
        "${Endpoints.subCategoryList}$mainSubCategoryId/",
      );

      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }
}
