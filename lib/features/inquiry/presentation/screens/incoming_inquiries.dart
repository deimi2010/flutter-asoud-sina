import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:flutter/material.dart';

import 'package:asood/core/constants/constants.dart';

import 'package:asood/core/widgets/simple_bot_navbar.dart';
import 'package:asood/features/inquiry/presentation/widget/inquiry_top_bar_widget.dart';

class IncomingInquieresScreen extends StatelessWidget {
  const IncomingInquieresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            width: Dimensions.width * 0.9,
            child: Column(
              children: [
                const InquiryTopBar(),
                Container(child: const Column(children: [])),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const SimpleBotNavBar(),
    );
  }
}
