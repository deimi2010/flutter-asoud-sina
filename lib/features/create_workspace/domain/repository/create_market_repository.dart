import 'package:asood/features/create_workspace/data/model/market_contact.dart';
import 'package:image_picker/image_picker.dart';

import 'package:asood/core/models/theme_model.dart';

import 'package:asood/features/vendor/data/model/market_location_model.dart';

abstract class CreateMarketRepository {
  Future<dynamic> createMarketBase(
    String type,
    String businessId,
    String name,
    String description,
    String subCategory,
    String slogan,
    String? nationalCode,
  );

  Future<dynamic> createMarketContact(MarketContactModel marketContact);

  Future<dynamic> createMarketLocation(MarketLocationModel marketLocation);

  Future<dynamic> getMarketList();

  Future<dynamic> inactiveMarket(marketId);

  Future<dynamic> queueMarket(marketId);

  Future<dynamic> getMarketSliders(marketId);

  Future<dynamic> uploadMarketLogo(XFile imagesFile, String marketId);

  Future<dynamic> deleteMarketLogo(marketId);

  Future<dynamic> uploadMarketBackground(XFile imagesFile, marketId);

  Future<dynamic> deleteMarketBackground(marketId);

  Future<dynamic> uploadMarketSlider(marketId, XFile imagesFile);

  Future<dynamic> editMarketSlider(sliderId, XFile imagesFile);

  Future<dynamic> modifyMarketSlider(body, sliderId);

  Future<dynamic> deleteMarketSlider(sliderId);

  Future<dynamic> setMarketTheme(String marketId, ThemeModel themeModel);

  Future<dynamic> getMarketComments(marketId);

  Future<dynamic> createSchedule(scheduleMarketModel);
}
