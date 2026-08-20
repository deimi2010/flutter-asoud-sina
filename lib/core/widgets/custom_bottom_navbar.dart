import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/secure_storage.dart';
import 'package:asood/core/helper/theme_color.dart';
import 'package:asood/core/models/market_model.dart';
import 'package:asood/core/router/app_routers.dart';
import 'package:asood/core/widgets/colorpicker.dart';
import 'package:asood/features/market/presentation/blocs/bloc/market_bloc.dart';
import 'package:asood/features/market/presentation/widgets/gateway_connection_dialog.dart';
import 'package:asood/features/vendor/presentation/bloc/vendor/vendor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../constants/endpoints.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final String? marketId;
  final MarketModel? market;
  final bool? userMode;
  final Color? initTopColor;
  final Color? initBackColor;
  final Color? initSecondColor;

  final String? initFont;
  final Color? initFontColor;
  final Color? initFontSecondColor;

  const CustomBottomNavigationBar({
    super.key,
    this.marketId,
    this.market,
    this.userMode = true,
    this.initBackColor,
    this.initTopColor,
    this.initSecondColor,

    this.initFont,
    this.initFontColor,
    this.initFontSecondColor,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late VendorBloc bloc;
  late MarketBloc marketBloc;

  String productId = '';

  @override
  void initState() {
    if (widget.marketId!.startsWith('ProductID=')) {
      productId = widget.marketId!.substring(10);
    }
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of<VendorBloc>(context);
    marketBloc = BlocProvider.of<MarketBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          context,
          bloc,
          marketBloc,

          widget.marketId,
          widget.market,

          widget.initTopColor,
          widget.initBackColor,
          widget.initSecondColor,

          widget.initFont,
          widget.initFontColor,
          widget.initFontSecondColor,
          widget.userMode,
          productId,
        );
      },
      child: Container(
        height: Dimensions.height * 0.05,
        width: Dimensions.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: bloc.state.topColor,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 11),
            width: 25,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              color: Colora.scaffold,
            ),
          ),
        ),
      ),
    );
  }
}

// class HalfCirclePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colora.primaryColor
//       ..style = PaintingStyle.fill;
//
//     // double radius = size.height;
//
//     canvas.drawCircle(Offset(size.width / 2, 6 * size.height), 500, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

