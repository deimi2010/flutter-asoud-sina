import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:flutter/material.dart';

class WithoutMarketVisit extends StatelessWidget {
  const WithoutMarketVisit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: DefaultAppBar(title: 'کارت ویزیت ها'),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: Dimensions.width * 0.03,
        ),
        child: Center(
          child: Text(
            'کارت ویزیت برای فروشگاه های شما درست میشود، شما فروشگاهی ندارید.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colora.backgroundSwitch,
            ),
          ),
        ),
      ),
    );
  }
}
