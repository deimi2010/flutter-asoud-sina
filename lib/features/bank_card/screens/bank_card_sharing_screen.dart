import 'package:asood/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BankCardSharingScreen extends StatefulWidget {
  const BankCardSharingScreen({super.key});

  @override
  State<BankCardSharingScreen> createState() => _BankCardSharingScreenState();
}

class _BankCardSharingScreenState extends State<BankCardSharingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Dimensions.width,
        child: Stack(
          children: [
            SizedBox(
              width: Dimensions.width,
              height: Dimensions.height,
              child: Image.asset('assets/images/ba_logo.png', fit: BoxFit.fill),
            ),

            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: Dimensions.height * 0.3),

                  Container(
                    width: Dimensions.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: Dimensions.width * 0.05,
                      vertical: Dimensions.height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: Colora.scaffold,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //share
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: Dimensions.width * 0.1,
                            margin: EdgeInsets.symmetric(
                              vertical: Dimensions.height * 0.01,
                              horizontal: Dimensions.width * 0.03,
                            ),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.share_rounded,
                                  color: Colora.scaffold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        //bank cart
                        Container(
                          width: Dimensions.width,
                          margin: EdgeInsets.symmetric(
                            vertical: Dimensions.height * 0.005,
                            horizontal: Dimensions.width * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: Colora.primaryColor,
                            border: Border.all(
                              color: Colora.primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colora.scaffold,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      width: Dimensions.width,
                                      height: Dimensions.height * 0.06,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colora.primaryColor,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'بانک ملت',
                                            style: TextStyle(
                                              color: Colora.primaryColor,
                                              fontSize: 15,
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
                                        style: TextStyle(
                                          color: Colora.primaryColor,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),

                                    //account
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: Dimensions.width * 0.05,
                                        left: Dimensions.width * 0.02,
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'کد شعبه : 215',
                                            style: TextStyle(
                                              color: Colora.primaryColor,
                                              fontSize: 11,
                                            ),
                                          ),
                                          Text(
                                            '9824901424',
                                            style: TextStyle(
                                              color: Colora.primaryColor,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //shaba
                                    Container(
                                      width: Dimensions.width,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(
                                        left: Dimensions.width * 0.02,
                                      ),
                                      child: const Text(
                                        'IR52 2522 3547 6584 9824 9014 24',
                                        style: TextStyle(
                                          color: Colora.primaryColor,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),

                                    //cart number
                                    Container(
                                      width: Dimensions.width,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                        vertical: Dimensions.height * 0.01,
                                      ),
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
                                  ],
                                ),
                              ),

                              Container(
                                width: Dimensions.width,
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width * 0.015,
                                  vertical: Dimensions.height * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  color: Colora.scaffold,
                                  border: Border.all(
                                    color: Colora.primaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text(
                                  'سلام دوست من لطفا به حساب بالا ارسال کنید',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colora.primaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: Dimensions.height * 0.3,
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.width * 0.01,
                            vertical: Dimensions.height * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: Colora.primaryColor,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: Colora.scaffold,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //text
                                  SizedBox(
                                    width: Dimensions.width * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //asood
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.03,
                                            vertical: Dimensions.height * 0.01,
                                          ),
                                          child: const Text(
                                            'آسود',
                                            style: TextStyle(
                                              color: Colora.scaffold,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        //desc
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.03,
                                          ),
                                          child: const FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              'ارائه دهنده طرح‌های ویژه کسب و کار',
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Colora.scaffold,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.03,
                                            vertical: Dimensions.height * 0.01,
                                          ),
                                          child: const Text(
                                            'این نرم افزار برای شما ساخته شده است با ارسال پیشنهادات و انتقادات در نرم‌افزار خود سهیم باشید. این نرم‌افزار دارای نماد رسانه‌های دیجیتال و ثبت ملی می‌باشد',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colora.scaffold,
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //logo
                                  Container(
                                    width: Dimensions.width * 0.2,
                                    margin: EdgeInsets.symmetric(
                                      vertical: Dimensions.height * 0.02,
                                      horizontal: Dimensions.width * 0.03,
                                    ),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colora.scaffold,
                                          shape: BoxShape.circle,
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/images/logo_svg.svg',
                                          colorFilter: const ColorFilter.mode(
                                            Colora.primaryColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: Dimensions.height * 0.04,
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'پشتیبانی',
                                      style: TextStyle(
                                        color: Color(0xFFA7A9B7),
                                        fontSize: 10,
                                      ),
                                    ),

                                    VerticalDivider(color: Color(0xFFA7A9B7)),

                                    Text(
                                      'درباره آسود',
                                      style: TextStyle(
                                        color: Color(0xFFA7A9B7),
                                        fontSize: 10,
                                      ),
                                    ),

                                    VerticalDivider(color: Color(0xFFA7A9B7)),

                                    Text(
                                      'خدمات آسود',
                                      style: TextStyle(
                                        color: Color(0xFFA7A9B7),
                                        fontSize: 10,
                                      ),
                                    ),

                                    VerticalDivider(color: Color(0xFFA7A9B7)),

                                    Text(
                                      'دریافت برنامه',
                                      style: TextStyle(
                                        color: Color(0xFFA7A9B7),
                                        fontSize: 10,
                                      ),
                                    ),

                                    VerticalDivider(color: Color(0xFFA7A9B7)),

                                    Text(
                                      'ارتباط با ما',
                                      style: TextStyle(
                                        color: Color(0xFFA7A9B7),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.height * 0.02,
                                ),
                                child: const Text(
                                  'آسودگی خیال با آسود',
                                  style: TextStyle(
                                    color: Colora.scaffold,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Text(
                          'در صورت نیاز به ارسال شما هم می‌توانید از امکانات آسود استفاده کنید',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colora.primaryColor,
                          ),
                        ),

                        Container(
                          width: Dimensions.width * 0.4,
                          height: Dimensions.height * 0.05,
                          margin: EdgeInsets.symmetric(
                            vertical: Dimensions.height * 0.01,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: const Border(
                              right: BorderSide(
                                color: Colora.primaryColor,
                                width: 5,
                              ),
                              left: BorderSide(
                                color: Colora.primaryColor,
                                width: 5,
                              ),
                              top: BorderSide(
                                color: Colora.primaryColor,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Colora.primaryColor,
                                width: 1,
                              ),
                            ),
                          ),
                          child: MaterialButton(
                            onPressed: () {},
                            child: const Text(
                              'کارت من',
                              style: TextStyle(
                                color: Colora.primaryColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
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
