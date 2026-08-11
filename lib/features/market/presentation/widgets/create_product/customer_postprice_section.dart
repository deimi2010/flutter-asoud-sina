import 'package:asood/core/constants/constants.dart';

import 'package:flutter/material.dart';

// این ویجت در صورتی نمایش داده میشود که حالت customer در شیوه ارسال فعال باشد
class CustomerPostpriceSection extends StatelessWidget {
  CustomerPostpriceSection({super.key});
  final TextEditingController tagSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Dimensions.height * 0.01),
        Container(
          width: Dimensions.width,
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width * 0.02),
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width * 0.03,
            vertical: Dimensions.height * 0.01,
          ),
          decoration: BoxDecoration(
            color: Colora.lightBlue,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              //title
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Colora.scaffold,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  height: Dimensions.height * 0.04,
                  margin: EdgeInsets.symmetric(
                    vertical: Dimensions.height * 0.001,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width * 0.04,
                  ),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'ثبت هزینه ارسال : ',
                    style: TextStyle(
                      color: Colora.primaryColor,
                      fontSize: Dimensions.width * 0.035,
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Dimensions.width * 0.1,
                    child: Checkbox(
                      value: false,
                      onChanged: (newValue) {
                        // setState(() {
                        //   // checkedValue = newValue;
                        // });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: const BorderSide(color: Colora.scaffold),
                      fillColor: WidgetStateProperty.all(Colora.scaffold),
                      activeColor: Colora.scaffold,
                      checkColor: Colora.primaryColor,
                      // contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Text(
                    'ارسال با پست',
                    style: TextStyle(
                      color: Colora.scaffold,
                      fontSize: Dimensions.width * 0.035,
                    ),
                  ),
                  Container(
                    width: Dimensions.width * 0.35,
                    height: Dimensions.height * 0.06,
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.height * 0.01,
                    ),
                    child: TextField(
                      controller: tagSearch,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colora.scaffold,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colora.scaffold,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colora.scaffold,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'ریال',
                    style: TextStyle(
                      color: Colora.scaffold,
                      fontSize: Dimensions.width * 0.035,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Dimensions.width * 0.1,
                    child: Checkbox(
                      // title: Padding(
                      //   padding: const EdgeInsets.only(top: 5.0),
                      //   child: FittedBox(
                      //     fit: BoxFit.scaleDown,
                      //     child: Text(
                      //       'نمایش در نیازمندی',
                      //       style: TextStyle(
                      //           color: Colora.scaffold,
                      //           fontSize: Dimensions.width * 0.035
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      value: false,
                      onChanged: (newValue) {
                        // setState(() {
                        //   // checkedValue = newValue;
                        // });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: const BorderSide(color: Colora.scaffold),
                      fillColor: WidgetStateProperty.all(Colora.scaffold),
                      activeColor: Colora.scaffold,
                      checkColor: Colora.primaryColor,
                      // contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Text(
                    'ارسال با پیک',
                    style: TextStyle(
                      color: Colora.scaffold,
                      fontSize: Dimensions.width * 0.035,
                    ),
                  ),
                  Container(
                    width: Dimensions.width * 0.35,
                    height: Dimensions.height * 0.06,
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.height * 0.01,
                    ),
                    child: TextField(
                      controller: tagSearch,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colora.scaffold,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colora.scaffold,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colora.scaffold,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'ریال',
                    style: TextStyle(
                      color: Colora.scaffold,
                      fontSize: Dimensions.width * 0.035,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Dimensions.width * 0.1,
                    child: Checkbox(
                      value: false,
                      onChanged: (newValue) {
                        // setState(() {
                        //   // checkedValue = newValue;
                        // });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: const BorderSide(color: Colora.scaffold),
                      fillColor: WidgetStateProperty.all(Colora.scaffold),
                      activeColor: Colora.scaffold,
                      checkColor: Colora.primaryColor,
                      // contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Text(
                    'ارسال با باربری',
                    style: TextStyle(
                      color: Colora.scaffold,
                      fontSize: Dimensions.width * 0.035,
                    ),
                  ),
                  Container(
                    width: Dimensions.width * 0.35,
                    height: Dimensions.height * 0.06,
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.height * 0.01,
                    ),
                    child: TextField(
                      controller: tagSearch,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colora.scaffold,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colora.scaffold,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colora.scaffold,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'ریال',
                    style: TextStyle(
                      color: Colora.scaffold,
                      fontSize: Dimensions.width * 0.035,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Dimensions.width * 0.1,
                    child: Checkbox(
                      value: false,
                      onChanged: (newValue) {
                        // setState(() {
                        //   // checkedValue = newValue;
                        // });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: const BorderSide(color: Colora.scaffold),
                      fillColor: WidgetStateProperty.all(Colora.scaffold),
                      activeColor: Colora.scaffold,
                      checkColor: Colora.primaryColor,
                      // contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Text(
                    'ارسال با وانت بار',
                    style: TextStyle(
                      color: Colora.scaffold,
                      fontSize: Dimensions.width * 0.035,
                    ),
                  ),
                  Container(
                    width: Dimensions.width * 0.35,
                    height: Dimensions.height * 0.06,
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.height * 0.01,
                    ),
                    child: TextField(
                      controller: tagSearch,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colora.scaffold,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colora.scaffold,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Colora.scaffold,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'ریال',
                    style: TextStyle(
                      color: Colora.scaffold,
                      fontSize: Dimensions.width * 0.035,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
