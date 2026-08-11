import 'package:asood/features/create_workspace/data/model/market_contact.dart';
import 'package:image_picker/image_picker.dart';

import 'package:asood/core/models/theme_model.dart';
import 'package:asood/features/create_workspace/data/data_source/market_api_service.dart';
import 'package:asood/features/create_workspace/domain/repository/create_market_repository.dart';

import 'package:asood/features/vendor/data/model/market_location_model.dart';

class CreateMarketRepositoryImp implements CreateMarketRepository {
  final CreateMarketApiService marketApiService;

  CreateMarketRepositoryImp(this.marketApiService);

  @override
  Future createMarketBase(
    String type,
    String businessId,
    String name,
    String description,
    String subCategory,
    String slogan,
    String? nationalCode,
  ) async {
    return await marketApiService.createMarketBase(
      type,
      businessId,
      name,
      description,
      subCategory,
      slogan,
      nationalCode,
    );
  }

  @override
  Future createMarketContact(MarketContactModel marketContact) async {
    return await marketApiService.createMarketContact(marketContact);
  }

  @override
  Future createMarketLocation(MarketLocationModel marketLocation) async {
    return await marketApiService.createMarketLocation(marketLocation);
  }

  @override
  Future getMarketList() async {
    return await marketApiService.getMarketList();
  }

  @override
  Future inactiveMarket(marketId) async {
    return await marketApiService.inactiveMarket(marketId);
  }

  @override
  Future queueMarket(marketId) async {
    return await marketApiService.queueMarket(marketId);
  }

  @override
  Future uploadMarketLogo(XFile imagesFile, String marketId) async {
    return await marketApiService.uploadMarketLogo(imagesFile, marketId);
  }

  @override
  Future deleteMarketLogo(marketId) async {
    return await marketApiService.deleteMarketLogo(marketId);
  }

  @override
  Future uploadMarketBackground(XFile imagesFile, marketId) async {
    return await marketApiService.uploadMarketBackground(imagesFile, marketId);
  }

  @override
  Future deleteMarketBackground(marketId) async {
    return await marketApiService.deleteMarketBackground(marketId);
  }

  @override
  Future editMarketSlider(sliderId, XFile imagesFile) async {
    return await marketApiService.editMarketSlider(sliderId, imagesFile);
  }

  @override
  Future modifyMarketSlider(body, sliderId) async {
    return await marketApiService.modifyMarketSlider(body, sliderId);
  }

  @override
  Future deleteMarketSlider(sliderId) async {
    return await marketApiService.deleteMarketSlider(sliderId);
  }

  @override
  Future setMarketTheme(String marketId, ThemeModel themeModel) async {
    return await marketApiService.setMarketTheme(marketId, themeModel);
  }

  @override
  Future getMarketComments(marketId) async {
    return await marketApiService.getMarketComments(marketId);
  }

  @override
  Future getMarketSliders(marketId) async {
    return await marketApiService.getMarketSlider(marketId);
  }

  @override
  Future uploadMarketSlider(marketId, XFile imagesFile) async {
    return await marketApiService.createMarketSlider(marketId, imagesFile);
  }

  @override
  Future createSchedule(scheduleMarketModel) async {
    return await marketApiService.setSchedule(scheduleMarketModel);
  }
}