void showBottomSheet(
  BuildContext context,
  bloc,
  marketBloc,
  marketId,
  MarketModel? market,
  initTopColor,
  initBackColor,
  initSecondColor,
  initFont,
  initFontColor,
  initFontSecondColor,
  userMode,
  productId,
) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: Dimensions.width,
        height:
            userMode == false
                ? Dimensions.height * 0.21
                : Dimensions.height * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(27),
            topLeft: Radius.circular(27),
          ),
          color: bloc.state.topColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //calendar
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Iconsax.calendar5,
                    // Icons.calendar_today_rounded,
                    color: Colors.white,
                  ),
                ),

                //messenger
                IconButton(
                  onPressed: () {
                    context.push(AppRoutes.chatList);
                  },
                  icon: const Icon(
                    Iconsax.message5,
                    // Icons.messenger_outline,
                    color: Colors.white,
                  ),
                ),

                //shopping cart
                IconButton(
                  onPressed: () {
                    if (productId != '') {
                      sendProductToShoppingCart(productId);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          'محصول با موفقیت به سبد خرید شما اضافه شد',
                        ),
                      ),
                    );
                    context.push(AppRoutes.shoppingCart);
                  },
                  icon: const Icon(
                    Iconsax.shopping_cart5,
                    // Icons.shopping_cart_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            if (userMode == false)
              SizedBox(width: Dimensions.width * .85, child: const Divider()),

            if (userMode == false)
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Takhfif Route
                  IconButton(
                    onPressed: () {
                      final selectedMarket = market;
                      if (selectedMarket == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('اطلاعات فروشگاه در دسترس نیست'),
                          ),
                        );
                        return;
                      }
                      context.push(AppRoutes.takhfif, extra: selectedMarket);
                      /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TakhfifScreen(),
                        ),
                      ); */
                    },
                    tooltip: 'ساخت کد تخفیف',
                    icon: const Icon(Icons.settings, color: Colors.white),
                  ),

                  //credit card
                  IconButton(
                    onPressed: () async {
                      await showGatewayConnectionDialog(
                        context,
                        marketId: marketId?.toString() ?? '',
                      );
                      if (context.mounted) Navigator.pop(context);
                    },
                    tooltip: 'اتصال به درگاه',
                    icon: const Icon(Icons.credit_card, color: Colors.white),
                  ),

                  //font
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      changeFont(
                        context,
                        bloc,
                        marketId,
                        initFont,
                        initTopColor,
                        initBackColor,
                        initSecondColor,
                        initFontColor,
                        initFontSecondColor,
                      );

                      // context.router.push(const FontColorSettingRoute());
                      /*    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const FontColorSettingScreen(),
                        ),
                      ); */
                    },
                    icon: const Icon(Icons.font_download, color: Colors.white),
                  ),

                  //color
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      changeColor(
                        context,
                        bloc,
                        marketId,
                        initFont,
                        initTopColor,
                        initBackColor,
                        initSecondColor,
                        initFontColor,
                        initFontSecondColor,
                      );
                      // Navigator.pop(context);
                      // context.router.push(const ColorSettingRoute());
                      /*   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ColorSettingScreen(),
                      ),
                    ); */
                    },
                    icon: const Icon(
                      Icons.color_lens_outlined,
                      color: Colors.white,
                    ),
                  ),

                  //view
                  IconButton(
                    onPressed: () {
                      marketBloc.add(const ShowTemplatesEvent(isShow: true));
                      Navigator.pop(context);
                      // context.router.push(const MultiViewSliderRoute());
                      /*   Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MultiViewSliderScreen(),
                        ),
                      ); */
                    },
                    icon: const Icon(
                      Icons.window_outlined,
                      color: Colors.white,
                    ),
                  ),

                  // edit store info
                  IconButton(
                    onPressed: () {
                      if (market == null) return;
                      final router = GoRouter.of(context);
                      Navigator.pop(context);
                      router.push(AppRoutes.editStoreInfo, extra: market);
                      /*      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditStoreInfoScreen(),
                        ),
                      ); */
                    },
                    tooltip:
                        '\u0648\u06cc\u0631\u0627\u06cc\u0634 \u0627\u0637\u0644\u0627\u0639\u0627\u062a \u0641\u0631\u0648\u0634\u06af\u0627\u0647',
                    icon: const Icon(Icons.edit_square, color: Colors.white),
                  ),
                ],
              ),
            SizedBox(
              height:
                  userMode == false
                      ? Dimensions.height * 0.07
                      : Dimensions.height * 0.05,
            ),
          ],
        ),
      );
    },
  );
}

void sendProductToShoppingCart(String id) async {
  String url = '${Endpoints.baseUrl}user/order/add_item';
  String? token = await SecureStorage.readSecureStorage(Keys.token);

  var response = await http.post(
    Uri.parse(url),
    body: {"product_id": id, "quantity": "1"},
    headers: {'Authorization': 'Bearer $token'},
  );

  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // List<String>? loadedList = sharedPreferences.getStringList('shopping_cart');

  // if (loadedList == null) {
  //   sharedPreferences.setStringList("shopping_cart", []);
  // }

  // if (!loadedList!.contains(id)) {
  //   loadedList.add(id);
  //   sharedPreferences.setStringList("shopping_cart", loadedList);
  //   log('Sina This product is added to your shopping cart');
  // } else {
  //   log(
  //     'Sina this product is already in your shopping cart and i will print them:',
  //   );
  //   log(loadedList.toString());
  // }
  // // sharedPreferences.setStringList('favs', globalFavs);
}

