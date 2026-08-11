import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/router/app_routers.dart';
import 'package:asood/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:asood/features/business_card/presentation/bloc/business_bloc.dart';
import 'package:asood/features/create_workspace/presentation/bloc/create_workspace_bloc.dart';
import 'package:asood/features/job_managment/presentation/bloc/jobmanagment_bloc.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';
import 'package:asood/features/market/presentation/blocs/bloc/market_bloc.dart';
import 'package:asood/features/market/presentation/blocs/comment/comment_bloc.dart';
import 'package:asood/features/market/presentation/blocs/theme/theme_bloc.dart';
import 'package:asood/features/splash/blocs/splash_bloc.dart';
import 'package:asood/features/vendor/presentation/bloc/vendor/vendor_bloc.dart';
import 'package:asood/features/vendor/presentation/bloc/workspace/workspace_bloc.dart';
import 'package:asood/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:asood/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:asood/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:asood/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await locatorSetup();

  runApp(Asood());
}

class Asood extends StatelessWidget {
  const Asood({super.key});

  @override
  Widget build(BuildContext context) {
    // device rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colora.primaryColor,
        systemStatusBarContrastEnforced: true,
        systemNavigationBarColor: Colora.primaryColor,
        systemNavigationBarDividerColor: Colora.primaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => locator<SplashBloc>()),
          BlocProvider(create: (context) => locator<AuthBloc>()),
          BlocProvider(create: (context) => locator<CreateWorkSpaceBloc>()),
          BlocProvider(create: (context) => locator<JobmanagmentBloc>()),
          BlocProvider(create: (context) => locator<VendorBloc>()),
          BlocProvider(create: (context) => locator<WorkspaceBloc>()),
          BlocProvider(create: (context) => locator<AddProductBloc>()),
          BlocProvider(create: (context) => locator<ThemeBloc>()),
          BlocProvider(create: (context) => locator<CommentBloc>()),
          BlocProvider(create: (context) => locator<MarketBloc>()),
          BlocProvider(create: (context) => locator<BusinessBloc>()),
          BlocProvider(create: (context) => locator<CartBloc>()),
          BlocProvider(create: (context) => locator<WalletBloc>()),
          BlocProvider(create: (context) => locator<PaymentBloc>()),
        ],
        child: MaterialApp.router(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child as Widget,
            );
          },
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', ''), Locale('fa', '')],
          locale: const Locale('fa', ''),
          title: 'آسود',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colora.primaryColor),
            useMaterial3: true,
            fontFamily: FontFamily.irs,
          ),
        ),
      ),
    );
  }
}
