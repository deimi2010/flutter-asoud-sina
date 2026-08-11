import 'package:flutter/material.dart';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/custom_button.dart';
import 'package:asood/core/widgets/custom_textfield.dart';
import 'package:asood/features/market/presentation/widgets/custom_switch.dart';
import 'package:asood/features/market/presentation/widgets/row_widget_title_widget.dart';

class ContactsInfo extends StatefulWidget {
  const ContactsInfo({super.key});

  @override
  State<ContactsInfo> createState() => _ContactsInfoState();
}

class _ContactsInfoState extends State<ContactsInfo> {
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
            CustomTextField(controller: TextEditingController(), text: "فکس"),
            const SizedBox(height: 7),
            CustomTextField(controller: TextEditingController(), text: "ایمیل"),
            const SizedBox(height: 7),
            CustomTextField(controller: TextEditingController(), text: "سایت"),
            const SizedBox(height: 7),
            CustomTextField(
              controller: TextEditingController(),
              text: "تلگرام",
            ),
            const SizedBox(height: 7),
            CustomTextField(
              controller: TextEditingController(),
              text: "اینستاگرام",
            ),
            const SizedBox(height: 7),
            const Text(
              "کد ملی صرفا جهت تخصیص آگهی به شما میباشد",
              style: TextStyle(color: Colors.white),
            ),
            CustomSwitch(
              title: "دارای ساعت کاری",
              onChanged: (p0) {
                setState(() {
                  switchValue = p0;
                });
              },
              switchValue: switchValue,
            ),
            Container(
              margin: const EdgeInsets.all(7),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  RowWidgetTitle(
                    title: "شنبه",
                    widget: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colora.primaryColor,
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 90,
                                child: CustomTextField(
                                  color: Colora.primaryColor,
                                  controller: TextEditingController(),
                                  text: 'از ساعت',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Text(
                                '-',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 90,
                                child: CustomTextField(
                                  color: Colora.primaryColor,
                                  controller: TextEditingController(),
                                  text: 'تا ساعت',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(thickness: 1),
                  RowWidgetTitle(
                    title: "یکشنبه",
                    widget: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colora.primaryColor,
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 90,
                                child: CustomTextField(
                                  color: Colora.primaryColor,
                                  controller: TextEditingController(),
                                  text: 'از ساعت',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Text(
                                '-',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 90,
                                child: CustomTextField(
                                  color: Colora.primaryColor,
                                  controller: TextEditingController(),
                                  text: 'تا ساعت',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(thickness: 1),
                  RowWidgetTitle(
                    title: "دوشنبه",
                    widget: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colora.primaryColor,
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 90,
                                child: CustomTextField(
                                  color: Colora.primaryColor,
                                  controller: TextEditingController(),
                                  text: 'از ساعت',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Text(
                                '-',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 90,
                                child: CustomTextField(
                                  color: Colora.primaryColor,
                                  controller: TextEditingController(),
                                  text: 'تا ساعت',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(thickness: 1),
                  RowWidgetTitle(
                    title: "سهشنبه",
                    widget: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colora.primaryColor,
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 90,
                                child: CustomTextField(
                                  color: Colora.primaryColor,
                                  controller: TextEditingController(),
                                  text: 'از ساعت',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Text(
                                '-',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 90,
                                child: CustomTextField(
                                  color: Colora.primaryColor,
                                  controller: TextEditingController(),
                                  text: 'تا ساعت',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(thickness: 1),
                  RowWidgetTitle(
                    title: "چهارشنبه",
                    widget: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colora.primaryColor,
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 90,
                                child: CustomTextField(
                                  color: Colora.primaryColor,
                                  controller: TextEditingController(),
                                  text: 'از ساعت',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Text(
                                '-',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 90,
                                child: CustomTextField(
                                  color: Colora.primaryColor,
                                  controller: TextEditingController(),
                                  text: 'تا ساعت',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(thickness: 1),
                  RowWidgetTitle(
                    title: "پنجشنبه",
                    widget: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colora.primaryColor,
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 90,
                                child: CustomTextField(
                                  color: Colora.primaryColor,
                                  controller: TextEditingController(),
                                  text: 'از ساعت',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Text(
                                '-',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 90,
                                child: CustomTextField(
                                  color: Colora.primaryColor,
                                  controller: TextEditingController(),
                                  text: 'تا ساعت',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(thickness: 1),
                  RowWidgetTitle(
                    title: "جمعه",
                    widget: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colora.primaryColor,
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 90,
                                child: CustomTextField(
                                  color: Colora.primaryColor,
                                  controller: TextEditingController(),
                                  text: 'از ساعت',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Text(
                                '-',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 90,
                                child: CustomTextField(
                                  color: Colora.primaryColor,
                                  controller: TextEditingController(),
                                  text: 'تا ساعت',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                      onPress: () {},
                      text: "بعدی",
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
