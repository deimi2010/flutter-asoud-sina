import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/router/app_routers.dart';
import 'package:asood/features/splash/blocs/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SplashBloc>(context).add(SplashInitialEvent());

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.exist) {
          context.go(AppRoutes.vendorHome);
          // // Navigator.pushReplacementNamed(context, VendorHomeScreen.routeName);
        } else if (state.status == SplashStatus.notExist) {
          context.go(AppRoutes.login);
        }
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Assets.images.login.image(fit: BoxFit.cover),
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
