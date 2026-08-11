import 'package:flutter/material.dart';

import 'package:asood/core/constants/constants.dart';

class InquiryTopBar extends StatelessWidget {
  const InquiryTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colora.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "شماره استعلام: ۱۲۳۴۵۶۷۸۹۰",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          Text(
            "تاریخ: ۱۴۰۳/۰۱/۰۱",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
