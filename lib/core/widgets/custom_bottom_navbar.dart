import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/secure_storage.dart';
import 'package:asood/core/router/app_routers.dart';
import 'package:asood/core/widgets/colorpicker.dart';
import 'package:asood/features/market/presentation/blocs/bloc/market_bloc.dart';
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Takhfif Route
                  IconButton(
                    onPressed: () {
                      context.push(AppRoutes.takhfif);
                      /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TakhfifScreen(),
                        ),
                      ); */
                    },
                    icon: const Icon(Icons.settings, color: Colors.white),
                  ),

                  //credit card
                  IconButton(
                    onPressed: () {},
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
                      context.push(AppRoutes.editStoreInfo);
                      /*      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditStoreInfoScreen(),
                        ),
                      ); */
                    },
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

  int currentFontIndex = -1;

  bool pos = false;

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
              alignment:
                  pos == false ? Alignment.bottomCenter : Alignment.topCenter,
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
                                var topColor = initTopColor.value
                                    .toRadixString(16)
                                    .substring(2, 8);
                                var secondColor = initSecondColor.value
                                    .toRadixString(16)
                                    .substring(2, 8);
                                var backColor = initBackColor.value
                                    .toRadixString(16)
                                    .substring(2, 8);
                                var fontColor = initSelectedFontColor.value
                                    .toRadixString(16)
                                    .substring(2, 8);
                                var fontSecondColor =
                                    initSelectedFontSecondColor.value
                                        .toRadixString(16)
                                        .substring(2, 8);

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

                                Navigator.pop(context);
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

                            IconButton(
                              onPressed: () {
                                setState(() {
                                  pos = !pos;
                                });
                              },
                              icon: Icon(
                                pos == false
                                    ? Icons.arrow_circle_up_rounded
                                    : Icons.arrow_circle_down_rounded,
                                color: Colora.scaffold,
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

  bool pos = false;

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
              alignment:
                  pos == false ? Alignment.bottomCenter : Alignment.topCenter,
              content: SizedBox(
                height: Dimensions.height * 0.45,
                child: Column(
                  children: [
                    if (index == 0) ...[
                      AColorPicker(
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
                              var topColor = mainColorPicker.value
                                  .toRadixString(16)
                                  .substring(2, 8);
                              var secondColor = secondColorPicker.value
                                  .toRadixString(16)
                                  .substring(2, 8);
                              var backColor = backgroundColorPicker.value
                                  .toRadixString(16)
                                  .substring(2, 8);
                              var fontColor = initFontColor.value
                                  .toRadixString(16)
                                  .substring(2, 8);
                              var fontSecondColor = initFontSecondColor.value
                                  .toRadixString(16)
                                  .substring(2, 8);

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

                              Navigator.pop(context);
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

                          IconButton(
                            onPressed: () {
                              setState(() {
                                pos = !pos;
                              });
                            },
                            icon: Icon(
                              pos == false
                                  ? Icons.arrow_circle_up_rounded
                                  : Icons.arrow_circle_down_rounded,
                              color: Colora.scaffold,
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
