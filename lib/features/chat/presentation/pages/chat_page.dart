import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colora.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: Dimensions.width,
            height: Dimensions.height,
            child: Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    width: Dimensions.width,
                    height: Dimensions.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: Dimensions.height * 0.11),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: 6,
                            reverse: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index % 2 == 0) {
                                return Container(
                                  width: Dimensions.width * 0.55,
                                  margin: EdgeInsets.fromLTRB(
                                    Dimensions.width * 0.4,
                                    Dimensions.height * 0.01,
                                    Dimensions.width * 0.01,
                                    Dimensions.height * 0.01,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width * 0.03,
                                    vertical: Dimensions.height * 0.01,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colora.lightBlue,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(0),
                                      topRight: Radius.circular(26),
                                      bottomLeft: Radius.circular(26),
                                      topLeft: Radius.circular(26),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'دریافت شد ،‌خیلی ممنون',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colora.scaffold,
                                          fontSize: 13,
                                        ),
                                      ),

                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colora.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            26,
                                          ),
                                        ),
                                        margin: EdgeInsets.only(
                                          top: Dimensions.height * 0.01,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.width * 0.08,
                                          vertical: Dimensions.height * 0.005,
                                        ),
                                        child: const Text(
                                          '17:35 - 1400/03/20',
                                          style: TextStyle(
                                            color: Colora.scaffold,
                                            fontSize: 9,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container(
                                  margin: EdgeInsets.fromLTRB(
                                    Dimensions.width * 0.01,
                                    Dimensions.height * 0.01,
                                    Dimensions.width * 0.4,
                                    Dimensions.height * 0.01,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: Dimensions.width * 0.45,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.width * 0.03,
                                          vertical: Dimensions.height * 0.01,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: Colora.lightBlue,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(26),
                                            topRight: Radius.circular(26),
                                            bottomLeft: Radius.circular(0),
                                            topLeft: Radius.circular(26),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                bottom:
                                                    Dimensions.height * 0.01,
                                              ),
                                              child: AspectRatio(
                                                aspectRatio: 1,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.redAccent,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          26,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            const Text(
                                              'تصویر شماره ۱۰',
                                              style: TextStyle(
                                                color: Colora.scaffold,
                                                fontSize: 13,
                                              ),
                                            ),

                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colora.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(26),
                                              ),
                                              margin: EdgeInsets.only(
                                                top: Dimensions.height * 0.01,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Dimensions.width * 0.08,
                                                vertical:
                                                    Dimensions.height * 0.005,
                                              ),
                                              child: const Text(
                                                '17:35 - 1400/03/20',
                                                style: TextStyle(
                                                  color: Colora.scaffold,
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //image
                                      SizedBox(
                                        width: Dimensions.width * 0.12,
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colora.lightBlue,
                                              ),
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/images/logo_svg.svg',
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                    Colora.lightBlue,
                                                    BlendMode.srcIn,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(height: Dimensions.height * 0.1),
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  width: Dimensions.width,
                  child: Container(
                    width: Dimensions.width,
                    height: Dimensions.height * 0.07,
                    margin: EdgeInsets.symmetric(
                      horizontal: Dimensions.width * 0.01,
                      vertical: Dimensions.height * 0.01,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width * 0.01,
                      vertical: Dimensions.height * 0.005,
                    ),
                    decoration: BoxDecoration(
                      color: Colora.lightBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //send button
                        Container(
                          width: Dimensions.width * 0.23,
                          height: Dimensions.height * 0.07,
                          decoration: BoxDecoration(
                            color: Colora.primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'ارسال',
                            style: TextStyle(
                              color: Colora.scaffold,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),

                        //clip button
                        Container(
                          width: Dimensions.width * 0.15,
                          height: Dimensions.height * 0.07,
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Colora.primaryColor),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            CupertinoIcons.paperclip,
                            color: Colora.scaffold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const NewAppBar(title: 'احمد فرج پور'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
