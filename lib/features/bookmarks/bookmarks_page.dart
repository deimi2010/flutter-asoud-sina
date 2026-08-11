import 'dart:convert';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/secure_storage.dart';
import 'package:asood/core/models/market_model.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/core/widgets/store_card.dart';
import 'package:asood/features/vendor/presentation/bloc/workspace/workspace_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/endpoints.dart';

class MyBookmarks extends StatefulWidget {
  const MyBookmarks({super.key});

  @override
  State<MyBookmarks> createState() => _MyBookmarksState();
}

class _MyBookmarksState extends State<MyBookmarks> {
  List<MarketModel> bookmarks = [MarketModel()];

  void getUserBookMarks() async {
    bookmarks.clear();
    String url = '${Endpoints.baseUrl}user/market/bookmark/';
    String? token = await SecureStorage.readSecureStorage(Keys.token);
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );

    setState(() {
      if (jsonDecode(response.body)['data'].isEmpty) {
        bookmarks.add(
          MarketModel(
            id: 'nothing',
            businessId: 'nothing',
            name: 'nothing',
            logoImg: 'nothing',
          ),
        );
      } else {
        for (var market in jsonDecode(response.body)['data']) {
          bookmarks.add(
            MarketModel(
              id: market['id'],
              businessId: market['business_id'],
              name: market['name'],
              logoImg: market['logo_img'],
            ),
          );
        }
      }
    });
  }

  @override
  void initState() {
    getUserBookMarks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colora.primaryColor,
      child: SafeArea(
        child: Scaffold(
          // appBar: DefaultAppBar(context: context, title: 'لیست پیامک‌ها',),
          body: Stack(
            children: [
              bookmarks.isEmpty
                  ? Container()
                  : bookmarks[0].id == 'nothing'
                  ? Center(
                    child: Text(
                      'شما هیچ مارکتی را ذخیره نکرده اید',
                      style: TextStyle(
                        color: Colora.backgroundSwitch,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  : Padding(
                    padding: EdgeInsets.only(top: Dimensions.height * 0.12),
                    child: ListView.builder(
                      itemCount: bookmarks.length,
                      itemBuilder: (context, index) {
                        return bookmarks[index].id != 'nothing'
                            ? StoreCard(
                              bloc: BlocProvider.of<WorkspaceBloc>(context),
                              index: index,
                              market:
                                  BlocProvider.of<WorkspaceBloc>(
                                    context,
                                  ).state.storesList[index],
                            )
                            : Container();
                        // ? Container(
                        //   height: Dimensions.height * 0.14,
                        //   width: Dimensions.width,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(20),
                        //     color:
                        //         Colora
                        //             .lightBlue, // Change this to your primary color
                        //   ),
                        //   margin: const EdgeInsets.all(8.0),
                        //   padding: const EdgeInsets.all(5.0),
                        //   child: Row(
                        //     children: [
                        //       //image
                        //       Container(
                        //         width: Dimensions.width * 0.25,
                        //         height: Dimensions.height * 0.2,
                        //         margin: EdgeInsets.symmetric(
                        //           vertical: Dimensions.height * 0.003,
                        //         ),
                        //         child: AspectRatio(
                        //           aspectRatio: 1,
                        //           child: Container(
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(
                        //                 20,
                        //               ),
                        //               color: Colora.scaffold,
                        //             ),
                        //             child: ClipRRect(
                        //               borderRadius: BorderRadius.circular(
                        //                 20,
                        //               ),
                        //               child:
                        //                   bookmarks[index].logoImg
                        //                               .toString() !=
                        //                           'null'
                        //                       ? CachedNetworkImage(
                        //                         imageUrl:
                        //                             bookmarks[index].logoImg
                        //                                 .toString(),
                        //                         imageBuilder: (
                        //                           context,
                        //                           imageProvider,
                        //                         ) {
                        //                           return Container(
                        //                             decoration: BoxDecoration(
                        //                               image: DecorationImage(
                        //                                 image:
                        //                                     imageProvider,
                        //                                 fit: BoxFit.cover,
                        //                               ),
                        //                             ),
                        //                           );
                        //                         },
                        //                         placeholder:
                        //                             (
                        //                               context,
                        //                               url,
                        //                             ) => Shimmer.fromColors(
                        //                               baseColor: Colors.grey
                        //                                   .withOpacity(0.2),
                        //                               highlightColor: Colors
                        //                                   .black
                        //                                   .withOpacity(0.2),
                        //                               direction:
                        //                                   ShimmerDirection
                        //                                       .rtl,
                        //                               child: Container(
                        //                                 decoration:
                        //                                     BoxDecoration(
                        //                                       color:
                        //                                           Colors
                        //                                               .grey,
                        //                                       borderRadius:
                        //                                           BorderRadius.circular(
                        //                                             5,
                        //                                           ),
                        //                                     ),
                        //                               ),
                        //                             ),
                        //                         errorWidget:
                        //                             (context, url, error) =>
                        //                                 const Icon(
                        //                                   Icons.error,
                        //                                 ),
                        //                       )
                        //                       : SvgPicture.asset(
                        //                         'assets/images/logo_svg.svg',
                        //                         colorFilter:
                        //                             const ColorFilter.mode(
                        //                               Colora.lightBlue,
                        //                               BlendMode.srcIn,
                        //                             ),
                        //                       ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),

                        //       SizedBox(width: Dimensions.width * 0.02),

                        //       Column(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         crossAxisAlignment:
                        //             CrossAxisAlignment.start,
                        //         children: [
                        //           //title
                        //           SizedBox(
                        //             width: Dimensions.width * 0.65,
                        //             child: Text(
                        //               bookmarks[index].name.toString(),
                        //               maxLines: 1,
                        //               softWrap: true,
                        //               overflow: TextOverflow.fade,
                        //               style: ATextStyle.lightBold15
                        //                   .copyWith(color: Colors.white),
                        //             ),
                        //           ),

                        //           //divider
                        //           SizedBox(
                        //             width: Dimensions.width * 0.65,
                        //             child: const Divider(thickness: 1),
                        //           ),

                        //           SizedBox(
                        //             height: Dimensions.height * 0.05,
                        //           ),

                        //           SizedBox(
                        //             height: Dimensions.height * 0.01,
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // )
                        // : Container();
                      },
                    ),
                  ),

              const NewAppBar(title: 'لیست علاقه مندی ها'),
            ],
          ),
          // bottomNavigationBar: const SimpleBotNavBar(),
        ),
      ),
    );
  }
}
