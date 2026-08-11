import 'package:asood/core/constants/constants.dart';
import 'package:asood/features/bank_card/screens/bank_card_sharing_screen.dart';
import 'package:flutter/material.dart';

class BankSample extends StatefulWidget {
  const BankSample({super.key});

  @override
  State<BankSample> createState() => _BankSampleState();
}

class _BankSampleState extends State<BankSample> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.width,
      padding: EdgeInsets.only(bottom: Dimensions.width * 0.015),
      margin: EdgeInsets.symmetric(
        vertical: Dimensions.height * 0.01,
        horizontal: Dimensions.width * 0.03,
      ),
      decoration: BoxDecoration(
        color: Colora.primaryColor,
        border: Border.all(color: Colora.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colora.scaffold,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: Dimensions.width,
              height: Dimensions.height * 0.06,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colora.primaryColor, width: 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: Dimensions.width * 0.1),
                  const Text(
                    'بانک ملت',
                    style: TextStyle(color: Colora.primaryColor, fontSize: 15),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    icon: const Icon(
                      Icons.swap_vert_rounded,
                      color: Colora.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            //bank
            Padding(
              padding: EdgeInsets.only(
                top: Dimensions.height * 0.015,
                right: Dimensions.width * 0.05,
              ),
              child: const Text(
                'نام شعبه : ستاری',
                style: TextStyle(color: Colora.primaryColor, fontSize: 11),
              ),
            ),

            //account
            Padding(
              padding: EdgeInsets.only(
                right: Dimensions.width * 0.05,
                left: Dimensions.width * 0.02,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'کد شعبه : 215',
                    style: TextStyle(color: Colora.primaryColor, fontSize: 11),
                  ),
                  Text(
                    '9824901424',
                    style: TextStyle(color: Colora.primaryColor, fontSize: 18),
                  ),
                ],
              ),
            ),

            //shaba
            Container(
              width: Dimensions.width,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: Dimensions.width * 0.02),
              child: const Text(
                'IR52 2522 3547 6584 9824 9014 24',
                style: TextStyle(color: Colora.primaryColor, fontSize: 11),
              ),
            ),

            //cart number
            Container(
              width: Dimensions.width,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: Dimensions.height * 0.01),
              child: const Text(
                '6104 6658 2574 3251',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colora.primaryColor,
                  fontSize: 25,
                  fontFamily: 't',
                ),
              ),
            ),

            //name
            Padding(
              padding: EdgeInsets.only(
                top: Dimensions.height * 0.01,
                right: Dimensions.width * 0.03,
                bottom: Dimensions.height * 0.01,
              ),
              child: const Text(
                'یوسف ضیغمی',
                style: TextStyle(
                  color: Colora.primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //buttons
            Container(
              color: Colora.primaryColor,
              child:
                  isExpanded
                      ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: Dimensions.width * 0.4,
                                child: CheckboxListTile(
                                  title: const Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'شماره حساب',
                                        style: TextStyle(
                                          color: Colora.scaffold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  value: false,
                                  onChanged: (newValue) {
                                    // setState(() {
                                    //   // checkedValue = newValue;
                                    // });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  side: const BorderSide(
                                    color: Colora.scaffold,
                                  ),
                                  fillColor: WidgetStateProperty.all(
                                    Colora.scaffold,
                                  ),
                                  activeColor: Colora.scaffold,
                                  checkColor: Colora.primaryColor,
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.width * 0.4,
                                child: CheckboxListTile(
                                  title: const Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'شماره شبا',
                                        style: TextStyle(
                                          color: Colora.scaffold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  value: false,
                                  onChanged: (newValue) {
                                    // bloc.add(IsMarketerEvent(isMarketer: !state.isMarketer));
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  side: const BorderSide(
                                    color: Colora.scaffold,
                                  ),
                                  activeColor: Colora.scaffold,
                                  fillColor: WidgetStateProperty.all(
                                    Colora.scaffold,
                                  ),
                                  checkColor: Colora.primaryColor,
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: Dimensions.width * 0.4,
                                child: CheckboxListTile(
                                  title: const Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'شماره کارت',
                                        style: TextStyle(
                                          color: Colora.scaffold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  value: false,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  side: const BorderSide(
                                    color: Colora.scaffold,
                                  ),
                                  fillColor: WidgetStateProperty.all(
                                    Colora.scaffold,
                                  ),
                                  activeColor: Colora.scaffold,
                                  checkColor: Colora.primaryColor,
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  onChanged: (bool? value) {},
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.width * 0.4,
                                child: CheckboxListTile(
                                  title: const Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'نام صاحب حساب',
                                        style: TextStyle(
                                          color: Colora.scaffold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  value: false,
                                  onChanged: (newValue) {
                                    // bloc.add(IsMarketerEvent(isMarketer: !state.isMarketer));
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  side: const BorderSide(
                                    color: Colora.scaffold,
                                  ),
                                  activeColor: Colora.scaffold,
                                  fillColor: WidgetStateProperty.all(
                                    Colora.scaffold,
                                  ),
                                  checkColor: Colora.primaryColor,
                                  contentPadding: EdgeInsets.zero,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width * 0.03,
                            ),
                            child: TextField(
                              maxLines: 3,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                filled: true,
                                fillColor: Colora.scaffold,
                                hintText: 'یادداشت',
                                hintStyle: TextStyle(
                                  color: Colora.primaryColor.withOpacity(0.5),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: Dimensions.width * 0.4,
                                height: Dimensions.height * 0.05,
                                margin: EdgeInsets.only(
                                  top: Dimensions.height * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  color: Colora.scaffold,
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'کپی',
                                    style: TextStyle(
                                      color: Colora.primaryColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: Dimensions.width * 0.4,
                                height: Dimensions.height * 0.05,
                                margin: EdgeInsets.only(
                                  top: Dimensions.height * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  color: Colora.scaffold,
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                const BankCardSharingScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'اشتراک گذاری',
                                    style: TextStyle(
                                      color: Colora.primaryColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                      : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
