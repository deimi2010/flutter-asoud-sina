import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/core/widgets/custom_button.dart';
import 'package:asood/core/widgets/custom_textfield.dart';

import 'package:asood/core/widgets/simple_bot_navbar.dart';

import 'package:flutter/material.dart';

class FeeInquiryScreen extends StatefulWidget {
  const FeeInquiryScreen({super.key});

  @override
  State<FeeInquiryScreen> createState() => _FeeInquiryScreenState();
}

class _FeeInquiryScreenState extends State<FeeInquiryScreen> {
  String dropdownValue = 'انتخاب دسته‌بندی';

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
                Container(
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
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colora.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: Dimensions.width * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            20,
                          ), // Same border radius as parent container
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor:
                                Colors
                                    .white, // Background color of the dropdown menu
                          ),
                          child: DropdownButton<String>(
                            // Dropdown button content
                            value: dropdownValue,
                            onChanged: (String? newValue) {
                              // Dropdown value change handler
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items:
                                <String>[
                                  'انتخاب دسته‌بندی',
                                  'Option 2',
                                  'Option 3',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                      // color: Colors.deepPurple, // Background color
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                            color: Colors.black, // Text color
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            margin: const EdgeInsets.all(10.0),
                            child: CustomTextField(
                              controller: TextEditingController(),
                              text: 'مدت اعتبار:',
                            ),
                          ),
                          Container(
                            width: 100,
                            margin: const EdgeInsets.all(10.0),
                            child: CustomTextField(
                              controller: TextEditingController(),
                              text: 'شهر:',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: Dimensions.width * 0.4,
                    height: 50,
                    child: CustomButton(onPress: () {}, text: "ثبت سفارش"),
                  ),
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
