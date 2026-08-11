import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/router/app_routers.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MessageCardWidget extends StatelessWidget {
  const MessageCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colora.lightBlue,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'پنل آسود',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '۱۴۰۲/۰۱/۰۱',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 2,
                  color: Colora.primaryColor,
                  width: Dimensions.width * 0.55,
                  margin: EdgeInsets.symmetric(
                    vertical: Dimensions.height * 0.01,
                  ),
                ),
                // Divider(
                //   thickness: 1,
                //   color: Colora.primaryColor,
                // ),
                const Text(
                  'موضوع : استعلام بها',
                  style: TextStyle(color: Colora.scaffold, fontSize: 14),
                ),
                const SizedBox(height: 10),
                const Text(
                  'وضعیت: در حال بررسی',
                  style: TextStyle(color: Colora.scaffold, fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                InkWell(
                  child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colora.primaryColor,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: const Center(
                      child: Text(
                        'ویرایش',
                        style: TextStyle(
                          color: Colora.scaffold,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    context.push(AppRoutes.panelConfig);
                  },
                  child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colora.primaryColor,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: const Center(
                      child: Text(
                        'ارسال',
                        style: TextStyle(
                          color: Colora.scaffold,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                // CustomButton(
                //   onPress: () {},
                //   text: 'ارسال',
                //   color: Colora.primaryColor,
                //   width: 100,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
