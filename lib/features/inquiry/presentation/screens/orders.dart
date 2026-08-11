import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/core/widgets/custom_button.dart';

import 'package:asood/core/widgets/simple_bot_navbar.dart';
import 'package:asood/features/inquiry/presentation/widget/inquiry_top_bar_extended.dart';
import 'package:asood/features/inquiry/presentation/widget/product_service_inquiry_list_widget.dart';

import 'package:flutter/material.dart';

class OrdersListScreen extends StatelessWidget {
  const OrdersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: Dimensions.width * 0.9,
            child: Column(
              children: [
                const InquiryTopBarExtended(),
                const ProductServiceInquiryList(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150,
                      child: CustomButton(onPress: () {}, text: "سفارش جدید"),
                    ),
                    SizedBox(
                      width: 150,
                      child: CustomButton(
                        onPress: () {},
                        text: "ارسال استعلام",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const SimpleBotNavBar(),
    );
  }
}
