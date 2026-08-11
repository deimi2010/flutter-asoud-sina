part of './app_routers.dart';

abstract class AppRoutes {
  static const splash = "/splash";
  static const login = "/login";
  static const otp = "/otp";

  static const vendorHome = "/vendor_home";
  static const vendorDashboard = "/vendor_dashboard";
  static const vendorProfile = "/vendor_profile";
  static const customerDashboard = "/customer_dashboard";
  static const createWorkSpace = "/create_workspace";
  static const feeInquiry = "/fee_inquiry";

  static const mainInquiry = '/main_inquiry';

  static const inquiryDetails = "/inquiry_details";
  static const inquiryRequests = "/inquiry_requests";
  static const inquiryResponse = "/inquiry_response";
  static const submitFeeInquiry = "/submit_fee_inquiry";
  static const ordersLists = "/orders";
  static const storeDetail = "/store_screen";

  static const markets = "/markets";
  static const marketPreview = "/market_preview";
  static const editStoreInfo = "/edit_store_info";
  static const storeInfo = "/store_info";
  static const shoppingCart = "/shopping_cart";
  static const chatList = "/chat_list";
  static const takhfif = "/takhfif";
  static const screenLists = "/screen_lists";
  static const settings = "/settings_page";
  static const colorSettings = "/color_settings";
  static const fontColorSettings = "/font_color_settings";
  static const jobManagement = "/job_management";
  static const createProduct = "/create_product";
  static const product = "/product";
  static const panelConfig = "/panel_config";
  static const panelInbox = "/panel_inbox";
  static const createBusinessCard = "/create_business_card";
  static const businessCard = "/business_card";
  static const business = "/business";
  static const finance = "/finance";
  static const bankCardList = "/bank_card_list";
  static const bookmarks = "/bookmarks";
}
