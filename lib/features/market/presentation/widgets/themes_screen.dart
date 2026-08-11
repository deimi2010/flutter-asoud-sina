import 'dart:convert';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/secure_storage.dart';
import 'package:asood/core/helper/snack_bar_util.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/core/router/app_routers.dart';
import 'package:asood/features/market/data/model/theme_model_model.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';
import 'package:asood/features/market/presentation/blocs/bloc/market_bloc.dart';
import 'package:asood/features/vendor/presentation/bloc/vendor/vendor_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/endpoints.dart';

class MultiViewSliderScreen extends StatefulWidget {
  const MultiViewSliderScreen({super.key});

  @override
  State<MultiViewSliderScreen> createState() => _MultiViewSliderScreenState();
}

class _MultiViewSliderScreenState extends State<MultiViewSliderScreen> {
  late MarketBloc bloc;

  final PageController _pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of<MarketBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colora.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // bottomNavigationBar: const SimpleBotNavBar(),
          body: Stack(
            children: [
              BlocBuilder<VendorBloc, VendorState>(
                builder:
                    (context, styleState) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   height: Dimensions.height * 0.1,
                        // ),
                        SizedBox(
                          height: Dimensions.height * 0.35,
                          // padding: EdgeInsets.symmetric(
                          //   horizontal: Dimensions.width * 0.02
                          // ),
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (int page) {
                              bloc.add(ChangeTemplateEvent(template: page));
                            },
                            children: [
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 0,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 1,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 2,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 3,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 4,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 5,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 6,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 7,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 8,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 9,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 10,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 11,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 12,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 13,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 14,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 15,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 16,
                                isAdmin: false,
                                themeId: "",
                              ),
                              buildProductGridView(
                                marketId: bloc.state.marketId,
                                templateIndex: 17,
                                isAdmin: false,
                                themeId: "",
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        buildDotList(styleState),

                        SizedBox(height: Dimensions.height * 0.01),

                        //save button
                        BlocBuilder<MarketBloc, MarketState>(
                          builder: (context, state) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: Dimensions.width * 0.3,
                                height: Dimensions.height * 0.05,
                                color: styleState.secondColor,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (state.status != CWSStatus.loading) {
                                      bloc.add(
                                        AddTemplateEvent(
                                          marketId: bloc.state.marketId,
                                          template: bloc.state.templateIndex,
                                        ),
                                      );
                                    }
                                    if (bloc.state.status ==
                                            CWSStatus.success &&
                                        state.status != CWSStatus.loading) {
                                      showSnackBar(
                                        context,
                                        "قالب با موفقیت اضافه شد",
                                      );
                                    }
                                  },
                                  child:
                                      state.status == CWSStatus.loading
                                          ? const Center(
                                            child: SizedBox(
                                              height: 25,
                                              width: 25,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                          : Text(
                                            'ذخیره',
                                            style: TextStyle(
                                              color: styleState.fontColor,
                                              fontFamily: styleState.fontFamily,
                                              fontSize:
                                                  Dimensions.width * 0.037,
                                            ),
                                          ),
                                ),
                              ),
                            );
                            // return CustomButton(

                            //   onPress: () {
                            //
                            //   },
                            //   text:
                            //       state.status == CWSStatus.loading
                            //           ? null
                            //           : "ذخیره",
                            //   color: Colors.white,
                            //   textColor: Colora.primaryColor,
                            //   height: 40,
                            //   width: 100,
                            //   btnWidget:
                            //       state.status == CWSStatus.loading
                            //           ? const Center(
                            //             child: SizedBox(
                            //               height: 25,
                            //               width: 25,
                            //               child: CircularProgressIndicator(),
                            //             ),
                            //           )
                            //           : null,
                            // );
                          },
                        ),
                      ],
                    ),
              ),

              // const NewAppBar(title: 'قالب ها',),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDotList(styleState) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 18,
        shrinkWrap: true,
        itemBuilder:
            (context, index) => SizedBox(
              width: Dimensions.width * 0.05,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: styleState.secondColor, width: 2),
                    color:
                        bloc.state.templateIndex == index
                            ? styleState.secondColor
                            : Colora.scaffold,
                  ),
                ),
              ),
            ),
      ),
    );

    //   Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: List<Widget>.generate(18, (index) {
    //     return Container(
    //       width: 10,
    //       height: 10,
    //       margin: const EdgeInsets.symmetric(horizontal: 5),
    //       decoration: BoxDecoration(
    //         shape: BoxShape.circle,
    //         border: Border.all(
    //           color: styleState.secondColor,
    //           width: 2
    //         ),
    //         color: _currentPage == index ? styleState.secondColor : Colora.scaffold,
    //       ),
    //     );
    //   }),
    // );
  }
}

