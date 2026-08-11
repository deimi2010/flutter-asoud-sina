import 'package:dio/dio.dart';

import 'package:asood/core/constants/endpoints.dart';
import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/core/http_client/api_status.dart';

class RegionApiServices {
  DioClient dioClient;
  RegionApiServices({required this.dioClient});

  Future getCountryList() async {
    try {
      Response res = await dioClient.getData(Endpoints.countryList);

      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  Future getProvinceList(countryId) async {
    try {
      Response res = await dioClient.getData(
        "${Endpoints.provinceList}$countryId/",
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  Future getCityList(provinceId) async {
    try {
      Response res = await dioClient.getData(
        "${Endpoints.cityList}$provinceId/",
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }
}
