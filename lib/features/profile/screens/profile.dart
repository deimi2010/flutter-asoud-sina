import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:flutter/material.dart';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/custom_button.dart';
import 'package:asood/core/widgets/custom_textfield.dart';

import 'package:asood/core/widgets/simple_bot_navbar.dart';
import 'package:asood/features/profile/widget/picture_selector.dart';

class VendorProfileScreen extends StatelessWidget {
  const VendorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colora.primaryColor,
      child: SafeArea(
        child: Scaffold(
          // appBar: DefaultAppBar(context: context, title: '',),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Dimensions.height * 0.1),
                    Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colora.primaryColor,
                      ),
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: TextEditingController(),
                            isRequired: true,
                            text: "شناسه کسب و کار : محمد رضا محمدی",
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: TextEditingController(),
                            isRequired: true,
                            text: "شماره تماس : 09123931774",
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: TextEditingController(),
                            isRequired: true,
                            text: "آدرس : تهران ، احمد آباد",
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: TextEditingController(),
                            isRequired: true,
                            text: "کد ملی : ۲۳۴۱۲۳۱۲۱۲",
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: TextEditingController(),
                            isRequired: true,
                            text: "تاریخ تولد : ",
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: TextEditingController(),
                            isRequired: true,
                            text: "شماره‌ی کارت یا شبا : ",
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 10),
                          const PictureSelector(),
                          const SizedBox(height: 10),
                          Container(
                            width: Dimensions.width,
                            margin: EdgeInsets.symmetric(
                              horizontal: Dimensions.width * 0.025,
                            ),
                            decoration: BoxDecoration(
                              color: Colora.scaffold,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width * 0.04,
                              vertical: Dimensions.height * 0.015,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'آپلود مدارک',
                                  style: TextStyle(
                                    color: Colora.primaryColor,
                                    fontSize: 13,
                                  ),
                                ),

                                SizedBox(height: Dimensions.height * 0.01),

                                const Text(
                                  'برای استفاده از درگاه پرداخت آسود لطفا عکس کارت ملی و صفحات شناسنامه خود را بارگذاری نمایید.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colora.primaryColor,
                                    fontSize: 9,
                                  ),
                                ),

                                SizedBox(height: Dimensions.height * 0.01),

                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: Dimensions.width * 0.24,
                                    padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.height * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colora.primaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
                                          color: Colora.scaffold,
                                          size: 15,
                                        ),
                                        Text(
                                          'افزودن عکس',
                                          style: TextStyle(
                                            color: Colora.scaffold,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: Dimensions.height * 0.01),

                                SizedBox(
                                  height: Dimensions.height * 0.1,
                                  child: ListView.builder(
                                    itemCount: 3,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (context, index) => Container(
                                          width: Dimensions.width * 0.2,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.01,
                                          ),
                                          child: Stack(
                                            children: [
                                              AspectRatio(
                                                aspectRatio: 1,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15,
                                                        ),
                                                    image: const DecorationImage(
                                                      image: AssetImage(
                                                        'assets/images/placeholder.jpg',
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                    3,
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                        color:
                                                            Colora.primaryColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                  child: Icon(
                                                    Icons.delete_rounded,
                                                    color: Colora.scaffold,
                                                    size:
                                                        Dimensions.width * 0.04,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   height: 200,
                          //   child: const MultiFileSelector(),
                          // ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomButton(
                                  onPress: () {},
                                  text: 'ذخیره',
                                  textColor: Colora.primaryColor,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  width: Dimensions.width * 0.3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SimpleBotNavBar(),
                  ],
                ),
              ),

              const NewAppBar(title: 'پروفایل'),
            ],
          ),
          // bottomNavigationBar: const SimpleBotNavBar(),
        ),
      ),
    );
  }
}