void changeFont(
  BuildContext context,
  bloc,
  marketId,
  initFont,
  Color initTopColor,
  Color initBackColor,
  Color initSecondColor,
  Color initFontColor,
  Color initFontSecondColor,
) {
  Map fontList = {
    'irs': {'name': 'ایران سنس', 'font': 'irs'},
    'yekan': {'name': 'یکان', 'font': 'yekan'},
    'traffic': {'name': 'ترافیک', 'font': 'traffic'},
    'dastnevis': {'name': 'دست نویس', 'font': 'dastnevis'},
    'mitra': {'name': 'میترا', 'font': 'mitra'},
    'nazanin': {'name': 'نازنین', 'font': 'nazanin'},
  };

  int index = 0;

  int currentFontIndex = fontList.keys.toList().indexOf(initFont);

  Alignment pipAlignment = Alignment.bottomCenter;

  String initSelectedFont = initFont;
  Color initSelectedFontColor = initFontColor;
  Color initSelectedFontSecondColor = initFontSecondColor;

  showDialog(
    barrierColor: const Color(0x00000000),
    barrierDismissible: false,
    context: context,
    builder:
        (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              backgroundColor: Colors.transparent,
              alignment: pipAlignment,
              content: Container(
                height: Dimensions.height * 0.47,
                width: Dimensions.width * 0.8,
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height * 0.01,
                  horizontal: Dimensions.width * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Colora.lightBlue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (index == 0) ...[
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 1,
                              ),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: fontList.length,
                          itemBuilder: (context, index) {
                            var value = fontList.values.toList();
                            return InkWell(
                              onTap: () {
                                bloc.add(
                                  SelectFontFamily(
                                    fontFamily: value[index]['font'],
                                  ),
                                );

                                initSelectedFont = value[index]['font'];

                                setState(() {
                                  currentFontIndex = index;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width * 0.01,
                                  vertical: Dimensions.height * 0.005,
                                ),
                                decoration: BoxDecoration(
                                  color: Colora.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color:
                                        currentFontIndex == index
                                            ? Colors.white
                                            : Colora.lightBlue,
                                    width: 2,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  value[index]['name'].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.width * 0.04,
                                    fontFamily: value[index]['font'],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        SizedBox(height: Dimensions.height * 0.08),
                      ] else if (index == 1) ...[
                        BColorPicker(
                          initialColor: initSelectedFontColor,
                          paletteType: PaletteType.hsl,
                          titleWidget: Container(
                            height: 40,
                            width: Dimensions.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colora.primaryColor,
                            ),
                            child: const Center(
                              child: Text(
                                "رنگ بندی فونت",
                                style: TextStyle(color: Colora.scaffold),
                              ),
                            ),
                          ),
                          currentIndex: 1,
                          fontColor: (value) {
                            initSelectedFontColor = value;
                          },
                        ),
                      ] else if (index == 2) ...[
                        BColorPicker(
                          initialColor: initSelectedFontSecondColor,
                          paletteType: PaletteType.hsl,
                          titleWidget: Container(
                            height: 40,
                            width: Dimensions.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colora.primaryColor,
                            ),
                            child: const Center(
                              child: Text(
                                "رنگ بندی دوم فونت",
                                style: TextStyle(color: Colora.scaffold),
                              ),
                            ),
                          ),
                          currentIndex: 2,
                          fontSecondColor: (value) {
                            initSelectedFontSecondColor = value;
                          },
                        ),
                      ],

                      Container(
                        height: Dimensions.height * 0.05,
                        color: Colora.primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //font
                            InkWell(
                              child: Container(
                                width: Dimensions.width * 0.25,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color:
                                        index == 0
                                            ? Colors.white
                                            : Colora.primaryColor,
                                  ),
                                ),
                                child: Text(
                                  'فونت',
                                  style: TextStyle(
                                    color: Colora.scaffold,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.width * 0.037,
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  index = 0;
                                });
                              },
                            ),

                            //font color
                            InkWell(
                              onTap: () {
                                setState(() {
                                  index = 1;
                                });
                              },
                              child: Container(
                                width: Dimensions.width * 0.25,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color:
                                        index == 1
                                            ? Colors.white
                                            : Colora.primaryColor,
                                  ),
                                ),
                                child: Text(
                                  'رنگ اصلی',
                                  style: TextStyle(
                                    color: Colora.scaffold,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.width * 0.037,
                                  ),
                                ),
                              ),
                            ),

                            //second font color
                            InkWell(
                              onTap: () {
                                setState(() {
                                  index = 2;
                                });
                              },
                              child: Container(
                                width: Dimensions.width * 0.25,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color:
                                        index == 2
                                            ? Colors.white
                                            : Colora.primaryColor,
                                  ),
                                ),
                                child: Text(
                                  'رنگ دوم',
                                  style: TextStyle(
                                    color: Colora.scaffold,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.width * 0.037,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: Dimensions.width,
                        decoration: const BoxDecoration(
                          color: Colora.lightBlue,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(Dimensions.fifteen),
                            bottomRight: Radius.circular(Dimensions.fifteen),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //save
                            MaterialButton(
                              onPressed: () {
                                final topColor = themeColorToHex(initTopColor);
                                final secondColor = themeColorToHex(
                                  initSecondColor,
                                );
                                final backColor = themeColorToHex(
                                  initBackColor,
                                );
                                final fontColor = themeColorToHex(
                                  initSelectedFontColor,
                                );
                                final fontSecondColor = themeColorToHex(
                                  initSelectedFontSecondColor,
                                );

                                bloc.add(
                                  SelectTheme(
                                    marketId: marketId,
                                    color: topColor,
                                    backgroundColor: backColor,
                                    secondaryColor: secondColor,

                                    font: initSelectedFont,
                                    fontColor: fontColor,
                                    fontSecondaryColor: fontSecondColor,
                                  ),
                                );

                                final messenger = ScaffoldMessenger.of(context);
                                Navigator.pop(context);
                                messenger.showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      '\u062a\u0646\u0638\u06cc\u0645\u0627\u062a \u0641\u0648\u0646\u062a \u0630\u062e\u06cc\u0631\u0647 \u0634\u062f\u061b \u062f\u0631 \u0632\u0645\u0627\u0646 \u0627\u062a\u0635\u0627\u0644 \u0628\u0627 \u0633\u0631\u0648\u0631 \u0647\u0645\u06af\u0627\u0645 \u0645\u06cc\u200c\u0634\u0648\u062f',
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'ذخیره',
                                style: TextStyle(
                                  color: Colora.scaffold_,
                                  fontSize: Dimensions.width * 0.038,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onPanUpdate: (details) {
                                setState(() {
                                  pipAlignment = _movePip(
                                    pipAlignment,
                                    details,
                                  );
                                });
                              },
                              onTap: () {
                                setState(() {
                                  pipAlignment =
                                      pipAlignment.y > 0
                                          ? Alignment.topCenter
                                          : Alignment.bottomCenter;
                                });
                              },
                              child: const SizedBox(
                                width: 48,
                                height: 48,
                                child: Icon(
                                  Icons.open_with_rounded,
                                  color: Colora.scaffold,
                                ),
                              ),
                            ),

                            //back
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                                bloc.add(
                                  SelectFontFamily(fontFamily: initFont),
                                );
                                bloc.add(
                                  SelectFontColor(fontColor: initFontColor),
                                );
                                bloc.add(
                                  SelectSecondFontColor(
                                    secondFontColor: initFontSecondColor,
                                  ),
                                );
                              },
                              child: Text(
                                'بازگشت',
                                style: TextStyle(
                                  color: Colora.scaffold_,
                                  fontSize: Dimensions.width * 0.038,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
  );
}

void changeColor(
  BuildContext context,
  bloc,
  marketId,
  initFont,
  Color initTopColor,
  Color initBackColor,
  Color initSecondColor,
  Color initFontColor,
  Color initFontSecondColor,
) {
  int index = 0;
  Color mainColorPicker = initTopColor;
  Color backgroundColorPicker = initBackColor;
  Color secondColorPicker = initSecondColor;

  Alignment pipAlignment = Alignment.bottomCenter;

  showDialog(
    barrierColor: const Color(0x00000000),
    barrierDismissible: false,
    context: context,
    builder:
        (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              backgroundColor: Colors.transparent,
              alignment: pipAlignment,
              content: SizedBox(
                height: Dimensions.height * 0.45,
                child: Column(
                  children: [
                    if (index == 0) ...[
                      AColorPicker(
                        initialColor: mainColorPicker,
                        paletteType: PaletteType.hsl,
                        titleWidget: Container(
                          height: 40,
                          width: Dimensions.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colora.primaryColor,
                          ),
                          child: const Center(
                            child: Text(
                              "رنگ بندی اصلی",
                              style: TextStyle(color: Colora.scaffold),
                            ),
                          ),
                        ),
                        currentIndex: 0,
                        mainColor: (value) {
                          mainColorPicker = value;
                        },
                      ),
                    ] else if (index == 1) ...[
                      AColorPicker(
                        initialColor: secondColorPicker,
                        paletteType: PaletteType.hsl,
                        titleWidget: Container(
                          height: 40,
                          width: Dimensions.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colora.primaryColor,
                          ),
                          child: const Center(
                            child: Text(
                              "رنگ بندی دوم",
                              style: TextStyle(color: Colora.scaffold),
                            ),
                          ),
                        ),
                        currentIndex: 1,
                        secondColor: (value) {
                          secondColorPicker = value;
                        },
                      ),
                    ] else if (index == 2) ...[
                      AColorPicker(
                        initialColor: backgroundColorPicker,
                        paletteType: PaletteType.hsl,
                        titleWidget: Container(
                          height: 40,
                          width: Dimensions.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colora.primaryColor,
                          ),
                          child: const Center(
                            child: Text(
                              "رنگ بندی زمینه",
                              style: TextStyle(color: Colora.scaffold),
                            ),
                          ),
                        ),
                        currentIndex: 2,
                        backgroundColor: (value) {
                          backgroundColorPicker = value;
                        },
                      ),
                    ],

                    Container(
                      height: Dimensions.height * 0.05,
                      color: Colora.primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //main color
                          InkWell(
                            child: Container(
                              width: Dimensions.width * 0.25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      index == 0
                                          ? Colors.white
                                          : Colora.primaryColor,
                                ),
                              ),
                              child: Text(
                                'رنگ اصلی',
                                style: TextStyle(
                                  color: Colora.scaffold,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.width * 0.037,
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                index = 0;
                              });
                            },
                          ),

                          //second color
                          InkWell(
                            onTap: () {
                              setState(() {
                                index = 1;
                              });
                            },
                            child: Container(
                              width: Dimensions.width * 0.25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      index == 1
                                          ? Colors.white
                                          : Colora.primaryColor,
                                ),
                              ),
                              child: Text(
                                'رنگ دوم',
                                style: TextStyle(
                                  color: Colora.scaffold,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.width * 0.037,
                                ),
                              ),
                            ),
                          ),

                          //back color
                          InkWell(
                            onTap: () {
                              setState(() {
                                index = 2;
                              });
                            },
                            child: Container(
                              width: Dimensions.width * 0.25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      index == 2
                                          ? Colors.white
                                          : Colora.primaryColor,
                                ),
                              ),
                              child: Text(
                                'رنگ زمینه',
                                style: TextStyle(
                                  color: Colora.scaffold,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.width * 0.037,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: Dimensions.width,
                      decoration: const BoxDecoration(
                        color: Colora.lightBlue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Dimensions.fifteen),
                          bottomRight: Radius.circular(Dimensions.fifteen),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //save
                          MaterialButton(
                            onPressed: () {
                              final topColor = themeColorToHex(mainColorPicker);
                              final secondColor = themeColorToHex(
                                secondColorPicker,
                              );
                              final backColor = themeColorToHex(
                                backgroundColorPicker,
                              );
                              final fontColor = themeColorToHex(initFontColor);
                              final fontSecondColor = themeColorToHex(
                                initFontSecondColor,
                              );

                              bloc.add(
                                SelectTheme(
                                  marketId: marketId,
                                  color: topColor,
                                  backgroundColor: backColor,
                                  secondaryColor: secondColor,

                                  font: initFont,
                                  fontColor: fontColor,
                                  fontSecondaryColor: fontSecondColor,
                                ),
                              );

                              final messenger = ScaffoldMessenger.of(context);
                              Navigator.pop(context);
                              messenger.showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    '\u0631\u0646\u06af\u200c\u0628\u0646\u062f\u06cc \u0630\u062e\u06cc\u0631\u0647 \u0634\u062f\u061b \u062f\u0631 \u0632\u0645\u0627\u0646 \u0627\u062a\u0635\u0627\u0644 \u0628\u0627 \u0633\u0631\u0648\u0631 \u0647\u0645\u06af\u0627\u0645 \u0645\u06cc\u200c\u0634\u0648\u062f',
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'ذخیره',
                              style: TextStyle(
                                color: Colora.scaffold_,
                                fontSize: Dimensions.width * 0.038,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onPanUpdate: (details) {
                              setState(() {
                                pipAlignment = _movePip(pipAlignment, details);
                              });
                            },
                            onTap: () {
                              setState(() {
                                pipAlignment =
                                    pipAlignment.y > 0
                                        ? Alignment.topCenter
                                        : Alignment.bottomCenter;
                              });
                            },
                            child: const SizedBox(
                              width: 48,
                              height: 48,
                              child: Icon(
                                Icons.open_with_rounded,
                                color: Colora.scaffold,
                              ),
                            ),
                          ),

                          // back
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                              bloc.add(SelectTopColor(topColor: initTopColor));
                              bloc.add(
                                SelectSecondColor(secondColor: initSecondColor),
                              );
                              bloc.add(
                                SelectBackColor(backColor: initBackColor),
                              );
                            },
                            child: Text(
                              'بازگشت',
                              style: TextStyle(
                                color: Colora.scaffold_,
                                fontSize: Dimensions.width * 0.038,
                                fontWeight: FontWeight.bold,
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
          },
        ),
  );
}

Alignment _movePip(Alignment current, DragUpdateDetails details) {
  return Alignment(
    (current.x + details.delta.dx / (Dimensions.width * .4))
        .clamp(-1.0, 1.0)
        .toDouble(),
    (current.y + details.delta.dy / (Dimensions.height * .25))
        .clamp(-1.0, 1.0)
        .toDouble(),
  );
}
