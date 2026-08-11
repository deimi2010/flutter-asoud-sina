import 'package:asood/features/create_workspace/data/data_source/region_api_services.dart';
import 'package:asood/features/create_workspace/domain/repository/region_repository.dart';

class RegionRepositoryImp implements RegionRepository {
  final RegionApiServices regionApiServices;
  RegionRepositoryImp(this.regionApiServices);

  @override
  Future getCityList(String provinceId) async {
    return await regionApiServices.getCityList(provinceId);
  }

  @override
  Future getCountryList() async {
    return await regionApiServices.getCountryList();
  }

  @override
  Future getProvinceList(String countryId) async {
    return await regionApiServices.getProvinceList(countryId);
  }
}
