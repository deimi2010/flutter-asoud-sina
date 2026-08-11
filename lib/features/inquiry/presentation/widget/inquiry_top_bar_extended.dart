import 'package:flutter/material.dart';

import 'package:asood/core/constants/constants.dart';

class InquiryTopBarExtended extends StatelessWidget {
  const InquiryTopBarExtended({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colora.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Row(
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
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "دسته شغلی: ابزار و یراق",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              Text(
                "مهلت اعتبار: ۳ روز",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "وضعیت: انجام شده",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
