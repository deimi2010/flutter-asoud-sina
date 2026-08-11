import 'package:asood/core/models/market_model.dart';
import 'package:asood/core/router/app_routers.dart';
import 'package:asood/features/market/presentation/widgets/share_store.dart';
import 'package:asood/features/vendor/presentation/bloc/workspace/workspace_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/constants.dart';
import 'custom_button.dart';

class StoreCard extends StatefulWidget {
  const StoreCard({
    super.key,
    required this.market,
    required this.index,
    this.menuVisibility = true,
    required this.bloc,
  });
  final MarketModel market;
  final int index;
  final bool menuVisibility;
  final WorkspaceBloc bloc;

  @override
  State<StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  bool isMenuVisible = false;

  String shopStatus(String status) {
    String faStatus = '';
    switch (status) {
      case 'draft':
        faStatus = 'پیش نویس';
        break;
      case 'queue':
        faStatus = 'در دست انتشار';
        break;
      case 'not_published':
        faStatus = 'منتشر نشده';
        break;
      case 'published':
        faStatus = 'منتشر شده';
        break;
      case 'needs_editing':
        faStatus = 'نیاز به ویرایش';
        break;
      case 'inactive':
        faStatus = 'غیر فعال';
        break;
      default:
        faStatus = 'نامشخص';
        break;
    }
    return faStatus;
  }

  void statusMessage(context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: SizedBox(
              height: Dimensions.height * 0.18,
              child: Column(
                children: [
                  //title
                  Text(
                    'وضعیت انتشار',
                    style: TextStyle(
                      color: Colora.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.width * 0.05,
                    ),
                  ),

                  const Divider(color: Colora.primaryColor),

                  //description
                  Text(
                    'آیا می‌خواهید دفترکار مجازی شما منتشر شود و یا از حالت انتشار خارج شود ؟',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colora.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: Dimensions.width * 0.035,
                    ),
                  ),

                  SizedBox(height: Dimensions.height * 0.03),

                  //buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // publish
                      Container(
                        width: Dimensions.width * 0.22,
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: Colora.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'منتشر شود',
                            style: TextStyle(
                              color: Colora.scaffold,
                              fontSize: Dimensions.width * 0.033,
                            ),
                          ),
                        ),
                      ),

                      // later
                      Container(
                        width: Dimensions.width * 0.22,
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: Colora.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'بعدا',
                            style: TextStyle(
                              color: Colora.scaffold,
                              fontSize: Dimensions.width * 0.033,
                            ),
                          ),
                        ),
                      ),

                      // not publish
                      Container(
                        width: Dimensions.width * 0.22,
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: Colora.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'عدم انتشار',
                            style: TextStyle(
                              color: Colora.scaffold,
                              fontSize: Dimensions.width * 0.033,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IgnorePointer(
          ignoring: !widget.menuVisibility,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isMenuVisible = !isMenuVisible;
              });
              // widget.bloc.add(SelectMarket(marketId: widget.index));
            },
            child: Container(
              height: Dimensions.height * 0.14,
              width: Dimensions.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colora.lightBlue, // Change this to your primary color
              ),
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  //image
                  Container(
                    width: Dimensions.width * 0.25,
                    height: Dimensions.height * 0.2,
                    margin: EdgeInsets.symmetric(
                      vertical: Dimensions.height * 0.003,
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colora.scaffold,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child:
                              widget.market.logoImg.toString() != 'null'
                                  ? CachedNetworkImage(
                                    imageUrl: widget.market.logoImg.toString(),
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    placeholder:
                                        (context, url) => Shimmer.fromColors(
                                          baseColor: Colors.grey.withOpacity(
                                            0.2,
                                          ),
                                          highlightColor: Colors.black
                                              .withOpacity(0.2),
                                          direction: ShimmerDirection.rtl,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                    errorWidget:
                                        (context, url, error) =>
                                            const Icon(Icons.error),
                                  )
                                  : SvgPicture.asset(
                                    'assets/images/logo_svg.svg',
                                    colorFilter: const ColorFilter.mode(
                                      Colora.lightBlue,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: Dimensions.width * 0.02),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //title
                      SizedBox(
                        width: Dimensions.width * 0.65,
                        child: Text(
                          widget.market.name.toString(),
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: ATextStyle.lightBold15.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),

                      //divider
                      SizedBox(
                        width: Dimensions.width * 0.65,
                        child: const Divider(thickness: 1),
                      ),

                      SizedBox(
                        width: Dimensions.width * 0.65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //category
                            Text(
                              widget.market.subCategoryTitle.toString(),
                              overflow: TextOverflow.fade,
                              style: ATextStyle.light12.copyWith(
                                color: Colors.white,
                              ),
                            ),

                            //status
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width * 0.02,
                                vertical: Dimensions.height * 0.005,
                              ),
                              decoration: BoxDecoration(
                                color: Colora.appBarForgroundColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "وضعیت : ${shopStatus(widget.market.status!)}",
                                style: ATextStyle.light12.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: Dimensions.height * 0.01),

                      SizedBox(
                        width: Dimensions.width * 0.65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "تاریخ: ${widget.market.createdAt}",
                              style: ATextStyle.light12.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "شناسه: ${widget.market.businessId}",
                              style: ATextStyle.light12.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        //buttons
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return SizeTransition(sizeFactor: animation, child: child);
          },
          child:
              isMenuVisible
                  ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //preview
                          CustomButton(
                            width: 110,
                            onPress: () {
                              context.push(
                                AppRoutes.storeDetail,
                                extra: widget.market,
                              );
                            },
                            text: "پیش نمایش",
                          ),

                          //edit
                          CustomButton(
                            width: 110,
                            onPress: () {
                              context.push(
                                AppRoutes.marketPreview,
                                extra: widget.market,
                              );
                            },
                            text: "نمایش",
                          ),

                          //share
                          CustomButton(
                            width: 110,
                            onPress: () {
                              ShareStore.share(
                                widget.market.businessId.toString(),
                              );
                            },
                            text: "اشتراک گذاری",
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //publish
                          CustomButton(
                            width: 110,
                            onPress: () {
                              statusMessage(context);
                            },
                            text: "انتشار",
                          ),

                          // payment
                          CustomButton(
                            width: 110,
                            onPress: () {},
                            text: "پرداخت اشتراک",
                          ),

                          //deactivate
                          CustomButton(
                            width: 110,
                            onPress: () {},
                            text: "غیرفعال",
                          ),
                        ],
                      ),
                    ],
                  )
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
