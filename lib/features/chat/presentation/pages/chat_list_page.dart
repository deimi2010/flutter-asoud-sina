import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'chat_page.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colora.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: Dimensions.height * 0.12),

                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder:
                        (context, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: Dimensions.width,
                            height: Dimensions.height * 0.11,
                            margin: EdgeInsets.symmetric(
                              vertical: Dimensions.height * 0.01,
                              horizontal: Dimensions.width * 0.05,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: Dimensions.height * 0.01,
                              horizontal: Dimensions.width * 0.03,
                            ),
                            decoration: BoxDecoration(
                              color: Colora.scaffold,
                              boxShadow: [
                                BoxShadow(
                                  color: CupertinoColors.inactiveGray
                                      .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                //image
                                SizedBox(
                                  width: Dimensions.width * 0.2,
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: Colora.lightBlue,
                                        ),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/logo_svg.svg',
                                        colorFilter: const ColorFilter.mode(
                                          Colora.lightBlue,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Container(
                                  width: Dimensions.width * 0.64,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width * 0.03,
                                    vertical: Dimensions.height * 0.01,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      //name and date
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //name
                                          Text(
                                            'احمد فرج پور',
                                            style: TextStyle(
                                              color: Colora.primaryColor,
                                              fontSize: 12,
                                            ),
                                          ),

                                          //date
                                          Text(
                                            '1400/5/18',
                                            style: TextStyle(
                                              color: Colora.primaryColor,
                                              fontSize: 8,
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height: Dimensions.height * 0.01,
                                      ),

                                      //title / price
                                      const Text(
                                        'عنوان :‌دریل برقی - قیمت ۲۰۰.۰۰۰ تومان',
                                        style: TextStyle(
                                          color: Colora.primaryColor,
                                          fontSize: 8,
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
                ],
              ),

              const NewAppBar(title: 'پیام ‌ها'),
            ],
          ),
        ),
      ),
    );
  }
}
