import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';

import 'package:asood/core/widgets/order_card_widget.dart';

import 'package:flutter/material.dart';

class VendorDashboardScreen extends StatefulWidget {
  const VendorDashboardScreen({super.key});

  @override
  State<VendorDashboardScreen> createState() => _VendorDashboardScreenState();
}

class _VendorDashboardScreenState extends State<VendorDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _activeTabIndex; // To keep track of the active tab
  bool isStoreMenuVisible = false;
  bool isOrderMenuVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    _activeTabIndex = _tabController.index; // Set initial active tab index
  }

  void _onTabChanged() {
    setState(() {
      _activeTabIndex = _tabController.index; // Update the active tab index
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colora.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Dimensions.height * 0.11),

                    // tab bar
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: null,
                        indicatorPadding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.label,

                        padding: EdgeInsets.zero,
                        dividerHeight: 0,
                        isScrollable: false,

                        indicatorColor:
                            Colors.transparent, // Remove indicator color
                        tabs: [
                          buildTab('لیست فروشگاه‌ها', 0),
                          buildTab('درخواست جدید', 1),
                          buildTab('آمار و خرید', 2),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: Dimensions.height * .795,
                      child: TabBarView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          // buildTabStoreList(state),
                          buildTabStoreList(),

                          // buildTabOrderList(bloc),
                          buildTabOrderList(),

                          Container(
                            width: Dimensions.width,
                            height: Dimensions.height,
                            color: Colors.greenAccent,
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   width: Dimensions.width,
                    //   margin: const EdgeInsets.only(
                    //     top: 10.0,
                    //     bottom: 10.0,
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       Container(
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(50),
                    //         ),
                    //         child: TabBar(
                    //           controller: _tabController,
                    //           indicator: null,
                    //           indicatorColor: Colors.transparent, // Remove indicator color
                    //           tabs: [
                    //             buildTab('لیست فروشگاه‌ها', 0),
                    //             buildTab('درخواست جدید', 1),
                    //             buildTab('آمار و خرید', 2),
                    //           ],
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: TabBarView(
                    //           controller: _tabController,
                    //           children: [
                    //             // Content of Tab 1
                    //             buildTabStoreList(),
                    //
                    //             // Content of Tab 2
                    //             buildTabOrderList(),
                    //
                    //             // Content of Tab 3
                    //             buildTabStatList(),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),

              const NewAppBar(title: 'رهیابی فروش‌'),

              // invoice
              // if(state.showInvoice == true)...[
              //   invoice(bloc, state)
              // ],
              //
              // if(state.invoiceConfirm == true)...[
              //   confirmInvoice(bloc)
              // ]
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTab(String label, int tabIndex) {
    bool isActive = _activeTabIndex == tabIndex; // Check if tab is active
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 7.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: Dimensions.width,
      decoration: BoxDecoration(
        color: isActive ? Colora.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colora.primaryColor, width: 2),
      ),
      child: Align(
        alignment: Alignment.center,
        child: FittedBox(
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colora.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  // Widget buildTabStoreList(WorkspaceState state) {
  //   return ListView.builder(
  //     itemCount: state.storesList.length,
  //     shrinkWrap: true,
  //     itemBuilder: (context, index) {
  //       return StoreCard(
  //         index: index,
  //         market: state.storesList[index],
  //         bloc: bloc,
  //       );
  //     },
  //   );
  // }

  Widget buildTabStoreList() {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          width: Dimensions.width,
          height: Dimensions.height * 0.1,
          margin: EdgeInsets.symmetric(vertical: Dimensions.height * 0.01),
          color: Colors.red,
        ); /* StoreCard(
          index: index,
          menuVisibility: true,
        ); */
      },
    );
  }

  // Widget buildTabOrderList(WorkspaceBloc bloc) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: [
  //       Container(
  //         width: double.infinity,
  //         padding: const EdgeInsets.all(10),
  //         margin: const EdgeInsets.all(10),
  //         alignment: Alignment.center,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20),
  //           color: Colora.primaryColor,
  //         ),
  //         child: const Text(
  //           "لیست فروشگاه‌های احمدی",
  //           style: TextStyle(
  //             color: Colors.white,
  //           ),
  //         ),
  //       ),
  //       // const SizedBox(
  //       //   height: 5,
  //       // ),
  //       // const Divider(
  //       //   thickness: 1,
  //       // ),
  //       const SizedBox(
  //         height: 5,
  //       ),
  //       Expanded(
  //         child: ListView.builder(
  //           itemCount: 10,
  //           itemBuilder: (context, index) {
  //             return OrderCard(index: index, bloc: bloc,);
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget buildTabOrderList() {
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
        const SizedBox(height: 5),
        const Divider(thickness: 1),
        const SizedBox(height: 5),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return OrderCard(index: index);
            },
          ),
        ),
      ],
    );
  }

  Widget buildTabStatList() {
    return ListView(
      children: List.generate(
        10,
        (index) => ListTile(title: Text('آمار و خرید Item $index')),
      ),
    );
  }

  // Widget invoice(WorkspaceBloc bloc, WorkspaceState state) {
  //   return Container(
  //     width: Dimensions.width,
  //     height: Dimensions.height,
  //     padding: EdgeInsets.symmetric(
  //         horizontal: Dimensions.width * 0.05,
  //         vertical: Dimensions.height * 0.05
  //     ),
  //     color: Colora.primaryColor.withOpacity(0.6),
  //     child: Container(
  //       decoration: BoxDecoration(
  //           color: Colora.scaffold,
  //           borderRadius: BorderRadius.circular(26)
  //       ),
  //       padding: EdgeInsets.symmetric(
  //           vertical: Dimensions.height * 0.02,
  //           horizontal: Dimensions.width * 0.03
  //       ),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //
  //             //header
  //             Container(
  //               height: Dimensions.height * 0.06,
  //               margin: EdgeInsets.only(
  //                   bottom: Dimensions.height * 0.01
  //               ),
  //               decoration: BoxDecoration(
  //                   color: Colora.primaryColor,
  //                   borderRadius: BorderRadius.circular(26)
  //               ),
  //               alignment: Alignment.center,
  //               child: const Text(
  //                 'درخواست شماره ۹۱ - نقدی',
  //                 style: TextStyle(
  //                     color: Colora.scaffold,
  //                     fontSize: 17
  //                 ),
  //               ),
  //             ),
  //
  //             //name
  //             Padding(
  //               padding: EdgeInsets.symmetric(
  //                   vertical: Dimensions.height * 0.01
  //               ),
  //               child: const Text(
  //                 'گیرنده : محمد رضا محمدی',
  //                 style: TextStyle(
  //                     color: Colora.primaryColor,
  //                     fontSize: 16
  //                 ),
  //               ),
  //             ),
  //
  //             //phone
  //             Padding(
  //               padding: EdgeInsets.symmetric(
  //                   vertical: Dimensions.height * 0.01
  //               ),
  //               child: const Text(
  //                 'شماره موبایل : ۰۹۱۲۳۹۳۱۷۷۴',
  //                 style: TextStyle(
  //                     color: Colora.primaryColor,
  //                     fontSize: 16
  //                 ),
  //               ),
  //             ),
  //
  //             //address
  //             Padding(
  //               padding: EdgeInsets.symmetric(
  //                   vertical: Dimensions.height * 0.01
  //               ),
  //               child: const Text(
  //                 'آدرس : تهران ، احمد آباد',
  //                 style: TextStyle(
  //                     color: Colora.primaryColor,
  //                     fontSize: 16
  //                 ),
  //               ),
  //             ),
  //
  //             //invoice
  //             Container(
  //               decoration: BoxDecoration(
  //                   color: Colora.scaffold_,
  //                   borderRadius: BorderRadius.circular(26)
  //               ),
  //               child: Column(
  //                 children: [
  //
  //                   Container(
  //                     height: Dimensions.height * 0.06,
  //                     padding: EdgeInsets.symmetric(
  //                         horizontal: Dimensions.width * 0.03
  //                     ),
  //                     decoration: BoxDecoration(
  //                         color: Colora.primaryColor,
  //                         borderRadius: BorderRadius.circular(26)
  //                     ),
  //                     alignment: Alignment.center,
  //                     child: const Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       children: [
  //                         Text(
  //                           'نام کالا',
  //                           style: TextStyle(
  //                               color: Colora.scaffold,
  //                               fontSize: 14
  //                           ),
  //                         ),
  //                         VerticalDivider(
  //                           color: Colora.scaffold_,
  //                           endIndent: 10,
  //                           indent: 10,
  //                           thickness: 2,
  //                         ),
  //                         Text(
  //                           'تعداد',
  //                           style: TextStyle(
  //                               color: Colora.scaffold,
  //                               fontSize: 14
  //                           ),
  //                         ),
  //                         VerticalDivider(
  //                           color: Colora.scaffold_,
  //                           endIndent: 10,
  //                           indent: 10,
  //                           thickness: 2,
  //                         ),
  //                         Text(
  //                           'قیمت',
  //                           style: TextStyle(
  //                               color: Colora.scaffold,
  //                               fontSize: 14
  //                           ),
  //                         ),
  //                         VerticalDivider(
  //                           color: Colora.scaffold_,
  //                           endIndent: 10,
  //                           indent: 10,
  //                           thickness: 2,
  //                         ),
  //                         Text(
  //                           'میلغ کل',
  //                           style: TextStyle(
  //                               color: Colora.scaffold,
  //                               fontSize: 14
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //
  //                   Container(
  //                     height: Dimensions.height * 0.06,
  //                     alignment: Alignment.center,
  //                     child: const Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       children: [
  //                         Text(
  //                           'تعمیر دریل',
  //                           style: TextStyle(
  //                               color: Colora.primaryColor,
  //                               fontSize: 14
  //                           ),
  //                         ),
  //                         Text(
  //                           '1',
  //                           style: TextStyle(
  //                               color: Colora.primaryColor,
  //                               fontSize: 14
  //                           ),
  //                         ),
  //                         Text(
  //                           '۲۰۰.۰۰۰',
  //                           style: TextStyle(
  //                               color: Colora.primaryColor,
  //                               fontSize: 14
  //                           ),
  //                         ),
  //                         Text(
  //                           '200.000',
  //                           style: TextStyle(
  //                               color: Colora.primaryColor,
  //                               fontSize: 14
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //
  //                   const Divider(
  //                     color: Colora.primaryColor,
  //                     indent: 10,
  //                     endIndent: 10,
  //                   ),
  //
  //                   //price
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(
  //                             vertical: Dimensions.height * 0.01
  //                         ),
  //                         child: const Text(
  //                           'مبلغ کل       :   ',
  //                           style: TextStyle(
  //                               color: Colora.primaryColor,
  //                               fontSize: 12
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(
  //                             vertical: Dimensions.height * 0.01
  //                         ),
  //                         child: const Text(
  //                           '۲۰۰.۰۰۰ تومان',
  //                           style: TextStyle(
  //                               color: Colora.primaryColor,
  //                               fontSize: 12
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //
  //                   //discount
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(
  //                             vertical: Dimensions.height * 0.01
  //                         ),
  //                         child: const Text(
  //                           'مبلغ تخفیف :   ',
  //                           style: TextStyle(
  //                               color: Colora.primaryColor,
  //                               fontSize: 12
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(
  //                             vertical: Dimensions.height * 0.01
  //                         ),
  //                         child: const Text(
  //                           '۲۰۰.۰۰۰ تومان',
  //                           style: TextStyle(
  //                               color: Colora.primaryColor,
  //                               fontSize: 12
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //
  //                   // post price
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(
  //                             vertical: Dimensions.height * 0.01
  //                         ),
  //                         child: const Text(
  //                           'هزینه کرایه   :   ',
  //                           style: TextStyle(
  //                               color: Colora.primaryColor,
  //                               fontSize: 12
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(
  //                             vertical: Dimensions.height * 0.01
  //                         ),
  //                         child: const Text(
  //                           '۲۰۰.۰۰۰ تومان',
  //                           style: TextStyle(
  //                               color: Colora.primaryColor,
  //                               fontSize: 12
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //
  //                   //total
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(
  //                             vertical: Dimensions.height * 0.01
  //                         ),
  //                         child: const Text(
  //                           'مبلغ نهایی    :   ',
  //                           style: TextStyle(
  //                               color: Colora.primaryColor,
  //                               fontSize: 12
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(
  //                             vertical: Dimensions.height * 0.01
  //                         ),
  //                         child: const Text(
  //                           '۲۰۰.۰۰۰ تومان',
  //                           style: TextStyle(
  //                               color: Colora.primaryColor,
  //                               fontSize: 12
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //
  //                 ],
  //               ),
  //             ),
  //
  //             //gift text
  //             Align(
  //               alignment: Alignment.centerRight,
  //               child: Padding(
  //                 padding: EdgeInsets.symmetric(
  //                     vertical: Dimensions.height * 0.01
  //                 ),
  //                 child: const Text(
  //                   '// هدیه : تعمیر دریل',
  //                   style: TextStyle(
  //                     color: Colora.primaryColor,
  //                     fontSize: 11,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //
  //             //payment method
  //             Container(
  //               margin: EdgeInsets.symmetric(
  //                   horizontal: Dimensions.width * 0.05
  //               ),
  //               decoration: BoxDecoration(
  //                   color: Colora.scaffold_,
  //                   borderRadius: BorderRadius.circular(26)
  //               ),
  //               child: Column(
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.symmetric(
  //                         vertical: Dimensions.height * 0.01,
  //                         horizontal: Dimensions.width * 0.05
  //                     ),
  //                     decoration: BoxDecoration(
  //                         color: Colora.primaryColor,
  //                         borderRadius: BorderRadius.circular(26)
  //                     ),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.only(top: 5.0),
  //                           child: Text(
  //                             'تحویل خریدار',
  //                             style: TextStyle(
  //                                 color: Colora.scaffold,
  //                                 fontSize: Dimensions.width * 0.03
  //                             ),
  //                           ),
  //                         ),
  //                         Expanded(
  //                           child: RadioListTile(
  //                             visualDensity: const VisualDensity(
  //                               horizontal: VisualDensity.minimumDensity,
  //                               vertical: VisualDensity.minimumDensity,
  //                             ),
  //                             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //                             controlAffinity: ListTileControlAffinity.trailing,
  //
  //                             contentPadding: EdgeInsets.zero,
  //                             dense: true,
  //                             fillColor:const WidgetStatePropertyAll(Colora.scaffold),
  //
  //                             value: 1,
  //                             groupValue: state.invoiceOption,
  //                             onChanged: (value) {
  //                               bloc.add(InvoiceOption(option: value!));
  //                             },
  //                           ),
  //                         ),
  //
  //                         Padding(
  //                           padding: const EdgeInsets.only(top: 5.0),
  //                           child: Text(
  //                             'تحویل پیک',
  //                             style: TextStyle(
  //                                 color: Colora.scaffold,
  //                                 fontSize: Dimensions.width * 0.03
  //                             ),
  //                           ),
  //                         ),
  //                         Expanded(
  //                           child: RadioListTile(
  //                             visualDensity: const VisualDensity(
  //                               horizontal: VisualDensity.minimumDensity,
  //                               vertical: VisualDensity.minimumDensity,
  //                             ),
  //                             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //                             controlAffinity: ListTileControlAffinity.trailing,
  //
  //                             contentPadding: EdgeInsets.zero,
  //                             dense: true,
  //                             fillColor:const WidgetStatePropertyAll(Colora.scaffold),
  //
  //                             value: 2, // Assign a value of 1 to this option
  //                             groupValue: state.invoiceOption,
  //                             onChanged: (value) {
  //                               bloc.add(InvoiceOption(option: value!));
  //                             },
  //                           ),
  //                         ),
  //
  //                       ],
  //                     ),
  //                   ),
  //
  //                   if(state.invoiceOption == 1 || state.invoiceOption == 2)...[
  //
  //                     //name
  //                     Container(
  //                       height: Dimensions.height * 0.07,
  //                       padding: EdgeInsets.symmetric(
  //                           horizontal: Dimensions.width * 0.04,
  //                           vertical: Dimensions.height * 0.01
  //                       ),
  //                       child: TextField(
  //
  //                         decoration: InputDecoration(
  //                             fillColor: Colora.scaffold,
  //                             filled: true,
  //                             enabledBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(26),
  //                                 borderSide: const BorderSide(color: Colora.primaryColor, width: 2)
  //                             ),
  //                             border: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(26),
  //                                 borderSide: const BorderSide(color: Colora.primaryColor, width: 2)
  //                             ),
  //                             hintText: 'مشخصات :',
  //                             hintStyle: const TextStyle(
  //                                 color: Colora.primaryColor,
  //                                 fontSize: 13
  //                             )
  //                         ),
  //
  //                       ),
  //                     ),
  //
  //                     //phone
  //                     if(state.invoiceOption == 2)...[
  //                       Container(
  //                         height: Dimensions.height * 0.07,
  //                         padding: EdgeInsets.symmetric(
  //                             horizontal: Dimensions.width * 0.04,
  //                             vertical: Dimensions.height * 0.01
  //                         ),
  //                         child: TextField(
  //
  //                           decoration: InputDecoration(
  //                               fillColor: Colora.scaffold,
  //                               filled: true,
  //                               enabledBorder: OutlineInputBorder(
  //                                   borderRadius: BorderRadius.circular(26),
  //                                   borderSide: const BorderSide(color: Colora.primaryColor, width: 2)
  //                               ),
  //                               border: OutlineInputBorder(
  //                                   borderRadius: BorderRadius.circular(26),
  //                                   borderSide: const BorderSide(color: Colora.primaryColor, width: 2)
  //                               ),
  //                               hintText: 'تلفن :',
  //                               hintStyle: const TextStyle(
  //                                   color: Colora.primaryColor,
  //                                   fontSize: 13
  //                               )
  //                           ),
  //
  //                         ),
  //                       ),
  //                     ],
  //
  //                     //description
  //                     Container(
  //                       height: Dimensions.height * 0.07,
  //                       padding: EdgeInsets.symmetric(
  //                           horizontal: Dimensions.width * 0.04,
  //                           vertical: Dimensions.height * 0.01
  //                       ),
  //                       child: TextField(
  //
  //                         decoration: InputDecoration(
  //                             fillColor: Colora.scaffold,
  //                             filled: true,
  //                             enabledBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(26),
  //                                 borderSide: const BorderSide(color: Colora.primaryColor, width: 2)
  //                             ),
  //                             border: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(26),
  //                                 borderSide: const BorderSide(color: Colora.primaryColor, width: 2)
  //                             ),
  //                             hintText: 'توضیحات :',
  //                             hintStyle: const TextStyle(
  //                                 color: Colora.primaryColor,
  //                                 fontSize: 13
  //                             )
  //                         ),
  //
  //                       ),
  //                     ),
  //                   ],
  //
  //                 ],
  //               ),
  //             ),
  //
  //             SizedBox(
  //               height: state.invoiceOption == 1 || state.invoiceOption == 2
  //                   ?Dimensions.height * 0.04
  //                   :Dimensions.height * 0.18,
  //             ),
  //
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 //cancel
  //                 Container(
  //                   // width: Dimensions.width * 0.3,
  //                   decoration: BoxDecoration(
  //                       color: Colora.lightBlue,
  //                       borderRadius: BorderRadius.circular(26)
  //                   ),
  //                   child: MaterialButton(
  //                     onPressed: (){
  //                       bloc.add(const ShowInvoice(isShow: false));
  //                     },
  //                     child: const Text(
  //                       'لغو',
  //                       style: TextStyle(
  //                           color: Colora.scaffold_,
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.bold
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //
  //                 //cancel
  //                 Container(
  //                   // width: Dimensions.width * 0.3,
  //                   decoration: BoxDecoration(
  //                       color: Colora.lightBlue,
  //                       borderRadius: BorderRadius.circular(26)
  //                   ),
  //                   child: MaterialButton(
  //                     onPressed: (){
  //                       bloc.add(const ShowInvoice(isShow: false));
  //                     },
  //                     child: const Text(
  //                       'انصراف',
  //                       style: TextStyle(
  //                           color: Colora.scaffold_,
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.bold
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //
  //                 //confirm
  //                 Container(
  //                   // width: Dimensions.width * 0.3,
  //                   decoration: BoxDecoration(
  //                       color: Colora.lightBlue,
  //                       borderRadius: BorderRadius.circular(26)
  //                   ),
  //                   child: MaterialButton(
  //                     onPressed: (){
  //                       bloc.add(const InvoiceConfirm(isConfirm: true));
  //                     },
  //                     child: const Text(
  //                       'تایید',
  //                       style: TextStyle(
  //                           color: Colora.scaffold_,
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.bold
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //
  //               ],
  //             )
  //
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget confirmInvoice(WorkspaceBloc bloc){
  //   return Container(
  //     width: Dimensions.width,
  //     height: Dimensions.height,
  //     padding: EdgeInsets.symmetric(
  //         horizontal: Dimensions.width * 0.05,
  //         vertical: Dimensions.height * 0.33
  //     ),
  //     color: Colora.primaryColor.withOpacity(0.7),
  //     child: Container(
  //       decoration: BoxDecoration(
  //           color: Colora.scaffold,
  //           borderRadius: BorderRadius.circular(26)
  //       ),
  //       padding: EdgeInsets.symmetric(
  //           vertical: Dimensions.height * 0.02,
  //           horizontal: Dimensions.width * 0.03
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //
  //           const Text(
  //             'تایید دریافت وجه',
  //             style: TextStyle(
  //                 color: Colora.primaryColor,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 22
  //             ),
  //           ),
  //
  //           const Divider(
  //             color: Colora.primaryColor,
  //             thickness: 2,
  //           ),
  //
  //           const Text(
  //             'فروشنده محترم آیا وجه سفارش را کامل دریافت نموده‌اید ؟',
  //             textAlign: TextAlign.justify,
  //             style: TextStyle(
  //                 height: 1.5,
  //                 color: Colora.primaryColor,
  //                 fontSize: 20
  //             ),
  //           ),
  //
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               Container(
  //                 margin: EdgeInsets.only(
  //                     top: Dimensions.height * 0.02
  //                 ),
  //                 padding: EdgeInsets.symmetric(
  //                     horizontal: Dimensions.width * 0.04
  //                 ),
  //                 decoration: BoxDecoration(
  //                     color: Colora.primaryColor,
  //                     borderRadius: BorderRadius.circular(26)
  //                 ),
  //                 child: MaterialButton(
  //                   onPressed: (){
  //                     bloc.add(const InvoiceConfirm(isConfirm: false));
  //                   },
  //                   child: Text(
  //                     'بازگشت',
  //                     style: TextStyle(
  //                         color: Colora.scaffold,
  //                         fontSize: Dimensions.width * 0.05
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 margin: EdgeInsets.only(
  //                     top: Dimensions.height * 0.02
  //                 ),
  //                 padding: EdgeInsets.symmetric(
  //                     horizontal: Dimensions.width * 0.04
  //                 ),
  //                 decoration: BoxDecoration(
  //                     color: Colora.primaryColor,
  //                     borderRadius: BorderRadius.circular(26)
  //                 ),
  //                 child: MaterialButton(
  //                   onPressed: (){
  //                     bloc.add(const InvoiceConfirm(isConfirm: false));
  //                     bloc.add(const ShowInvoice(isShow: false));
  //                   },
  //                   child: Text(
  //                     'بله',
  //                     style: TextStyle(
  //                         color: Colora.scaffold,
  //                         fontSize: Dimensions.width * 0.05
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           )
  //
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
