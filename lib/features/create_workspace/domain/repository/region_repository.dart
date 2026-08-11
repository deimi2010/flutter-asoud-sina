abstract class RegionRepository {
  Future<dynamic> getCountryList() async {}

  Future<dynamic> getProvinceList(String countryId) async {}

  Future<dynamic> getCityList(String provinceId) async {}
}
