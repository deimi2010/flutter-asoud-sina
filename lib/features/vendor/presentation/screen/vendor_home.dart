import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/snack_bar_util.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/core/router/app_routers.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/features/vendor/presentation/bloc/workspace/workspace_bloc.dart';
import 'package:asood/features/vendor/presentation/widgets/dashboard_carousel.dart';
import 'package:asood/features/vendor/presentation/widgets/item_box_with_title.dart';
import 'package:asood/features/vendor/presentation/widgets/simple_itembox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

Map dummyData = {
  "firstMenu": [
    {
      "title": "میز کار",
      "image": const Icon(
        Icons.work_rounded,
        // Icons.share,
        size: 60,
        color: Colors.white,
      ),
      "page": AppRoutes.createWorkSpace,
    },
    {
      "title": "سود با آسود",
      "image": const Icon(
        Icons.attach_money_rounded,
        // Icons.share,
        size: 60,
        color: Colors.white,
      ),
    },
    {
      "title": "کارت ویزیت",
      "image": const Icon(
        Icons.card_membership_rounded,
        // Icons.share,
        size: 60,
        color: Colors.white,
      ),
      "page": AppRoutes.business,
    },
    {
      "title": "استعلام بها",
      "image": const Icon(
        Icons.price_change_rounded,
        // Icons.share,
        size: 60,
        color: Colors.white,
      ),
      "page": AppRoutes.inquiryRequests,
    },
    // {"title": "استعلام بها", "image": Container(), "page": AppRoutes.markets},
    {
      "title": "ثبت آگهی",
      "image": const Icon(
        Icons.ads_click_rounded,
        // Icons.share,
        size: 60,
        color: Colors.white,
      ),
    },
    {
      "title": "بازاریاب",
      "image": const Icon(
        Icons.person_rounded,
        // Icons.share,
        size: 60,
        color: Colors.white,
      ),
    },
  ],
  "secondMenu": [
    {
      "title": "امور مالی",
      "image": const Icon(
        Iconsax.bank,
        // Icons.share,
        size: 60,
        color: Colors.white,
      ),
      "page": AppRoutes.finance,
    },
    {
      "title": "رهیابی خرید",
      "image": const Icon(
        Iconsax.buy_crypto5,
        // Icons.share,
        size: 60,
        color: Colors.white,
      ),
      "page": AppRoutes.customerDashboard,
    },
    {
      "title": "رهیابی فروش",
      "image": const Icon(
        Icons.sell,
        // Icons.share,
        size: 60,
        color: Colors.white,
      ),
      "page": AppRoutes.vendorDashboard,
    },
    {
      "title": "اشتراک گذاری",
      "image": const Icon(
        Iconsax.share5,
        // Icons.share,
        size: 60,
        color: Colors.white,
      ),
      // "page": AppRoutes.product,
    },
    {
      "title": "پیام کوتاه",
      "image": const Icon(
        Iconsax.message5,
        // Icons.share,
        size: 60,
        color: Colors.white,
      ),
      "page": AppRoutes.panelInbox,
    },
    {
      "title": "علاقه مندی",
      "image": const Icon(
        Iconsax.heart5,
        // Icons.share,
        size: 60,
        color: Colors.white,
      ),
      "page": AppRoutes.bookmarks,
    },
    {
      "title": "راهنما",
      "image": const Icon(
        Iconsax.info_circle5,
        // Icons.share,
        size: 60,
        color: Colors.white,
      ),
    },
    {
      "title": "پشتیبانی",
      "image": const Icon(
        Iconsax.personalcard5,
        // Icons.share,
        size: 60,
        color: Colors.white,
      ),
    },
    //settings
    {
      "title": "تنظیمات",
      "image": const Icon(
        Iconsax.setting,
        // Icons.share,
        size: 60,
        color: Colors.white,
      ),
      // "page": const SettingsPageScreen(),
    },
  ],
};

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({super.key});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen>
    with SingleTickerProviderStateMixin {
  late WorkspaceBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = BlocProvider.of<WorkspaceBloc>(context);
    // Dispatch the event when the screen is opened
    bloc.add(LoadStores());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colora.primaryColor,
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          // appBar: DefaultAppBar(context: context, title: 'home',),
          body: Stack(
            children: [
              //main items
              SizedBox(
                height: Dimensions.height,
                width: Dimensions.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Main column with carousel and grids
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          // margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.only(top: Dimensions.seven),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          // width: MediaQuery.of(context).size.width * 0.90,
                          child: Column(
                            children: [
                              //for appbar
                              SizedBox(height: Dimensions.height * 0.12),

                              // Dotted Carousel with 20% height
                              const DashboardCarouselWidget(),

                              // Grid with 25% height, 2 rows, and 3 columns
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.khorisontal,
                                ),
                                child: DashboardServicesWidget(),
                              ),

                              // Grid with 35% height, 3 rows, and 3 columns
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.khorisontal,
                                ),
                                child: DashboardAdditionalWidget(),
                              ),

                              SizedBox(height: Dimensions.height * 0.15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //appbar
              const NewAppBar(title: 'home'),
            ],
          ),
          bottomNavigationBar: Stack(
            children: [
              CustomPaint(
                size: Size(Dimensions.width, Dimensions.height * 0.15),
                // size: const Size(400, 90),
                painter: CurvedPainter(),
              ),

              // Icons Part:
              SizedBox(
                height: Dimensions.height * 0.11,
                width: Dimensions.width,
                // color: Colors.red,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Dimensions.width * 0.05),
                        child: InkWell(
                          onTap: () => context.push(AppRoutes.vendorProfile),
                          child: Container(
                            width: Dimensions.width * 0.15,
                            height: Dimensions.width * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: Colora.primaryColor,
                              border: Border.all(
                                color: Colora.scaffold,
                                width: 6,
                              ),
                            ),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: Center(
                                child: Icon(
                                  Iconsax.personalcard,
                                  color: Colora.scaffold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Dimensions.width * 0.025),
                        child: InkWell(
                          onTap: () => context.push(AppRoutes.shoppingCart),
                          child: Container(
                            width: Dimensions.width * 0.175,
                            height: Dimensions.width * 0.175,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: Colora.primaryColor,
                              border: Border.all(
                                color: Colora.scaffold,
                                width: 6,
                              ),
                            ),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: Center(
                                child: Icon(
                                  Iconsax.shopping_bag,
                                  color: Colora.scaffold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: Dimensions.width * 0.2,
                        height: Dimensions.width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colora.primaryColor,
                          border: Border.all(color: Colora.scaffold, width: 6),
                        ),
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Center(
                            child: Icon(Iconsax.home, color: Colora.scaffold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Dimensions.width * 0.025),
                        child: Container(
                          width: Dimensions.width * 0.175,
                          height: Dimensions.width * 0.175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            color: Colora.primaryColor,
                            border: Border.all(
                              color: Colora.scaffold,
                              width: 6,
                            ),
                          ),
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Center(
                              child: Icon(
                                Iconsax.profile_2user,
                                color: Colora.scaffold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Dimensions.width * 0.05),
                        child: InkWell(
                          onTap: () => context.push(AppRoutes.business),
                          child: Container(
                            width: Dimensions.width * 0.15,
                            height: Dimensions.width * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: Colora.primaryColor,
                              border: Border.all(
                                color: Colora.scaffold,
                                width: 6,
                              ),
                            ),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: Center(
                                child: Icon(
                                  Icons.business_rounded,
                                  color: Colora.scaffold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Positioned(
                bottom: 0,
                width: Dimensions.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Dimensions.width * 0.05),
                      child: InkWell(
                        onTap: () => context.push(AppRoutes.vendorProfile),
                        child: SizedBox(
                          width: Dimensions.width * 0.15,
                          height: Dimensions.width * 0.15,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Center(
                              child: Text(
                                'پرفایل',
                                style: TextStyle(
                                  color: Colora.scaffold,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Dimensions.width * 0.025),
                      child: InkWell(
                        onTap: () => context.push(AppRoutes.shoppingCart),
                        child: SizedBox(
                          width: Dimensions.width * 0.175,
                          height: Dimensions.width * 0.175,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Center(
                              child: Text(
                                'سبد',
                                style: TextStyle(
                                  color: Colora.scaffold,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width * 0.2,
                      height: Dimensions.width * 0.2,
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: Text(
                            'خانه',
                            style: TextStyle(
                              color: Colora.scaffold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Dimensions.width * 0.025),
                      child: SizedBox(
                        width: Dimensions.width * 0.175,
                        height: Dimensions.width * 0.175,
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Center(
                            child: Text(
                              'اشتراک',
                              style: TextStyle(
                                color: Colora.scaffold,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Dimensions.width * 0.05),
                      child: InkWell(
                        onTap: () => context.push(AppRoutes.business),
                        child: SizedBox(
                          width: Dimensions.width * 0.15,
                          height: Dimensions.width * 0.15,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Center(
                              child: Text(
                                'ویزیت',
                                style: TextStyle(
                                  color: Colora.scaffold,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.only(
                //         bottom: Dimensions.height * 0.01,
                //       ),
                //       child: const Text(
                //         'خانه',
                //         style: TextStyle(
                //           color: Colora.scaffold,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ),
              // Positioned(
              //   bottom: 0,
              //   width: Dimensions.width,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       // SizedBox(
              //       //   height: Dimensions.height * 0.15,
              //       //   width: Dimensions.width * 0.15,
              //       //   child: Padding(
              //       //     padding: EdgeInsets.only(
              //       //       bottom: Dimensions.height * 0.07,
              //       //     ),
              //       //     // padding: EdgeInsets.only(bottom: 70),
              //       //     child: Center(
              //       //       child: Icon(
              //       //         Icons.home_rounded,
              //       //         color: Colors.white,
              //       //         size: 30,
              //       //       ),
              //       //     ),
              //       //   ),
              //       // ),
              //     ],
              //   ),
              // ),
              // Positioned(
              //     bottom: Dimensions.height * .029,
              //     left: Dimensions.width * .12,
              //     child: const Icon(
              //       Icons.tab,
              //       color: Colors.white,
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}

//------------------------------------------------------

class DashboardAdditionalWidget extends StatelessWidget {
  const DashboardAdditionalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: Deco.kshadow,
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: Dimensions.height * 0.46,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            //title
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  "امکانات:",
                  style: ATextStyle.lightBlue16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            //items
            SizedBox(
              height: Dimensions.height * .45,
              width: Dimensions.width * .7,

              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                shrinkWrap: true,
                cacheExtent: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  ...List.generate(
                    dummyData["secondMenu"].length,
                    (index) => FittedBox(
                      child: ItemBoxTitle(
                        onTap: () {
                          if (index == 3) {
                            launchUrl(Uri.parse('https://asoud.ir/'));
                          } else {
                            context.push(
                              dummyData["secondMenu"][index]["page"],
                            );
                          }
                        },
                        title: dummyData["secondMenu"][index]["title"],
                        child: dummyData["secondMenu"][index]["image"],
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
  }
}

class DashboardServicesWidget extends StatelessWidget {
  const DashboardServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: Deco.kshadow,
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: MediaQuery.of(context).size.height * 0.41,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            //title
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  "کسب وکار:",
                  style: ATextStyle.lightBlue16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            BlocConsumer<WorkspaceBloc, WorkspaceState>(
              listener: (context, state) {
                // _tabController.index = state.activeTabIndex;
                // _tabController.index > state.activeTabIndex
                //   ? _tabController.index = state.activeTabIndex
                //   : null;
                // if (state.status == WorkspaceStatus.success) {
                //   _tabController.index = state.activeTabIndex;
                // }
                if (state.status == CWSStatus.failure) {
                  showSnackBar(
                    context,
                    "مشکلی در بارگذاری پیش آمده , مجدد تلاش کنید!",
                  );
                }
              },
              builder: (context, state) {
                return SizedBox(
                  height: Dimensions.height * .4,
                  width: Dimensions.width * .8,
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    cacheExtent: 2,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 15,
                    children: [
                      ...List.generate(
                        dummyData["firstMenu"].length,
                        (index) => SimpleItemBox(
                          onTap: () {
                            // this code is for decide about see stores or create
                            if (index == 0) {
                              if (state.storesList.isEmpty) {
                                context.push(AppRoutes.createWorkSpace);
                              } else {
                                context.push(AppRoutes.markets);
                              }
                            } else {
                              context.push(
                                dummyData["firstMenu"][index]["page"],
                              );
                            }
                          },
                          title: dummyData["firstMenu"][index]["title"],
                          child: dummyData["firstMenu"][index]["image"],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
