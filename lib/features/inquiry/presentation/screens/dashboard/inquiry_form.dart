import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:flutter/material.dart';

class InquiryForm extends StatefulWidget {
  const InquiryForm({super.key});

  @override
  State<InquiryForm> createState() => _InquiryFormState();
}

class _InquiryFormState extends State<InquiryForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(title: 'صورت استعلام'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                height: Dimensions.height * 0.15,
                width: Dimensions.width * 0.9,
                decoration: BoxDecoration(
                  color: Colora.borderTag,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Dimensions.width * 0.42,
                    width: Dimensions.width * 0.42,
                    decoration: BoxDecoration(
                      color: Colora.primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  Container(
                    height: Dimensions.width * 0.42,
                    width: Dimensions.width * 0.42,
                    decoration: BoxDecoration(
                      color: Colora.primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.width * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Dimensions.width * 0.42,
                    width: Dimensions.width * 0.42,
                    decoration: BoxDecoration(
                      color: Colora.primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  Container(
                    height: Dimensions.width * 0.42,
                    width: Dimensions.width * 0.42,
                    decoration: BoxDecoration(
                      color: Colora.primaryColor,
                      borderRadius: BorderRadius.circular(30),
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
