import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/core/widgets/custom_button.dart';
import 'package:asood/core/widgets/custom_textfield.dart';

import 'package:flutter/material.dart';

class TakhfifScreen extends StatelessWidget {
  const TakhfifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: SizedBox(
          height: Dimensions.height,
          width: Dimensions.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //create new off code box
                Container(
                  width: Dimensions.width,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colora.scaffold,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(
                          0,
                          3,
                        ), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                        width: Dimensions.width,
                        child: CustomTextField(
                          color: Colora.lightBlue,
                          hintStyle: const TextStyle(color: Colors.white),
                          controller: TextEditingController(),
                          text: 'عنوان تخفیف',
                        ),
                      ),
                      const SizedBox(height: 7),
                      SizedBox(
                        height: 40,
                        width: Dimensions.width,
                        child: CustomTextField(
                          color: Colora.lightBlue,
                          hintStyle: const TextStyle(color: Colors.white),
                          controller: TextEditingController(),
                          text: 'توضیحات و متن تخفیف',
                        ),
                      ),
                      const SizedBox(height: 7),
                      SizedBox(
                        height: 40,
                        width: Dimensions.width,
                        child: CustomTextField(
                          color: Colora.lightBlue,
                          hintStyle: const TextStyle(color: Colors.white),
                          controller: TextEditingController(),
                          text: 'عنوان تخفیف',
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 40,
                            width: Dimensions.width / 2.25,
                            child: CustomTextField(
                              color: Colora.lightBlue,
                              hintStyle: const TextStyle(color: Colors.white),
                              controller: TextEditingController(),
                              text: 'درصد تخفیف',
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 40,
                            width: Dimensions.width / 2.25,
                            child: CustomTextField(
                              color: Colora.lightBlue,
                              hintStyle: const TextStyle(color: Colors.white),
                              controller: TextEditingController(),
                              text: 'تعداد تخفیف',
                            ),
                          ),
                          const SizedBox(height: 7),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        width: Dimensions.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colora.lightBlue,
                        ),
                        child: Row(
                          children: [
                            CustomButton(
                              width: Dimensions.width / 2.6,
                              height: 40,
                              onPress: () {},
                              text: "ساخت کد تخفیف",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                          onPress: () {},
                          color: Colora.scaffold_,
                          text: "اشتراک گذاری",
                          width: 130,
                          height: 40,
                          textColor: Colora.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                //list of off codes
                const SizedBox(height: 10),

                Container(
                  height: 140,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colora.lightBlue,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              onPress: () {},
                              text: "تخفیف تابستانه",
                              color: Colora.scaffold,
                              textColor: Colora.primaryColor,
                              height: 30,
                              width: Dimensions.width,
                            ),
                            const Text(
                              "باخرید این محصول تخفیف بگیرید",
                              style: ATextStyle.light12,
                            ),
                            Container(
                              height: 30,
                              width: Dimensions.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colora.primaryColor,
                              ),
                              child: const Center(
                                child: Text(
                                  "کد تخفیف : SJ5k3",
                                  style: ATextStyle.light12,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colora.primaryColor,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "کد تخفیف",
                                      style: ATextStyle.light12,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colora.primaryColor,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "کد تخفیف",
                                      style: ATextStyle.light12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Expanded(flex: 1, child: SizedBox(height: 7)),
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(onPress: () {}, text: "اشتراک آسود"),
                            CustomButton(onPress: () {}, text: "اشتراک گذاری"),
                            CustomButton(onPress: () {}, text: "حذف کدتخفیف"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  height: 140,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colora.lightBlue,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              onPress: () {},
                              text: "تخفیف تابستانه",
                              color: Colora.scaffold,
                              textColor: Colora.primaryColor,
                              height: 30,
                              width: Dimensions.width,
                            ),
                            const Text(
                              "باخرید این محصول تخفیف بگیرید",
                              style: ATextStyle.light12,
                            ),
                            Container(
                              height: 30,
                              width: Dimensions.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colora.primaryColor,
                              ),
                              child: const Center(
                                child: Text(
                                  "کد تخفیف : SJ5k3",
                                  style: ATextStyle.light12,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colora.primaryColor,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "کد تخفیف",
                                      style: ATextStyle.light12,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colora.primaryColor,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "کد تخفیف",
                                      style: ATextStyle.light12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Expanded(flex: 1, child: SizedBox(height: 7)),
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(onPress: () {}, text: "اشتراک آسود"),
                            CustomButton(onPress: () {}, text: "اشتراک گذاری"),
                            CustomButton(onPress: () {}, text: "حذف کدتخفیف"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  height: 140,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colora.lightBlue,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              onPress: () {},
                              text: "تخفیف تابستانه",
                              color: Colora.scaffold,
                              textColor: Colora.primaryColor,
                              height: 30,
                              width: Dimensions.width,
                            ),
                            const Text(
                              "باخرید این محصول تخفیف بگیرید",
                              style: ATextStyle.light12,
                            ),
                            Container(
                              height: 30,
                              width: Dimensions.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colora.primaryColor,
                              ),
                              child: const Center(
                                child: Text(
                                  "کد تخفیف : SJ5k3",
                                  style: ATextStyle.light12,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colora.primaryColor,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "کد تخفیف",
                                      style: ATextStyle.light12,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colora.primaryColor,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "کد تخفیف",
                                      style: ATextStyle.light12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Expanded(flex: 1, child: SizedBox(height: 7)),
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(onPress: () {}, text: "اشتراک آسود"),
                            CustomButton(onPress: () {}, text: "اشتراک گذاری"),
                            CustomButton(onPress: () {}, text: "حذف کدتخفیف"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  height: 140,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colora.lightBlue,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              onPress: () {},
                              text: "تخفیف تابستانه",
                              color: Colora.scaffold,
                              textColor: Colora.primaryColor,
                              height: 30,
                              width: Dimensions.width,
                            ),
                            const Text(
                              "باخرید این محصول تخفیف بگیرید",
                              style: ATextStyle.light12,
                            ),
                            Container(
                              height: 30,
                              width: Dimensions.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colora.primaryColor,
                              ),
                              child: const Center(
                                child: Text(
                                  "کد تخفیف : SJ5k3",
                                  style: ATextStyle.light12,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colora.primaryColor,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "کد تخفیف",
                                      style: ATextStyle.light12,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colora.primaryColor,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "کد تخفیف",
                                      style: ATextStyle.light12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Expanded(flex: 1, child: SizedBox(height: 7)),
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(onPress: () {}, text: "اشتراک آسود"),
                            CustomButton(onPress: () {}, text: "اشتراک گذاری"),
                            CustomButton(onPress: () {}, text: "حذف کدتخفیف"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
