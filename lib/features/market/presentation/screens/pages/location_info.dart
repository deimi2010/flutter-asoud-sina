import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/router/app_routers.dart';
import 'package:asood/core/widgets/custom_button.dart';
import 'package:asood/core/widgets/custom_dialog.dart';
import 'package:asood/core/widgets/custom_textfield.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LocationInfo extends StatefulWidget {
  const LocationInfo({super.key});

  @override
  State<LocationInfo> createState() => _LocationInfoState();
}

class _LocationInfoState extends State<LocationInfo> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.width,
      height: Dimensions.height * .6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colora.primaryColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 7),
            CustomTextField(
              controller: TextEditingController(),
              text: "تلفن همراه",
            ),
            const SizedBox(height: 7),
            CustomTextField(
              controller: TextEditingController(),
              text: "تلفن همراه",
            ),
            const SizedBox(height: 7),
            CustomTextField(
              controller: TextEditingController(),
              text: "تلفن ثابت",
            ),
            const SizedBox(height: 7),
            CustomTextField(
              maxLine: 6,
              controller: TextEditingController(),
              text: "آدرس فروشگاه",
            ),
            const SizedBox(height: 7),
            CustomTextField(
              controller: TextEditingController(),
              text: "تلفن ثابت",
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: const Center(child: Text("map")),
            ),
            const SizedBox(height: 7),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      width: 100,
                      onPress: () {},
                      text: "قبلی",
                      color: Colors.white,
                      textColor: Colora.primaryColor,
                      height: 40,
                    ),
                    const SizedBox(width: 5),
                    CustomButton(
                      width: 100,
                      onPress: () {
                        CustomDialog(
                          context: context,
                          title: "انتخاب درگاه",
                          widget: Container(
                            height: 120,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'میخواهید از درگاه آسود استفاده کنید یا درگاه شخصی استفاده کنید؟',
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomButton(
                                      onPress: () {
                                        Navigator.of(context).pop();
                                        CustomDialog(
                                          context: context,
                                          title: "ثبت درگاه شخصی",
                                          widget: SizedBox(
                                            height: 140,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'کلید درگاه خود را وارد کنید',
                                                ),
                                                SizedBox(
                                                  height: 35,
                                                  child: CustomTextField(
                                                    controller:
                                                        TextEditingController(),
                                                    text: "کد درگاه",
                                                    hintStyle: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    color: Colora.primaryColor,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomButton(
                                                      onPress: () {},
                                                      text: "ثبت",
                                                      width: 120,
                                                      color:
                                                          Colora.primaryColor,
                                                      textColor: Colors.white,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    CustomButton(
                                                      onPress: () {},
                                                      text: "انصراف",
                                                      width: 120,
                                                      color:
                                                          Colora.primaryColor,
                                                      textColor: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      text: "درگاه شخصی",
                                      width: 90,
                                      color: Colora.primaryColor,
                                      textColor: Colors.white,
                                    ),
                                    CustomButton(
                                      onPress: () {},
                                      text: "بعدا",
                                      width: 90,
                                      color: Colora.primaryColor,
                                      textColor: Colors.white,
                                    ),
                                    CustomButton(
                                      onPress: () {
                                        CustomDialog(
                                          height: 400.0,
                                          context: context,
                                          title: "پرداخت حق اشتراک",
                                          widget: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 10,
                                            ),
                                            child: Column(
                                              children: [
                                                const Text(
                                                  "مبلغ پرداختی را وارد کنید",
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        height: 35,
                                                        width: 180,
                                                        child: CustomTextField(
                                                          color: Colora
                                                              .primaryColor
                                                              .withOpacity(0.5),
                                                          controller:
                                                              TextEditingController(),
                                                          text: "کد تخفیف",
                                                        ),
                                                      ),
                                                      CustomButton(
                                                        height: 35,
                                                        width: 100,
                                                        onPress: () {},
                                                        text: "ثبت تخفیف",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 30,
                                                      ),
                                                  margin:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 8,
                                                      ),
                                                  height: 200,
                                                  width: Dimensions.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                  ),
                                                  child: const Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("مبلغ پرداختی:"),
                                                          Text("تومان"),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("مبلغ پرداختی:"),
                                                          Text("تومان"),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("مبلغ پرداختی:"),
                                                          Text("تومان"),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("مبلغ پرداختی:"),
                                                          Text("تومان"),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("مبلغ پرداختی:"),
                                                          Text("تومان"),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomButton(
                                                      onPress: () {
                                                        context.push(
                                                          AppRoutes.storeDetail,
                                                        );
                                                        /*   Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const StoresScreen())); */
                                                      },
                                                      text: "پرداخت",
                                                      width: 120,
                                                      color:
                                                          Colora.primaryColor,
                                                      textColor: Colors.white,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    CustomButton(
                                                      onPress: () {},
                                                      text: "انصراف",
                                                      width: 120,
                                                      color:
                                                          Colora.primaryColor,
                                                      textColor: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      text: "درگاه آسود",
                                      width: 90,
                                      color: Colora.primaryColor,
                                      textColor: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      text: "ثبت",
                      color: Colors.white,
                      textColor: Colora.primaryColor,
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}