class ProductGridView extends StatefulWidget {
  final String marketId;
  final int templateIndex;
  final bool isAdmin;
  final String themeId;
  final List<ThemeProductModel>? products;
  const ProductGridView({
    super.key,
    required this.marketId,
    required this.templateIndex,
    this.isAdmin = false,
    required this.themeId,
    this.products,
  });

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  Future<String> getProductLableById(String? id) async {
    String url = '${Endpoints.baseUrl}owner/product/detail/$id/';
    String? token = await SecureStorage.readSecureStorage(Keys.token);

    var response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    return jsonDecode(response.body)['data']['tag'];
  }

  Future<String> getProductLablePositionById(String? id) async {
    String url = '${Endpoints.baseUrl}owner/product/detail/$id/';
    String? token = await SecureStorage.readSecureStorage(Keys.token);

    var response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    return jsonDecode(response.body)['data']['tag_position'];
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: Dimensions.height * 0.3),
      child: BlocBuilder<VendorBloc, VendorState>(
        builder: (context, styleState) {
          switch (widget.templateIndex) {
            case 0:
              return _buildTemplate0(styleState, widget.products);
            case 1:
              return _buildTemplate1(styleState, widget.products);
            case 2:
              return _buildTemplate2(styleState, widget.products);
            case 3:
              return _buildTemplate3(styleState, widget.products);
            case 4:
              return _buildTemplate4(styleState, widget.products);
            case 5:
              return _buildTemplate5(styleState, widget.products);
            case 6:
              return _buildTemplate6(styleState, widget.products);
            case 7:
              return _buildTemplate7(styleState, widget.products);
            case 8:
              return _buildTemplate8(styleState, widget.products);
            case 9:
              return _buildTemplate9(styleState, widget.products);
            case 10:
              return _buildTemplate10(styleState, widget.products);
            case 11:
              return _buildTemplate11(styleState, widget.products);
            case 12:
              return _buildTemplate12(styleState, widget.products);
            case 13:
              return _buildTemplate13(styleState, widget.products);
            case 14:
              return _buildTemplate14(styleState, widget.products);
            case 15:
              return _buildTemplate15(styleState, widget.products);
            case 16:
              return _buildTemplate16(styleState, widget.products);
            case 17:
              return _buildTemplate17(styleState, widget.products);

            default:
              return _buildTemplate1(styleState, widget.products);
          }
        },
      ),
    );
  }

  Widget _buildProductCard({
    required BuildContext context,
    required double width,
    required double height,
    required double imageHeight,
    required double fontSize,
    required double priceFontSize,
    required VendorState styleState,
    required int themeIndex,
    ThemeProductModel? product,
  }) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.width * 0.01,
        vertical: Dimensions.height * 0.008,
      ),
      decoration: BoxDecoration(
        color: styleState.secondColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          if (widget.isAdmin) {
            if (product?.id == null) {
              context.read<AddProductBloc>().add(ResetDataEvent());
              context.push(
                AppRoutes.createProduct,
                extra: [widget.marketId, widget.themeId, themeIndex],
              );
            } else {
              // here is based on employer request:
              context.push(AppRoutes.product, extra: [product]);
              // go to edit page just like see page but its for the admin and has some differences.
            }
          } else {
            if (product != null) {
              context.push(AppRoutes.product, extra: [product]);
            }
            // context.push(AppRoutes.createProduct, extra: marketId);
          }
        },
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Container(
                      height: imageHeight,
                      width: width,
                      color: Colors.white,
                      child:
                          product?.images != null && product!.images.isNotEmpty
                              ? CachedNetworkImage(
                                imageUrl: product.images[0].image,
                                fit: BoxFit.cover,
                              )
                              : SvgPicture.asset(
                                'assets/images/logo_svg.svg',
                                colorFilter: ColorFilter.mode(
                                  styleState.secondColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                    ),

                    // Label part:
                    FutureBuilder(
                      future: getProductLableById(product?.id),
                      builder: (context, asyncSnapshot) {
                        return Padding(
                          padding: EdgeInsets.all(8),
                          child: FutureBuilder(
                            future: getProductLablePositionById(product?.id),
                            builder: (context, positionSnapshot) {
                              return Align(
                                alignment:
                                    positionSnapshot.data == 'bottom_right'
                                        ? Alignment.bottomRight
                                        : positionSnapshot.data == 'top_right'
                                        ? Alignment.topRight
                                        : positionSnapshot.data == 'bottom_left'
                                        ? Alignment.bottomLeft
                                        : Alignment.topLeft,
                                child:
                                    asyncSnapshot.data == 'new'
                                        ? SizedBox(
                                          child: Image(
                                            image: AssetImage(
                                              'assets/images/new_product.png',
                                            ),
                                          ),
                                        )
                                        : asyncSnapshot.data == 'special_offer'
                                        ? Image(
                                          image: AssetImage(
                                            'assets/images/special_product.png',
                                          ),
                                        )
                                        : Container(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width * 0.01,
                vertical: Dimensions.height * 0.007,
              ),
              child: Text(
                product?.name ?? 'عنوان محصول',
                softWrap: true,
                maxLines: 1,
                style: TextStyle(
                  color: styleState.fontColor,
                  fontFamily: styleState.fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width * 0.01,
                vertical: Dimensions.height * 0.005,
              ),
              child: Text(
                product?.mainPrice != null
                    ? "${product?.mainPrice} تومان"
                    : "قیمت محصول",
                softWrap: true,
                maxLines: 1,
                style: TextStyle(
                  color: styleState.fontColor,
                  fontFamily: styleState.fontFamily,
                  fontSize: priceFontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowProductCard({
    required BuildContext context,
    required double width,
    required double height,
    required double imageHeight,
    required double imageWidth,
    required double fontSize,
    required double priceFontSize,
    required VendorState styleState,
    required bool leftAligned,
    required int themeIndex,
    ThemeProductModel? product,
  }) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.width * 0.01,
        vertical: Dimensions.height * 0.008,
      ),
      decoration: BoxDecoration(
        color: styleState.secondColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Directionality(
        textDirection: leftAligned ? TextDirection.rtl : TextDirection.ltr,
        child: InkWell(
          onTap: () {
            if (widget.isAdmin) {
              context.read<AddProductBloc>().add(ResetDataEvent());
              context.push(
                AppRoutes.createProduct,
                extra: [widget.marketId, themeIndex],
              );
            } else {
              // TODO: SHOULD CHANGE THIS TO PRODUCT DETAILS
              // context.push(
              //   AppRoutes.createProduct,
              //   extra: [marketId, themeIndex],
              // );
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: imageWidth,
                  height: imageHeight,
                  color: Colors.white,
                  child:
                      product?.images.isNotEmpty ?? false
                          ? SvgPicture.network(
                            product?.images[0].image ?? "",
                            fit: BoxFit.cover,
                          )
                          : SvgPicture.asset(
                            'assets/images/logo_svg.svg',
                            colorFilter: ColorFilter.mode(
                              styleState.secondColor,
                              BlendMode.srcIn,
                            ),
                          ),
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width * 0.01,
                        vertical: Dimensions.height * 0.007,
                      ),
                      child: Text(
                        product?.name ?? 'عنوان محصول',
                        softWrap: true,
                        maxLines: 1,
                        style: TextStyle(
                          color: styleState.fontColor,
                          fontFamily: styleState.fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width * 0.01,
                        vertical: Dimensions.height * 0.005,
                      ),
                      child: Text(
                        product?.mainPrice != ""
                            ? "${product?.mainPrice} تومان"
                            : 'قیمت محصول',
                        softWrap: true,
                        maxLines: 1,
                        style: TextStyle(
                          color: styleState.fontColor,
                          fontFamily: styleState.fontFamily,
                          fontSize: priceFontSize,
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
  }

  Widget _buildTemplate1(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _buildProductCard(
                        context: context,
                        width: double.infinity,
                        height: double.infinity,
                        imageHeight: Dimensions.height * 0.115,
                        fontSize: Dimensions.width * 0.02,
                        priceFontSize: Dimensions.width * 0.017,
                        styleState: styleState,
                        themeIndex: 1,
                        product: getProductByThemeIndex(1, products),
                      ),
                    ),
                    Expanded(
                      child: _buildProductCard(
                        context: context,
                        width: double.infinity,
                        height: double.infinity,
                        imageHeight: Dimensions.height * 0.115,
                        fontSize: Dimensions.width * 0.02,
                        priceFontSize: Dimensions.width * 0.017,
                        styleState: styleState,
                        themeIndex: 2,
                        product: getProductByThemeIndex(2, products),
                      ),
                    ),
                  ],
                ),
              ),
              _buildProductCard(
                context: context,
                width: Dimensions.width * 0.4,
                height: Dimensions.height * 0.35,
                imageHeight: Dimensions.height * 0.275,
                fontSize: Dimensions.width * 0.025,
                priceFontSize: Dimensions.width * 0.017,
                styleState: styleState,
                themeIndex: 3,
                product: getProductByThemeIndex(3, products),
              ),
            ],
          ),
    );
  }

  ThemeProductModel? getProductByThemeIndex(
    int index,
    List<ThemeProductModel>? products,
  ) {
    try {
      return products?.firstWhere(
        (product) => product.themeIndex == index.toString(),
      );
    } catch (_) {
      return null;
    }
  }

  Widget _buildTemplate0(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Row(
            children: [
              _buildProductCard(
                context: context,
                width: Dimensions.width * 0.4,
                height: Dimensions.height * 0.35,
                imageHeight: Dimensions.height * 0.275,
                fontSize: Dimensions.width * 0.025,
                priceFontSize: Dimensions.width * 0.017,
                styleState: styleState,
                themeIndex: 1,
                product: getProductByThemeIndex(1, products),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _buildProductCard(
                        context: context,
                        width: double.infinity,
                        height: double.infinity,
                        imageHeight: Dimensions.height * 0.115,
                        fontSize: Dimensions.width * 0.02,
                        priceFontSize: Dimensions.width * 0.017,
                        styleState: styleState,
                        themeIndex: 2,
                        product: getProductByThemeIndex(2, products),
                      ),
                    ),
                    Expanded(
                      child: _buildProductCard(
                        context: context,
                        width: double.infinity,
                        height: double.infinity,
                        imageHeight: Dimensions.height * 0.115,
                        fontSize: Dimensions.width * 0.02,
                        priceFontSize: Dimensions.width * 0.017,
                        styleState: styleState,
                        themeIndex: 3,
                        product: getProductByThemeIndex(3, products),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate2(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _buildProductCard(
                        context: context,
                        width: double.infinity,
                        height: double.infinity,
                        imageHeight: Dimensions.height * 0.115,
                        fontSize: Dimensions.width * 0.02,
                        priceFontSize: Dimensions.width * 0.017,
                        styleState: styleState,
                        themeIndex: 1,
                        product: getProductByThemeIndex(1, products),
                      ),
                    ),
                    Expanded(
                      child: _buildProductCard(
                        context: context,
                        width: double.infinity,
                        height: double.infinity,
                        imageHeight: Dimensions.height * 0.115,
                        fontSize: Dimensions.width * 0.02,
                        priceFontSize: Dimensions.width * 0.017,
                        styleState: styleState,
                        themeIndex: 2,
                        product: getProductByThemeIndex(2, products),
                      ),
                    ),
                  ],
                ),
              ),
              _buildProductCard(
                context: context,
                width: Dimensions.width * 0.55,
                height: Dimensions.height,
                imageHeight: Dimensions.height * 0.275,
                fontSize: Dimensions.width * 0.025,
                priceFontSize: Dimensions.width * 0.017,
                styleState: styleState,
                themeIndex: 3,
                product: getProductByThemeIndex(3, products),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate3(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Row(
            children: [
              _buildProductCard(
                context: context,
                width: Dimensions.width * 0.55,
                height: Dimensions.height,
                imageHeight: Dimensions.height * 0.275,
                fontSize: Dimensions.width * 0.025,
                priceFontSize: Dimensions.width * 0.017,
                styleState: styleState,
                themeIndex: 1,
                product: getProductByThemeIndex(1, products),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _buildProductCard(
                        context: context,
                        width: double.infinity,
                        height: double.infinity,
                        imageHeight: Dimensions.height * 0.115,
                        fontSize: Dimensions.width * 0.02,
                        priceFontSize: Dimensions.width * 0.017,
                        styleState: styleState,
                        themeIndex: 2,
                        product: getProductByThemeIndex(2, products),
                      ),
                    ),
                    Expanded(
                      child: _buildProductCard(
                        context: context,
                        width: double.infinity,
                        height: double.infinity,
                        imageHeight: Dimensions.height * 0.115,
                        fontSize: Dimensions.width * 0.02,
                        priceFontSize: Dimensions.width * 0.017,
                        styleState: styleState,
                        themeIndex: 3,
                        product: getProductByThemeIndex(3, products),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate4(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _buildProductCard(
                        context: context,
                        width: double.infinity,
                        height: double.infinity,
                        imageHeight: Dimensions.height * 0.115,
                        fontSize: Dimensions.width * 0.02,
                        priceFontSize: Dimensions.width * 0.017,
                        styleState: styleState,
                        themeIndex: 1,
                        product: getProductByThemeIndex(1, products),
                      ),
                    ),
                    Expanded(
                      child: _buildProductCard(
                        context: context,
                        width: double.infinity,
                        height: double.infinity,
                        imageHeight: Dimensions.height * 0.115,
                        fontSize: Dimensions.width * 0.02,
                        priceFontSize: Dimensions.width * 0.017,
                        styleState: styleState,
                        themeIndex: 2,
                        product: getProductByThemeIndex(2, products),
                      ),
                    ),
                  ],
                ),
              ),
              _buildProductCard(
                context: context,
                width: Dimensions.width * 0.40,
                height: Dimensions.height,
                imageHeight: Dimensions.height * 0.275,
                fontSize: Dimensions.width * 0.025,
                priceFontSize: Dimensions.width * 0.017,
                styleState: styleState,
                themeIndex: 4,
                product: getProductByThemeIndex(4, products),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate5(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Row(
            children: [
              _buildProductCard(
                context: context,
                width: Dimensions.width * 0.40,
                height: Dimensions.height,
                imageHeight: Dimensions.height * 0.275,
                fontSize: Dimensions.width * 0.025,
                priceFontSize: Dimensions.width * 0.017,
                styleState: styleState,
                themeIndex: 1,
                product: getProductByThemeIndex(1, products),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _buildProductCard(
                        context: context,
                        width: double.infinity,
                        height: double.infinity,
                        imageHeight: Dimensions.height * 0.115,
                        fontSize: Dimensions.width * 0.02,
                        priceFontSize: Dimensions.width * 0.017,
                        styleState: styleState,
                        themeIndex: 2,
                        product: getProductByThemeIndex(2, products),
                      ),
                    ),
                    Expanded(
                      child: _buildProductCard(
                        context: context,
                        width: double.infinity,
                        height: double.infinity,
                        imageHeight: Dimensions.height * 0.115,
                        fontSize: Dimensions.width * 0.02,
                        priceFontSize: Dimensions.width * 0.017,
                        styleState: styleState,
                        themeIndex: 3,
                        product: getProductByThemeIndex(3, products),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate6(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Row(
            children: [
              Expanded(
                child: _buildProductCard(
                  context: context,
                  width: double.infinity,
                  height: double.infinity,
                  imageHeight: Dimensions.height * 0.275,
                  fontSize: Dimensions.width * 0.025,
                  priceFontSize: Dimensions.width * 0.017,
                  styleState: styleState,
                  themeIndex: 1,
                  product: getProductByThemeIndex(1, products),
                ),
              ),
              Expanded(
                child: _buildProductCard(
                  context: context,
                  width: double.infinity,
                  height: double.infinity,
                  imageHeight: Dimensions.height * 0.275,
                  fontSize: Dimensions.width * 0.025,
                  priceFontSize: Dimensions.width * 0.017,
                  styleState: styleState,
                  themeIndex: 2,
                  product: getProductByThemeIndex(2, products),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate7(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildProductCard(
                  context: context,
                  width: double.infinity,
                  height: double.infinity,
                  imageHeight: Dimensions.height * 0.275,
                  fontSize: Dimensions.width * 0.025,
                  priceFontSize: Dimensions.width * 0.017,
                  styleState: styleState,
                  themeIndex: 1,
                  product: getProductByThemeIndex(1, products),
                ),
              ),
              Expanded(
                flex: 1,
                child: _buildProductCard(
                  context: context,
                  width: double.infinity,
                  height: double.infinity,
                  imageHeight: Dimensions.height * 0.275,
                  fontSize: Dimensions.width * 0.025,
                  priceFontSize: Dimensions.width * 0.017,
                  styleState: styleState,
                  themeIndex: 2,
                  product: getProductByThemeIndex(2, products),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate8(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Row(
            children: [
              Expanded(
                flex: 1,
                child: _buildProductCard(
                  context: context,
                  width: double.infinity,
                  height: double.infinity,
                  imageHeight: Dimensions.height * 0.275,
                  fontSize: Dimensions.width * 0.025,
                  priceFontSize: Dimensions.width * 0.017,
                  styleState: styleState,
                  themeIndex: 1,
                  product: getProductByThemeIndex(1, products),
                ),
              ),
              Expanded(
                flex: 2,
                child: _buildProductCard(
                  context: context,
                  width: double.infinity,
                  height: double.infinity,
                  imageHeight: Dimensions.height * 0.275,
                  fontSize: Dimensions.width * 0.025,
                  priceFontSize: Dimensions.width * 0.017,
                  styleState: styleState,
                  themeIndex: 2,
                  product: getProductByThemeIndex(2, products),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate9(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Column(
            children: [
              SizedBox(
                height: Dimensions.height * 0.15,
                child: _buildRowProductCard(
                  context: context,
                  width: double.infinity,
                  height: Dimensions.height * 0.15,
                  imageHeight: Dimensions.height * 0.15,
                  imageWidth: Dimensions.width * 0.4,
                  fontSize: Dimensions.width * 0.025,
                  priceFontSize: Dimensions.width * 0.017,
                  styleState: styleState,
                  leftAligned: true,
                  themeIndex: 1,
                  product: getProductByThemeIndex(1, products),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate10(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Column(
            children: [
              SizedBox(
                height: Dimensions.height * 0.15,
                child: _buildRowProductCard(
                  context: context,
                  width: double.infinity,
                  height: Dimensions.height * 0.15,
                  imageHeight: Dimensions.height * 0.15,
                  imageWidth: Dimensions.width * 0.4,
                  fontSize: Dimensions.width * 0.025,
                  priceFontSize: Dimensions.width * 0.017,
                  styleState: styleState,
                  leftAligned: false,
                  themeIndex: 1,
                  product: getProductByThemeIndex(1, products),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate11(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Column(
            children: [
              SizedBox(
                height: Dimensions.height * 0.35,
                child: _buildProductCard(
                  context: context,
                  width: double.infinity,
                  height: double.infinity,
                  imageHeight: Dimensions.height * 0.275,
                  fontSize: Dimensions.width * 0.025,
                  priceFontSize: Dimensions.width * 0.017,
                  styleState: styleState,
                  themeIndex: 1,
                  product: getProductByThemeIndex(1, products),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate12(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Row(
            children: [
              Expanded(
                child: _buildProductCard(
                  context: context,
                  width: double.infinity,
                  height: double.infinity,
                  imageHeight: Dimensions.height * 0.275,
                  fontSize: Dimensions.width * 0.025,
                  priceFontSize: Dimensions.width * 0.017,
                  styleState: styleState,
                  themeIndex: 1,
                  product: getProductByThemeIndex(1, products),
                ),
              ),
              Expanded(
                child: _buildProductCard(
                  context: context,
                  width: double.infinity,
                  height: double.infinity,
                  imageHeight: Dimensions.height * 0.275,
                  fontSize: Dimensions.width * 0.025,
                  priceFontSize: Dimensions.width * 0.017,
                  styleState: styleState,
                  themeIndex: 2,
                  product: getProductByThemeIndex(2, products),
                ),
              ),
              Expanded(
                child: _buildProductCard(
                  context: context,
                  width: double.infinity,
                  height: double.infinity,
                  imageHeight: Dimensions.height * 0.275,
                  fontSize: Dimensions.width * 0.025,
                  priceFontSize: Dimensions.width * 0.017,
                  styleState: styleState,
                  themeIndex: 3,
                  product: getProductByThemeIndex(3, products),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate13(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: Dimensions.height * 0.35 * 0.75,
                  child: _buildProductCard(
                    context: context,
                    width: double.infinity,
                    height: double.infinity,
                    imageHeight: Dimensions.height * 0.275,
                    fontSize: Dimensions.width * 0.025,
                    priceFontSize: Dimensions.width * 0.017,
                    styleState: styleState,
                    themeIndex: 1,
                    product: getProductByThemeIndex(1, products),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: Dimensions.height * 0.35 * 0.75,
                  child: _buildProductCard(
                    context: context,
                    width: double.infinity,
                    height: double.infinity,
                    imageHeight: Dimensions.height * 0.275,
                    fontSize: Dimensions.width * 0.025,
                    priceFontSize: Dimensions.width * 0.017,
                    styleState: styleState,
                    themeIndex: 2,
                    product: getProductByThemeIndex(2, products),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: Dimensions.height * 0.35 * 0.75,
                  child: _buildProductCard(
                    context: context,
                    width: double.infinity,
                    height: double.infinity,
                    imageHeight: Dimensions.height * 0.275,
                    fontSize: Dimensions.width * 0.025,
                    priceFontSize: Dimensions.width * 0.017,
                    styleState: styleState,
                    themeIndex: 3,
                    product: getProductByThemeIndex(3, products),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate14(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: Dimensions.height * 0.25 * 0.75,
                  child: _buildProductCard(
                    context: context,
                    width: double.infinity,
                    height: double.infinity,
                    imageHeight: Dimensions.height * 0.275,
                    fontSize: Dimensions.width * 0.025,
                    priceFontSize: Dimensions.width * 0.017,
                    styleState: styleState,
                    themeIndex: 1,
                    product: getProductByThemeIndex(1, products),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: Dimensions.height * 0.25 * 0.75,
                  child: _buildProductCard(
                    context: context,
                    width: double.infinity,
                    height: double.infinity,
                    imageHeight: Dimensions.height * 0.275,
                    fontSize: Dimensions.width * 0.025,
                    priceFontSize: Dimensions.width * 0.017,
                    styleState: styleState,
                    themeIndex: 2,
                    product: getProductByThemeIndex(2, products),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: Dimensions.height * 0.25 * 0.75,
                  child: _buildProductCard(
                    context: context,
                    width: double.infinity,
                    height: double.infinity,
                    imageHeight: Dimensions.height * 0.275,
                    fontSize: Dimensions.width * 0.025,
                    priceFontSize: Dimensions.width * 0.017,
                    styleState: styleState,
                    themeIndex: 3,
                    product: getProductByThemeIndex(3, products),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate15(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: Dimensions.height * 0.35 * 0.75,
                  child: _buildProductCard(
                    context: context,
                    width: Dimensions.width * 0.4,
                    height: double.infinity,
                    imageHeight: Dimensions.height * 0.275,
                    fontSize: Dimensions.width * 0.025,
                    priceFontSize: Dimensions.width * 0.017,
                    styleState: styleState,
                    themeIndex: 1,
                    product: getProductByThemeIndex(1, products),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.height * 0.35 * 0.75,
                child: _buildProductCard(
                  context: context,
                  width: Dimensions.width * 0.55,
                  height: Dimensions.height * 0.35 * 0.75,
                  imageHeight: Dimensions.height * 0.275,
                  fontSize: Dimensions.width * 0.025,
                  priceFontSize: Dimensions.width * 0.017,
                  styleState: styleState,
                  themeIndex: 2,
                  product: getProductByThemeIndex(2, products),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate16(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Row(
            children: [
              SizedBox(
                height: Dimensions.height * 0.35 * 0.75,
                child: _buildProductCard(
                  context: context,
                  width: Dimensions.width * 0.55,
                  height: Dimensions.height * 0.35 * 0.75,
                  imageHeight: Dimensions.height * 0.275,
                  fontSize: Dimensions.width * 0.025,
                  priceFontSize: Dimensions.width * 0.017,
                  styleState: styleState,
                  themeIndex: 1,
                  product: getProductByThemeIndex(1, products),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: Dimensions.height * 0.35 * 0.75,
                  child: _buildProductCard(
                    context: context,
                    width: Dimensions.width * 0.4,
                    height: double.infinity,
                    imageHeight: Dimensions.height * 0.275,
                    fontSize: Dimensions.width * 0.025,
                    priceFontSize: Dimensions.width * 0.017,
                    styleState: styleState,
                    themeIndex: 2,
                    product: getProductByThemeIndex(2, products),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildTemplate17(
    VendorState styleState,
    List<ThemeProductModel>? products,
  ) {
    return Builder(
      builder:
          (context) => Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: Dimensions.height * 0.35 * 0.75,
                  child: _buildProductCard(
                    context: context,
                    width: double.infinity,
                    height: double.infinity,
                    imageHeight: Dimensions.height * 0.275,
                    fontSize: Dimensions.width * 0.025,
                    priceFontSize: Dimensions.width * 0.017,
                    styleState: styleState,
                    themeIndex: 1,
                    product: getProductByThemeIndex(1, products),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: Dimensions.height * 0.35 * 0.75,

                  child: _buildProductCard(
                    context: context,
                    width: double.infinity,
                    height: double.infinity,
                    imageHeight: Dimensions.height * 0.275,
                    fontSize: Dimensions.width * 0.025,
                    priceFontSize: Dimensions.width * 0.017,
                    styleState: styleState,
                    themeIndex: 2,
                    product: getProductByThemeIndex(2, products),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}

Widget buildProductGridView({
  required String marketId,
  String? themeId,
  required int templateIndex,
  bool isAdmin = false,
  List<ThemeProductModel>? products,
}) {
  return ProductGridView(
    marketId: marketId,
    templateIndex: templateIndex,
    isAdmin: isAdmin,
    themeId: themeId ?? "",
    products: products,
  );
}
