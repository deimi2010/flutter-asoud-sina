import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/core/widgets/simple_bot_navbar.dart';
import 'package:asood/features/inquiry/presentation/screens/dashboard/inquiry_form.dart';
import 'package:asood/features/inquiry/presentation/screens/dashboard/inquiry_list.dart';
import 'package:asood/features/inquiry/presentation/screens/dashboard/inquiry_reply.dart';
import 'package:flutter/material.dart';

class InquiryDashboard extends StatefulWidget {
  const InquiryDashboard({super.key});

  @override
  State<InquiryDashboard> createState() => _InquiryDashboardState();
}

class _InquiryDashboardState extends State<InquiryDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(title: 'داشبورد استعلام'),

      // buttons part:
      body: SingleChildScrollView(
        child: Column(
          children: [
            // bank part:
            SizedBox(height: Dimensions.height * 0.02),

            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return InquiryForm();
                    },
                  ),
                );
              },
              child: Container(
                width: Dimensions.width * 0.9,
                height: Dimensions.height * 0.07,
                decoration: BoxDecoration(
                  color: Colora.borderTag,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colora.backgroundDialog, width: 2),
                ),
                child: Center(
                  child: Text(
                    'صورت استعلام',
                    style: TextStyle(
                      color: Colora.scaffold,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),

            // top part:
            SizedBox(
              width: Dimensions.width,
              height: Dimensions.height * 0.25,
              child: Padding(
                padding: EdgeInsets.all(Dimensions.width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ListInquiry();
                                },
                              ),
                            );
                          },
                          child: Container(
                            width: Dimensions.width * 0.43,
                            height: Dimensions.height * 0.07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colora.backgroundDialog,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'لیست',
                                style: TextStyle(
                                  color: Colora.backgroundDialog,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return InquiryReply();
                                },
                              ),
                            );
                          },
                          child: Container(
                            width: Dimensions.width * 0.43,
                            height: Dimensions.height * 0.07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colora.backgroundDialog,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'پاسخ',
                                style: TextStyle(
                                  color: Colora.backgroundDialog,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Dimensions.width * 0.43,
                          height: Dimensions.height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colora.backgroundDialog,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'واریز',
                              style: TextStyle(
                                color: Colora.backgroundDialog,
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: Dimensions.width * 0.43,
                          height: Dimensions.height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colora.backgroundDialog,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'برداشت',
                              style: TextStyle(
                                color: Colora.backgroundDialog,
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // down part:
            Container(
              width: Dimensions.width * 0.9,
              height: Dimensions.height * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colora.backgroundDialog, width: 2),
              ),
              child: Center(
                child: Text(
                  'اعمال فیلتر',
                  style: TextStyle(
                    color: Colora.backgroundDialog,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height * 0.02),

            Container(
              width: Dimensions.width * 0.9,
              height: Dimensions.height * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colora.backgroundDialog, width: 2),
              ),
              child: Center(
                child: Text(
                  'نظرات',
                  style: TextStyle(
                    color: Colora.backgroundDialog,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height * 0.02),

            Container(
              width: Dimensions.width * 0.9,
              height: Dimensions.height * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colora.backgroundDialog, width: 2),
              ),
              child: Center(
                child: Text(
                  'آمار',
                  style: TextStyle(
                    color: Colora.backgroundDialog,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SimpleBotNavBar(),
    );
  }
}
