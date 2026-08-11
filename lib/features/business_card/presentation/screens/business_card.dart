import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/models/location_model.dart';
import 'package:asood/core/widgets/map_widget_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessCard extends StatefulWidget {
  final Map<String, dynamic> data;
  const BusinessCard({super.key, required this.data});

  @override
  State<BusinessCard> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  // void getBusinessCardFromLocal() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   List<String>? visitCard = sharedPreferences.getStringList('visit_card');
  //   setState(() {
  //     if (visitCard != null && visitCard != []) {
  //       data.addAll({
  //         'type': visitCard[0],
  //         'name': visitCard[1],
  //         'description': visitCard[2],
  //         'slogan': visitCard[3],
  //         'phone': visitCard[4],
  //         'mobile': visitCard[5],
  //         'email': visitCard[6],
  //         'website': visitCard[7],
  //         'telegram': visitCard[8],
  //         'instagram': visitCard[9],
  //         'country': visitCard[10],
  //         'city': visitCard[11],
  //         'province': visitCard[12],
  //         'adderess': visitCard[13],
  //         'post': visitCard[14],
  //         // 'type': 'shop or corporation',
  //         // 'name': 'shop',
  //         // 'description': 'this is a business and how are you?',
  //         // 'slogan': 'think different',
  //         // 'phone': '03152236051',
  //         // 'mobile': '09030525351',
  //         // 'email': 'sinahashemi8338@gmail.com',
  //         // 'website': 'sina.com',
  //         // 'telegram': 'shop',
  //         // 'instagram': 'shop',
  //         // 'country': 'Iran',
  //         // 'city': 'Esfahaan',
  //         // 'province': 'zarinshahr',
  //         // 'adderess': 'zarinshahr khiaban saadi',
  //         // 'post': '823894792',
  //       });
  //     }
  //   });

  //   print(data.toString());
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          widget.data.isEmpty
              // ? SizedBox(child: CreateBusinessCard(isEdit: true))
              ? Container()
              : SizedBox(
                width: Dimensions.width,
                child: Stack(
                  children: [
                    SizedBox(
                      width: Dimensions.width,
                      height: Dimensions.height,
                      child: Image.asset(
                        'assets/images/ba_logo.png',
                        fit: BoxFit.fill,
                      ),
                    ),

                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: Dimensions.height * 0.3),

                          Container(
                            width: Dimensions.width,
                            // height: Dimensions.height,
                            margin: EdgeInsets.symmetric(
                              horizontal: Dimensions.width * 0.05,
                            ),
                            decoration: BoxDecoration(
                              color: Colora.scaffold,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: Dimensions.width * 0.6,
                                  constraints: BoxConstraints(
                                    minHeight: Dimensions.height,
                                  ),

                                  decoration: BoxDecoration(
                                    color: Colora.primaryColor,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),

                                SizedBox(
                                  height: Dimensions.height,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                                            child: InkWell(
                                              onTap: () {
                                                launchUrl(
                                                  Uri.parse(
                                                    'https://asoud.ir/${widget.data["data"]["business_id"]}',
                                                  ),
                                                );
                                              },
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
                                      ),

                                      //logo
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: Dimensions.width * 0.2,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.24,
                                          ),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colora.lightBlue,
                                                  width: 3,
                                                ),
                                              ),
                                              child: SvgPicture.asset(
                                                'assets/images/logo_svg.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                      Colora.primaryColor,
                                                      BlendMode.srcIn,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      //name
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          width: Dimensions.width * 0.5,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.05,
                                            vertical: Dimensions.height * 0.01,
                                          ),
                                          child: Text(
                                            widget.data['data']['name'] ?? '',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colora.scaffold,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),

                                      //slogan
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          width: Dimensions.width * 0.5,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.05,
                                          ),
                                          child: Text(
                                            widget.data['data']['slogan'] ?? '',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colora.scaffold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),

                                      //services
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          width: Dimensions.width * 0.5,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.05,
                                            vertical: Dimensions.height * 0.02,
                                          ),
                                          child: Text(
                                            widget.data['data']['description'] ??
                                                '',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colora.scaffold,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),

                                      //contact
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          width: Dimensions.width * 0.5,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.05,
                                            vertical: Dimensions.height * 0.01,
                                          ),
                                          child: const Text(
                                            'راه‌های ارتباطی :',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colora.scaffold,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),

                                      //phone
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: Dimensions.width * 0.29,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.01,
                                          ),
                                          child: Text(
                                            widget.data['data']['contact']['first_mobile_number'] ??
                                                'sina',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colora.primaryColor,
                                              fontSize:
                                                  Dimensions.width * 0.042,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),

                                      //phone
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: Dimensions.width * 0.29,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.01,
                                          ),
                                          child: Text(
                                            widget.data['data']['contact']['second_mobile_number'] ??
                                                'sina',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colora.primaryColor,
                                              fontSize:
                                                  Dimensions.width * 0.042,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: Dimensions.width * 0.29,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.01,
                                          ),
                                          child: Text(
                                            widget.data['data']['contact']['telephone'] ??
                                                'sina',
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colora.primaryColor,
                                              fontSize:
                                                  Dimensions.width * 0.042,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),

                                      //social
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: Dimensions.width * 0.29,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.01,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (widget.data['telegram'] !=
                                                          '' ||
                                                      widget.data['telegram'] !=
                                                          ' ') {
                                                    SharePlus.instance.share(
                                                      ShareParams(
                                                        uri: Uri.parse(
                                                          'https://t.me/${widget.data['telegram']}',
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.telegram,
                                                  color: Colora.primaryColor,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (widget.data['instagram'] !=
                                                          '' ||
                                                      widget.data['instagram'] !=
                                                          ' ') {
                                                    SharePlus.instance.share(
                                                      ShareParams(
                                                        uri: Uri.parse(
                                                          'https://instagram.com/${widget.data['instagram']}',
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Icon(
                                                  Iconsax.instagram,
                                                  color: Colora.primaryColor,
                                                ),
                                              ),
                                              Icon(
                                                Iconsax.message,
                                                color: Colora.primaryColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      //map
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: Dimensions.width * 0.8,
                                          height: Dimensions.height * 0.2,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.01,
                                            vertical: Dimensions.height * 0.01,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                            border: Border.all(
                                              color: Colora.lightBlue,
                                              width: 3,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                            child: const MapScreen(
                                              isSelecting: false,
                                              initialLocation: LocationModel(
                                                lat: 35.6783,
                                                lon: 51.4161,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      //address
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: Dimensions.width * 0.9,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.05,
                                          ),
                                          child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'آدرس : ',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colora.scaffold,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width * 0.4,
                                                child: Text(
                                                  widget.data['data']['location'] ??
                                                      'آدرسی ثبت نشده است',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colora.scaffold,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: Dimensions.width * 0.22,
                                                margin: EdgeInsets.only(
                                                  right:
                                                      Dimensions.width * 0.01,
                                                ),
                                                child: AspectRatio(
                                                  aspectRatio: 1,
                                                  // child: Container(
                                                  //   decoration:
                                                  //       const BoxDecoration(
                                                  //         color: Colors.red,
                                                  //       ),
                                                  // ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      //desc
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: Dimensions.width * 0.9,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: Dimensions.width * 0.05,
                                            vertical: Dimensions.height * 0.02,
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              // Stroked text as border.
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'در صورت نیاز به ویرایش از طریق دکمه مدیریت کارت ویزیت اقدام نمایید',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    foreground:
                                                        Paint()
                                                          ..style =
                                                              PaintingStyle
                                                                  .stroke
                                                          ..strokeWidth = 1
                                                          ..color =
                                                              Colora
                                                                  .primaryColor,
                                                  ),
                                                ),
                                              ),

                                              // Solid text as fill.
                                              const FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'در صورت نیاز به ویرایش از طریق دکمه مدیریت کارت ویزیت اقدام نمایید',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colora.scaffold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      //edit button
                                      // Align(
                                      //   alignment: Alignment.center,
                                      //   child: Container(
                                      //     width: Dimensions.width * 0.5,
                                      //     margin: EdgeInsets.symmetric(
                                      //       horizontal: Dimensions.width * 0.05,
                                      //       vertical: Dimensions.height * 0.01,
                                      //     ),
                                      //     padding: EdgeInsets.symmetric(
                                      //       horizontal: Dimensions.width * 0.05,
                                      //       vertical: Dimensions.height * 0.005,
                                      //     ),
                                      //     decoration: BoxDecoration(
                                      //       color: Colora.scaffold,
                                      //       border: Border.all(
                                      //         color: Colora.primaryColor,
                                      //         width: 2,
                                      //       ),
                                      //       borderRadius: BorderRadius.circular(
                                      //         18,
                                      //       ),
                                      //     ),
                                      //     child: InkWell(
                                      //       onTap: () {
                                      //         Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //             builder: (context) {
                                      //               return CreateBusinessCard(
                                      //                 isEdit: true,
                                      //               );
                                      //             },
                                      //           ),
                                      //         );
                                      //       },
                                      //       child: const FittedBox(
                                      //         fit: BoxFit.scaleDown,
                                      //         child: Text(
                                      //           'مدیریت کارت ویزیت',
                                      //           style: TextStyle(
                                      //             fontSize: 18,
                                      //             fontWeight: FontWeight.bold,
                                      //             color: Colora.primaryColor,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            height: Dimensions.height * 0.3,
                            margin: EdgeInsets.symmetric(
                              horizontal: Dimensions.width * 0.05,
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
                                              horizontal:
                                                  Dimensions.width * 0.03,
                                              vertical:
                                                  Dimensions.height * 0.01,
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
                                              horizontal:
                                                  Dimensions.width * 0.03,
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
                                              horizontal:
                                                  Dimensions.width * 0.03,
                                              vertical:
                                                  Dimensions.height * 0.01,
                                            ),
                                            child: const Text(
                                              'این نرم افزار برای شما ساخته شده استبا ارسال پیشنهادات و انتقادات در نرم‌افزار خود سهیم باشید. این نرم‌افزار دارای نماد رسانه‌های دیجیتال و ثبت ملی می‌باشد',
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
