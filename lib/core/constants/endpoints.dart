class Endpoints {
  Endpoints._();

  static String token = 'token';
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://asoud.ir/api/v1/',
  );
  // static String baseUrl = 'http://5.34.201.94/api/v1/';

  static const Map<String, String> simpleHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  static String loginCreate = "user/pin/create/";
  static String loginVerify = 'user/pin/verify/';
  static String jwtRefresh = 'user/jwt/refresh/';
  static String jwtLogout = 'user/jwt/logout/';
  static String logout = "logout/";

  /// user
  static String userAdvertise = "advertisements/";
  static String userContact = 'contact/';

  /// category
  static String categoryGroupList = 'category/group/list/';
  static String categoryList = 'category/list/';
  static String subCategoryList = 'category/sub/list/';

  /// market
  static String baseMarket = 'owner/market';
  static String ownerMarketList = '$baseMarket/list/';
  static String ownerCreateMarket = '$baseMarket/create/';
  static String ownerCreateMarketContect = '$baseMarket/contact/create/';
  static String ownerSlider = '$baseMarket/slider';
  static String ownerDeleteBg = '$baseMarket/background';
  static String ownerTheme = '$baseMarket/theme';
  static String ownerCommentList = '$baseMarket/comment/list';
  static String ownerBackground = '$baseMarket/background';
  static String ownerLogo = '$baseMarket/logo';
  static String ownerQueue = '$baseMarket/queue';
  static String ownerInactive = '$baseMarket/inactive';
  static String ownerLocationCreate = '$baseMarket/location/create/';
  static String ownerCreateSchedule = '$baseMarket/schedules/create/';

  /// Product
  // owner
  static String baseProduct = 'owner/product';
  static String createProduct = '$baseProduct/create/';
  static String createProductDiscount = '$baseProduct/discount/create/';
  static String ownerProductListById = '$baseProduct/list/';
  static String ownerProductThemeCreate = '$baseProduct/theme/create/';
  static String ownerProductThemeList = '$baseProduct/theme/list/';
  static String ownerProductThemeUpdate = '$baseProduct/theme/update/';
  //user
  static String productCommentById = 'user/comment/comments/product';

  /// region
  static String countryList = 'region/country/list/';

  /// this needs {{countryID}}
  static String provinceList = 'region/province/list/';

  /// this needs {{provinceID}}
  static String cityList = 'region/city/list/';

  /// inquiry
  static String inquiry = 'user/inquiries/';
}
