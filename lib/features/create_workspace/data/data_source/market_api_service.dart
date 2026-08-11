import 'package:asood/features/create_workspace/data/model/market_contact.dart';
import 'package:asood/features/create_workspace/data/model/market_schedule.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import 'package:asood/core/constants/endpoints.dart';
import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/core/models/theme_model.dart';

import 'package:asood/features/vendor/data/model/market_location_model.dart';

class CreateMarketApiService {
  DioClient dioClient;
  CreateMarketApiService({required this.dioClient});

  // Create market base
  Future createMarketBase(
    String type,
    String businessId,
    String name,
    String description,
    String subCategory,
    String slogan,
    String? nationalCode,
  ) async {
    var body = {
      "type": type,
      "business_id": businessId,
      "name": name,
      "description": description,
      "sub_category": subCategory,
      "slogan": slogan,
      "national_code": nationalCode ?? "",
      "payment_gateway_type": "asoud",
    };
    try {
      Response res = await dioClient.postData(
        Endpoints.ownerCreateMarket,
        body,
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Create contact information
  Future createMarketContact(MarketContactModel marketContact) async {
    var body = {
      "market": marketContact.market,
      "first_mobile_number": marketContact.firstMobileNumber,
      "second_mobile_number": marketContact.secondMobileNumber,
      "telephone": marketContact.telephone,
      "fax": marketContact.fax,
      "email": marketContact.email,
      "website_url": marketContact.websiteUrl,

      "telegram_id": marketContact.messengerIds.telegram,
    };

    try {
      Response res = await dioClient.postData(
        Endpoints.ownerCreateMarketContect,
        body,
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Create market location
  Future createMarketLocation(MarketLocationModel marketLocation) async {
    var body = {
      "market": marketLocation.market,
      "city": marketLocation.city,
      "address": marketLocation.address,
      "zip_code": marketLocation.zipCode,
      "latitude": marketLocation.latitude,
      "longitude": marketLocation.longitude,
    };

    try {
      Response res = await dioClient.postData(
        Endpoints.ownerLocationCreate,
        body,
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Get market list
  Future getMarketList() async {
    try {
      Response res = await dioClient.getData(Endpoints.ownerMarketList);

      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Inactive market
  Future inactiveMarket(String marketId) async {
    try {
      Response res = await dioClient.getData(
        "${Endpoints.ownerInactive}/$marketId/",
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Queue market
  Future queueMarket(String marketId) async {
    try {
      Response res = await dioClient.getData(
        "${Endpoints.ownerQueue}/$marketId/",
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Upload market logo
  Future uploadMarketLogo(XFile imagesFile, marketId) async {
    List<MultipartBody> images = [MultipartBody('logo_img', imagesFile)];
    try {
      Response res = await dioClient.postMultipartData(
        "${Endpoints.ownerLogo}/$marketId/",
        {},
        images,
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Delete market logo
  Future deleteMarketLogo(String marketId) async {
    try {
      Response res = await dioClient.deleteData(
        "${Endpoints.ownerLogo}/$marketId/",
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Upload market background
  Future uploadMarketBackground(XFile imagesFile, String marketId) async {
    List<MultipartBody> images = [MultipartBody('background_img', imagesFile)];
    try {
      Response res = await dioClient.postMultipartData(
        "${Endpoints.ownerBackground}/$marketId/",
        {},
        images,
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Delete market background
  Future deleteMarketBackground(String marketId) async {
    try {
      Response res = await dioClient.deleteData(
        "${Endpoints.ownerDeleteBg}/$marketId/",
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Get market slider by id
  Future getMarketSlider(String marketId) async {
    try {
      Response res = await dioClient.getData(
        "${Endpoints.ownerSlider}/$marketId/",
      );

      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Create new slider by id
  Future createMarketSlider(String marketId, XFile imagesFile) async {
    List<MultipartBody> images = [MultipartBody('slider_img', imagesFile)];
    try {
      Response res = await dioClient.postMultipartData(
        "${Endpoints.ownerSlider}/$marketId/",
        {},
        images,
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Edit slider by id
  Future editMarketSlider(String sliderId, XFile imagesFile) async {
    List<MultipartBody> images = [MultipartBody('slider_img', imagesFile)];
    try {
      Response res = await dioClient.patchMultipartData(
        "${Endpoints.ownerSlider}/$sliderId/",
        {},
        images,
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Modify slider by slider id
  Future modifyMarketSlider(Map<String, dynamic> body, String sliderId) async {
    try {
      Response res = await dioClient.patchData(
        "${Endpoints.ownerSlider}/$sliderId/",
        body,
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Delete slider by id
  Future deleteMarketSlider(String sliderId) async {
    try {
      Response res = await dioClient.deleteData(
        "${Endpoints.ownerSlider}/$sliderId/",
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Set market theme
  Future setMarketTheme(String marketId, ThemeModel themeModel) async {
    var body = {
      "color": themeModel.color,
      "background_color": themeModel.backgroundColor,
      "secondary_color": themeModel.secondaryColor,
      "font_color": themeModel.fontColor,
      "font": themeModel.font,
      "secondary_font_color": themeModel.secondaryFontColor,
    };
    try {
      Response res = await dioClient.postData(
        "${Endpoints.ownerTheme}/$marketId/",
        body,
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // Get market comments
  Future getMarketComments(String marketId) async {
    try {
      Response res = await dioClient.getData(
        "${Endpoints.ownerCommentList}/$marketId/",
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }

  // post schedule
  Future setSchedule(MarketScheduleModel marketSchedule) async {
    try {
      Response res = await dioClient.postData(
        Endpoints.ownerCreateSchedule,
        marketSchedule.toJson(),
      );
      return apiStatus(res);
    } catch (e) {
      return customApiStatus();
    }
  }
}
