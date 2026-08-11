import 'package:asood/core/models/market_model.dart';
import 'package:asood/features/auth/presentation/screen/login_screen.dart';
import 'package:asood/features/auth/presentation/screen/otp_screen.dart';
import 'package:asood/features/bank_card/screens/bank_card_list.dart';
import 'package:asood/features/bank_card/screens/finance_part.dart';
import 'package:asood/features/bookmarks/bookmarks_page.dart';
import 'package:asood/features/business_card/presentation/screens/business_part.dart';
import 'package:asood/features/cart/presentation/screen/shopping_cart.dart';
import 'package:asood/features/chat/screens/chat_list.dart';
import 'package:asood/features/create_workspace/presentation/screen/create_workspace.dart';
import 'package:asood/features/customer/presentation/screens/customer_dashboard_screen.dart';
import 'package:asood/features/inquiry/presentation/screens/inquiry_requests.dart';
import 'package:asood/features/inquiry/presentation/screens/main_inquiry.dart';
import 'package:asood/features/job_managment/presentation/bloc/jobmanagment_bloc.dart';
import 'package:asood/features/job_managment/presentation/screen/job_managment.dart';
import 'package:asood/features/market/presentation/screens/market_preview_screen.dart';
import 'package:asood/features/market/presentation/screens/market_screen.dart';
import 'package:asood/features/market/presentation/screens/pages/product/create_product.dart';
// import 'package:asood/features/market/presentation/screens/pages/product/product_detail.dart';
import 'package:asood/features/market/presentation/screens/store_detail_screen.dart';
import 'package:asood/features/market/presentation/screens/store_info.dart';
import 'package:asood/features/panel/screens/panel_config_screen.dart';
import 'package:asood/features/panel/screens/panel_inbox_screen.dart';
import 'package:asood/features/product/screens/product_screen.dart';
import 'package:asood/features/splash/screens/splash.dart';
import 'package:asood/features/store_setting_screens/color_setting_screen/color_setting_screen.dart';
import 'package:asood/features/store_setting_screens/font-txtColor_setting_screen/font_color_setting_screen.dart';
import 'package:asood/features/store_setting_screens/takhfif_setting_screen/takhfif_screen.dart';
import 'package:asood/features/vendor/presentation/screen/vendor_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part './app_routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: AppRoutes.vendorHome,
        builder: (context, state) {
          // final title = state.extra as String;
          return VendorHomeScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.createWorkSpace,
        builder: (context, state) => CreateWorkSpaceScreen(),
      ),
      GoRoute(
        path: AppRoutes.jobManagement,
        builder: (context, state) {
          context.read<JobmanagmentBloc>().add(ResetJobManagmentBloc());
          context.read<JobmanagmentBloc>().add(LoadCategory());
          return JobManagementScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.storeDetail,
        builder: (context, state) {
          final market = state.extra as MarketModel;
          return StoreDetailScreen(market: market);
        },
      ),
      GoRoute(
        path: AppRoutes.marketPreview,
        builder: (context, state) {
          final market = state.extra as MarketModel;
          return MarketPreviewScreen(market: market);
        },
      ),
      GoRoute(
        path: AppRoutes.chatList,
        builder: (context, state) => ChatList(),
      ),
      GoRoute(
        path: AppRoutes.storeInfo,
        builder: (context, state) => StoreInfoScreen(),
      ),
      GoRoute(
        path: AppRoutes.inquiryRequests,
        builder: (context, state) => InquiryRequestsScreen(),
      ),
      GoRoute(
        path: AppRoutes.shoppingCart,
        builder: (context, state) => const ShoppingCartPage(),
      ),
      GoRoute(
        path: AppRoutes.mainInquiry,
        builder: (context, state) => const MainInquiry(),
      ),
      GoRoute(
        path: AppRoutes.createProduct,
        builder: (context, state) {
          print("---------------");
          print(state.extra);
          print(state.extra.runtimeType);
          List extra = state.extra as List;
          final marketId = extra[0];
          final themeId = extra[1];
          final themeIndex = extra[2];
          return CreateProduct(
            marketId: marketId,
            themeId: themeId,
            themeIndex: themeIndex,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.product,
        builder: (context, state) {
          List extra = state.extra as List;

          return ProductScreen(productDetails: extra[0]);
        },
      ),
      GoRoute(
        path: AppRoutes.markets,
        builder: (context, state) => MarketsScreen(),
      ),
      // GoRoute(
      //   path: AppRoutes.createBusinessCard,
      //   builder: (context, state) => CreateBusinessCard(isEdit: false),
      // ),
      GoRoute(
        path: AppRoutes.business,
        builder: (context, state) => BusinessPart(),
      ),
      GoRoute(path: AppRoutes.finance, builder: (context, state) => Finance()),
      GoRoute(
        path: AppRoutes.bankCardList,
        builder: (context, state) => BankCardListScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerDashboard,
        builder: (context, state) => CustomerDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.vendorDashboard,
        builder: (context, state) => VendorHomeScreen(),
      ),

      GoRoute(
        path: AppRoutes.panelConfig,
        builder: (context, state) => PanelConfigScreen(),
      ),
      GoRoute(
        path: AppRoutes.panelInbox,
        builder: (context, state) => PanelInboxScreen(),
      ),

      GoRoute(
        path: AppRoutes.takhfif,
        builder: (context, state) => TakhfifScreen(),
      ),
      GoRoute(
        path: AppRoutes.fontColorSettings,
        builder: (context, state) => FontColorSettingScreen(),
      ),
      GoRoute(
        path: AppRoutes.colorSettings,
        builder: (context, state) => ColorSettingScreen(),
      ),
      GoRoute(
        path: AppRoutes.bookmarks,
        builder: (context, state) => MyBookmarks(),
      ),
    ],
  );
}
