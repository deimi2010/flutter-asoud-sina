import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/validators.dart';
import 'package:asood/core/widgets/custom_button.dart';
import 'package:asood/core/widgets/custom_textfield.dart';
import 'package:asood/core/widgets/radio_button.dart';
import 'package:asood/features/market/presentation/widgets/simple_title.dart';
import 'package:flutter/material.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({super.key});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  TextEditingController nationalCodeController = TextEditingController();
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height * .6,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: Dimensions.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: Dimensions.height * .65,
              width: Dimensions.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colora.primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SimpleTitle(title: 'انتخاب قالب'),
                  Row(
                    children: [
                      radioButton(
                        title: "فروشگاهی",
                        value: "x",
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                      ),
                      radioButton(
                        title: "شرکتی",
                        value: "y",
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  CustomTextField(
                    controller: TextEditingController(),
                    text: "شناسه کسب و کار",
                  ),
                  const SizedBox(height: 7),
                  CustomTextField(
                    controller: TextEditingController(),
                    text: "نام کسب و کار",
                  ),
                  const SizedBox(height: 7),
                  CustomTextField(
                    controller: TextEditingController(),
                    text: "توضیحات",
                    maxLine: 6,
                  ),
                  const SizedBox(height: 7),
                  CustomTextField(
                    controller: TextEditingController(),
                    text: "شعار تبلیغاتی",
                  ),
                  const SizedBox(height: 7),
                  CustomTextField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: nationalCodeController,
                    text: "کد ملی",
                    validator: Validators.iranianNationalCodeValidator,
                  ),
                  const Text(
                    "کد ملی صرفا جهت تخصیص آگهی به شما میباشد",
                    style: TextStyle(color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomButton(
                      onPress: () {},
                      text: "انتخاب شغل",
                      color: Colors.white,
                      textColor: Colora.primaryColor,
                      height: 40,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomButton(
                        onPress: () {},
                        text: "بعدی",
                        color: Colors.white,
                        textColor: Colora.primaryColor,
                        height: 40,
                        width: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
