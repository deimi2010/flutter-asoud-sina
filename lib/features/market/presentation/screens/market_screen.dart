import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/snack_bar_util.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/core/router/app_routers.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/core/widgets/order_card_widget.dart';
import 'package:asood/core/widgets/store_card.dart';
import 'package:asood/features/vendor/presentation/bloc/workspace/workspace_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

/// این صفحه برای نمایش تمام فروشگاه های کاربر است
class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen>
    with SingleTickerProviderStateMixin {
  late WorkspaceBloc bloc;

  bool switchValue = false;
  late TabController _tabController;
  int activeTabIndex = 0;
  bool isMenuVisible = false;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<WorkspaceBloc>(context);
    // Dispatch the event when the screen is opened
    bloc.add(LoadStores());
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() async {
    setState(() {
      activeTabIndex = _tabController.index;
    });

    // bloc.add(ChangeTabView(activeTabIndex: activeTabIndex));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: BlocConsumer<WorkspaceBloc, WorkspaceState>(
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
          return Container(
            color: Colora.primaryColor,
            child: SafeArea(
              child: Scaffold(
                body: Stack(
                  children: [
                    SizedBox(
                      height: Dimensions.height,
                      width: Dimensions.width,
                      child:
                          state.status == CWSStatus.loading
                              ? Column(
                                children: [
                                  SizedBox(height: Dimensions.height * 0.11),
                                  ListView.builder(
                                    itemCount: 5,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (context, index) => Container(
                                          height: Dimensions.height * 0.14,
                                          width: Dimensions.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            color: Colora.lightBlue.withOpacity(
                                              0.3,
                                            ),
                                          ),
                                          margin: const EdgeInsets.all(8.0),
                                          child: Shimmer.fromColors(
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
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                        ),
                                  ),
                                ],
                              )
                              : state.status == CWSStatus.failure
                              ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'مشکلی در بارگذاری پیش آمده , مجدد تلاش کنید!',
                                    style: TextStyle(
                                      color: Colora.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.width * 0.04,
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.height * 0.05),
                                  ElevatedButton(
                                    onPressed: () {
                                      bloc.add(LoadStores());
                                    },
                                    child: const Text('تلاش مجدد'),
                                  ),
                                ],
                              )
                              : Column(
                                children: [
                                  SizedBox(height: Dimensions.height * 0.11),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: state.storesList.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index >= state.storesList.length) {
                                          return SizedBox(
                                            height: Dimensions.height * 0.2,
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                8,
                                              ),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: FloatingActionButton(
                                                  onPressed: () {
                                                    context.push(
                                                      AppRoutes.createWorkSpace,
                                                    );
                                                  },
                                                  backgroundColor:
                                                      Colora.primaryColor,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colora.scaffold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return StoreCard(
                                            index: index,
                                            market: state.storesList[index],
                                            bloc: bloc,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                    ),

                    const NewAppBar(title: 'لیست فروشگاه‌های من‌'),

                    // invoice
                    if (state.showInvoice == true) ...[invoice(bloc, state)],

                    if (state.invoiceConfirm == true) ...[confirmInvoice(bloc)],

                    //header buttons
                    // Positioned(
                    //   top: Dimensions.height * 0.08,
                    //   width: Dimensions.width,
                    //   height: Dimensions.height * 0.05,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //
                    //       //add new shop
                    //       Container(
                    //         width: Dimensions.width * 0.35,
                    //         height: Dimensions.height * 0.05,
                    //         decoration: BoxDecoration(
                    //           color: Colora.primaryColor,
                    //           borderRadius: BorderRadius.circular(20),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.grey.withOpacity(0.4),
                    //               spreadRadius: 3,
                    //               blurRadius: 5,
                    //               offset: const Offset(0, 5)
                    //             )
                    //           ]
                    //         ),
                    //         alignment: AlignmentDirectional.center,
                    //         child: const Text(
                    //           'ثبت فروشگاه جدید',
                    //           style: TextStyle(
                    //             color: Colora.scaffold,
                    //           ),
                    //         ),
                    //       ),
                    //
                    //       SizedBox(
                    //         width: Dimensions.width * 0.05,
                    //       ),
                    //
                    //       //shop reports
                    //       Container(
                    //         width: Dimensions.width * 0.35,
                    //         height: Dimensions.height * 0.05,
                    //         decoration: BoxDecoration(
                    //             color: Colora.primaryColor,
                    //             borderRadius: BorderRadius.circular(20),
                    //             boxShadow: [
                    //               BoxShadow(
                    //                   color: Colors.grey.withOpacity(0.4),
                    //                   spreadRadius: 3,
                    //                   blurRadius: 5,
                    //                   offset: const Offset(0, 5)
                    //               )
                    //             ]
                    //         ),
                    //         alignment: AlignmentDirectional.center,
                    //         child: const Text(
                    //           'گزارشات فروشگاه',
                    //           style: TextStyle(
                    //             color: Colora.scaffold,
                    //           ),
                    //         ),
                    //       ),
                    //
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTabOrderList(WorkspaceBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colora.primaryColor,
          ),
          child: const Text(
            "لیست فروشگاه‌های احمدی",
            style: TextStyle(color: Colors.white),
          ),
        ),
        // const SizedBox(
        //   height: 5,
        // ),
        // const Divider(
        //   thickness: 1,
        // ),
        const SizedBox(height: 5),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return OrderCard(index: index, bloc: bloc);
            },
          ),
        ),
      ],
    );
  }

  Widget invoice(WorkspaceBloc bloc, WorkspaceState state) {
    return Container(
      width: Dimensions.width,
      height: Dimensions.height,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width * 0.05,
        vertical: Dimensions.height * 0.05,
      ),
      color: Colora.primaryColor.withOpacity(0.6),
      child: Container(
        decoration: BoxDecoration(
          color: Colora.scaffold,
          borderRadius: BorderRadius.circular(26),
        ),
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.height * 0.02,
          horizontal: Dimensions.width * 0.03,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //header
              Container(
                height: Dimensions.height * 0.06,
                margin: EdgeInsets.only(bottom: Dimensions.height * 0.01),
                decoration: BoxDecoration(
                  color: Colora.primaryColor,
                  borderRadius: BorderRadius.circular(26),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'درخواست شماره ۹۱ - نقدی',
                  style: TextStyle(color: Colora.scaffold, fontSize: 17),
                ),
              ),

              //name
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height * 0.01,
                ),
                child: const Text(
                  'گیرنده : محمد رضا محمدی',
                  style: TextStyle(color: Colora.primaryColor, fontSize: 16),
                ),
              ),

              //phone
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height * 0.01,
                ),
                child: const Text(
                  'شماره موبایل : ۰۹۱۲۳۹۳۱۷۷۴',
                  style: TextStyle(color: Colora.primaryColor, fontSize: 16),
                ),
              ),

              //address
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height * 0.01,
                ),
                child: const Text(
                  'آدرس : تهران ، احمد آباد',
                  style: TextStyle(color: Colora.primaryColor, fontSize: 16),
                ),
              ),

              //invoice
              Container(
                decoration: BoxDecoration(
                  color: Colora.scaffold_,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  children: [
                    Container(
                      height: Dimensions.height * 0.06,
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width * 0.03,
                      ),
                      decoration: BoxDecoration(
                        color: Colora.primaryColor,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'نام کالا',
                            style: TextStyle(
                              color: Colora.scaffold,
                              fontSize: 14,
                            ),
                          ),
                          VerticalDivider(
                            color: Colora.scaffold_,
                            endIndent: 10,
                            indent: 10,
                            thickness: 2,
                          ),
                          Text(
                            'تعداد',
                            style: TextStyle(
                              color: Colora.scaffold,
                              fontSize: 14,
                            ),
                          ),
                          VerticalDivider(
                            color: Colora.scaffold_,
                            endIndent: 10,
                            indent: 10,
                            thickness: 2,
                          ),
                          Text(
                            'قیمت',
                            style: TextStyle(
                              color: Colora.scaffold,
                              fontSize: 14,
                            ),
                          ),
                          VerticalDivider(
                            color: Colora.scaffold_,
                            endIndent: 10,
                            indent: 10,
                            thickness: 2,
                          ),
                          Text(
                            'میلغ کل',
                            style: TextStyle(
                              color: Colora.scaffold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: Dimensions.height * 0.06,
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'تعمیر دریل',
                            style: TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '1',
                            style: TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '۲۰۰.۰۰۰',
                            style: TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '200.000',
                            style: TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(
                      color: Colora.primaryColor,
                      indent: 10,
                      endIndent: 10,
                    ),

                    //price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height * 0.01,
                          ),
                          child: const Text(
                            'مبلغ کل       :   ',
                            style: TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height * 0.01,
                          ),
                          child: const Text(
                            '۲۰۰.۰۰۰ تومان',
                            style: TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    //discount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height * 0.01,
                          ),
                          child: const Text(
                            'مبلغ تخفیف :   ',
                            style: TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height * 0.01,
                          ),
                          child: const Text(
                            '۲۰۰.۰۰۰ تومان',
                            style: TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // post price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height * 0.01,
                          ),
                          child: const Text(
                            'هزینه کرایه   :   ',
                            style: TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height * 0.01,
                          ),
                          child: const Text(
                            '۲۰۰.۰۰۰ تومان',
                            style: TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    //total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height * 0.01,
                          ),
                          child: const Text(
                            'مبلغ نهایی    :   ',
                            style: TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height * 0.01,
                          ),
                          child: const Text(
                            '۲۰۰.۰۰۰ تومان',
                            style: TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //gift text
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height * 0.01,
                  ),
                  child: const Text(
                    '// هدیه : تعمیر دریل',
                    style: TextStyle(color: Colora.primaryColor, fontSize: 11),
                  ),
                ),
              ),

              //payment method
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.width * 0.05,
                ),
                decoration: BoxDecoration(
                  color: Colora.scaffold_,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: Dimensions.height * 0.01,
                        horizontal: Dimensions.width * 0.05,
                      ),
                      decoration: BoxDecoration(
                        color: Colora.primaryColor,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              'تحویل خریدار',
                              style: TextStyle(
                                color: Colora.scaffold,
                                fontSize: Dimensions.width * 0.03,
                              ),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              controlAffinity: ListTileControlAffinity.trailing,
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              fillColor: WidgetStateProperty.all(
                                Colora.scaffold,
                              ),
                              value: 1,
                              groupValue: state.invoiceOption,
                              onChanged: (value) {
                                bloc.add(InvoiceOption(option: value!));
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              'تحویل پیک',
                              style: TextStyle(
                                color: Colora.scaffold,
                                fontSize: Dimensions.width * 0.03,
                              ),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              controlAffinity: ListTileControlAffinity.trailing,

                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              fillColor: WidgetStateProperty.all(
                                Colora.scaffold,
                              ),

                              value: 2, // Assign a value of 1 to this option
                              groupValue: state.invoiceOption,
                              onChanged: (value) {
                                bloc.add(InvoiceOption(option: value!));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state.invoiceOption == 1 ||
                        state.invoiceOption == 2) ...[
                      //name
                      Container(
                        height: Dimensions.height * 0.07,
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width * 0.04,
                          vertical: Dimensions.height * 0.01,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: Colora.scaffold,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                              borderSide: const BorderSide(
                                color: Colora.primaryColor,
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                              borderSide: const BorderSide(
                                color: Colora.primaryColor,
                                width: 2,
                              ),
                            ),
                            hintText: 'مشخصات :',
                            hintStyle: const TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),

                      //phone
                      if (state.invoiceOption == 2) ...[
                        Container(
                          height: Dimensions.height * 0.07,
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width * 0.04,
                            vertical: Dimensions.height * 0.01,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colora.scaffold,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(26),
                                borderSide: const BorderSide(
                                  color: Colora.primaryColor,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(26),
                                borderSide: const BorderSide(
                                  color: Colora.primaryColor,
                                  width: 2,
                                ),
                              ),
                              hintText: 'تلفن :',
                              hintStyle: const TextStyle(
                                color: Colora.primaryColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],

                      //description
                      Container(
                        height: Dimensions.height * 0.07,
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width * 0.04,
                          vertical: Dimensions.height * 0.01,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: Colora.scaffold,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                              borderSide: const BorderSide(
                                color: Colora.primaryColor,
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                              borderSide: const BorderSide(
                                color: Colora.primaryColor,
                                width: 2,
                              ),
                            ),
                            hintText: 'توضیحات :',
                            hintStyle: const TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(
                height:
                    state.invoiceOption == 1 || state.invoiceOption == 2
                        ? Dimensions.height * 0.04
                        : Dimensions.height * 0.18,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //cancel
                  Container(
                    // width: Dimensions.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colora.lightBlue,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        bloc.add(const ShowInvoice(isShow: false));
                      },
                      child: const Text(
                        'لغو',
                        style: TextStyle(
                          color: Colora.scaffold_,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  //cancel
                  Container(
                    // width: Dimensions.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colora.lightBlue,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        bloc.add(const ShowInvoice(isShow: false));
                      },
                      child: const Text(
                        'انصراف',
                        style: TextStyle(
                          color: Colora.scaffold_,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  //confirm
                  Container(
                    // width: Dimensions.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colora.lightBlue,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        bloc.add(const InvoiceConfirm(isConfirm: true));
                      },
                      child: const Text(
                        'تایید',
                        style: TextStyle(
                          color: Colora.scaffold_,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
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

  Widget confirmInvoice(WorkspaceBloc bloc) {
    return Container(
      width: Dimensions.width,
      height: Dimensions.height,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width * 0.05,
        vertical: Dimensions.height * 0.33,
      ),
      color: Colora.primaryColor.withOpacity(0.7),
      child: Container(
        decoration: BoxDecoration(
          color: Colora.scaffold,
          borderRadius: BorderRadius.circular(26),
        ),
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.height * 0.02,
          horizontal: Dimensions.width * 0.03,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'تایید دریافت وجه',
              style: TextStyle(
                color: Colora.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const Divider(color: Colora.primaryColor, thickness: 2),
            const Text(
              'فروشنده محترم آیا وجه سفارش را کامل دریافت نموده‌اید ؟',
              textAlign: TextAlign.justify,
              style: TextStyle(
                height: 1.5,
                color: Colora.primaryColor,
                fontSize: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(top: Dimensions.height * 0.02),
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width * 0.04,
                  ),
                  decoration: BoxDecoration(
                    color: Colora.primaryColor,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      bloc.add(const InvoiceConfirm(isConfirm: false));
                    },
                    child: Text(
                      'بازگشت',
                      style: TextStyle(
                        color: Colora.scaffold,
                        fontSize: Dimensions.width * 0.05,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Dimensions.height * 0.02),
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width * 0.04,
                  ),
                  decoration: BoxDecoration(
                    color: Colora.primaryColor,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      bloc.add(const InvoiceConfirm(isConfirm: false));
                      bloc.add(const ShowInvoice(isShow: false));
                    },
                    child: Text(
                      'بله',
                      style: TextStyle(
                        color: Colora.scaffold,
                        fontSize: Dimensions.width * 0.05,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
