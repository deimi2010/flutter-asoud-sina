import 'dart:convert';
import 'dart:developer';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/secure_storage.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/core/widgets/simple_bot_navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/endpoints.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  bool showInvoice = false;
  bool showFinalMessage = false;

  String id = '';
  List<Map<String, dynamic>> orders = [
    {
      'id': '',
      'product': {
        'id': '05e95d5b-6041-4c81-a77a-30c98b48edcc',
        'name': 'newtest',
        'images': ['null'],
      },
      'affiliate': 'affiliate',
      'quantity': '3',
    },
  ];

  // List<String> prefIds = [];

  // void getPrefIds() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   List<String>? getData = sharedPreferences.getStringList("shopping_cart");

  //   print('sina this is your get data :');
  //   print(getData.toString());

  //   if (getData != null && getData != []) {
  //     setState(() {
  //       prefIds = getData;
  //     });
  //   }
  // }

  // void removeProductFromCart(id) async {
  //   setState(() {
  //     prefIds.remove(id);
  //   });

  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setStringList("shopping_cart", prefIds);
  // }

  Future<String?> nameOfProduct(id) async {
    String url = '${Endpoints.baseUrl}owner/product/detail/$id/';
    String? token = await SecureStorage.readSecureStorage(Keys.token);

    var response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    log('sina this is your id: $id');

    log('sina this is your data:');
    log(jsonDecode(response.body).toString());

    return jsonDecode(response.body)['data']['name'].toString();
  }

  void getOrders() async {
    id = '';

    String url = '${Endpoints.baseUrl}user/order/orders';
    String? token = await SecureStorage.readSecureStorage(Keys.token);

    var response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    orders.clear();

    setState(() {
      id = jsonDecode(response.body)['id'];
    });
    for (var order in jsonDecode(response.body)['items']) {
      setState(() {
        orders.add(order);
      });
    }
  }

  void addQuantity(String orderId, String productId, quantity) async {
    String url = '${Endpoints.baseUrl}user/order/update_item/$orderId';
    String? token = await SecureStorage.readSecureStorage(Keys.token);

    var response = await http.put(
      Uri.parse(url),
      body: {"product": productId, "quantity": (quantity + 1).toString()},
      headers: {'Authorization': 'Bearer $token'},
    );

    setState(() {
      getOrders();
    });

    // get orders another time
  }

  void removeQuantity(String orderId, String productId, quantity) async {
    String url = '${Endpoints.baseUrl}user/order/update_item/$orderId';
    String? token = await SecureStorage.readSecureStorage(Keys.token);

    var response = await http.put(
      Uri.parse(url),
      body: {"product": productId, "quantity": (quantity - 1).toString()},
      headers: {'Authorization': 'Bearer $token'},
    );

    setState(() {
      getOrders();
    });

    // get orders another time
  }

  void goToProductPage() {
    // complete product details based on getProductById
    log('go to product page');
  }

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  // here get product and create your card and buy it, this part is important for sina.

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colora.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body:
              orders.isEmpty
                  ? SizedBox(
                    height: Dimensions.height,
                    width: Dimensions.width,

                    child: Stack(
                      children: [
                        const NewAppBar(title: 'سبد خرید‌'),
                        Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: Dimensions.width * 0.03,
                          ),
                          child: Center(
                            child: Text(
                              'سبد خرید شما خالی است',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colora.backgroundSwitch,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  : orders[0]['affiliate'] == 'affiliate'
                  ? Center(
                    child: SizedBox(
                      height: Dimensions.width * 0.1,
                      width: Dimensions.width * 0.1,
                      child: CircularProgressIndicator(
                        color: Colora.backgroundDialog,
                      ),
                    ),
                  )
                  : Stack(
                    children: [
                      //products
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: Dimensions.height * 0.11),

                            SizedBox(
                              height: Dimensions.height * 0.6,
                              width: Dimensions.width,
                              child: ListView.builder(
                                itemCount: orders.length,
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemBuilder:
                                    (context, index) =>
                                        productCart(index, orders[index]),
                              ),
                            ),

                            //buttons
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: Dimensions.height * 0.02,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colora.primaryColor,
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width * 0.07,
                                    ),
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'بازگشت',
                                        style: TextStyle(
                                          color: Colora.scaffold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colora.primaryColor,
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width * 0.03,
                                    ),
                                    child: MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          showInvoice = true;
                                        });
                                      },
                                      child: const Text(
                                        'تکمیل خرید',
                                        style: TextStyle(
                                          color: Colora.scaffold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SimpleBotNavBar(),
                          ],
                        ),
                      ),

                      const NewAppBar(title: 'سبد خرید‌'),

                      // invoice
                      if (showInvoice == true) ...[
                        Container(
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
                                    margin: EdgeInsets.only(
                                      bottom: Dimensions.height * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colora.primaryColor,
                                      borderRadius: BorderRadius.circular(26),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'فاکتور - ثبت نهایی',
                                      style: TextStyle(
                                        color: Colora.scaffold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),

                                  //name
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.height * 0.01,
                                    ),
                                    child: const Text(
                                      'گیرنده : محمد رضا محمدی',
                                      style: TextStyle(
                                        color: Colora.primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),

                                  //phone
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.height * 0.01,
                                    ),
                                    child: const Text(
                                      'شماره موبایل : ۰۹۱۲۳۹۳۱۷۷۴',
                                      style: TextStyle(
                                        color: Colora.primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),

                                  //address
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.height * 0.01,
                                    ),
                                    child: const Text(
                                      'آدرس : تهران ، احمد آباد',
                                      style: TextStyle(
                                        color: Colora.primaryColor,
                                        fontSize: 16,
                                      ),
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
                                            borderRadius: BorderRadius.circular(
                                              26,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
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

                                        ...orders.map((order) {
                                          return Container(
                                            height: Dimensions.height * 0.06,
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      Dimensions.width * 0.15,
                                                  child: Center(
                                                    child: Text(
                                                      order['product']['name'],
                                                      style: TextStyle(
                                                        color:
                                                            Colora.primaryColor,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      Dimensions.width * 0.15,
                                                  child: Center(
                                                    child: Text(
                                                      order['quantity']
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            Colora.primaryColor,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      Dimensions.width * 0.15,
                                                  child: Center(
                                                    child: Text(
                                                      '۲۰۰.۰۰۰',
                                                      style: TextStyle(
                                                        color:
                                                            Colora.primaryColor,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      Dimensions.width * 0.15,
                                                  child: Center(
                                                    child: Text(
                                                      '200.000',
                                                      style: TextStyle(
                                                        color:
                                                            Colora.primaryColor,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),

                                        const Divider(
                                          color: Colora.primaryColor,
                                          indent: 10,
                                          endIndent: 10,
                                        ),

                                        //price
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    Dimensions.height * 0.01,
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
                                                vertical:
                                                    Dimensions.height * 0.01,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    Dimensions.height * 0.01,
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
                                                vertical:
                                                    Dimensions.height * 0.01,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    Dimensions.height * 0.01,
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
                                                vertical:
                                                    Dimensions.height * 0.01,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    Dimensions.height * 0.01,
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
                                                vertical:
                                                    Dimensions.height * 0.01,
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

                                  //payment text
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: Dimensions.height * 0.02,
                                      ),
                                      child: const Text(
                                        'شیوه پرداخت :',
                                        style: TextStyle(
                                          color: Colora.primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  //payment method
                                  Container(
                                    height: Dimensions.height * 0.06,
                                    decoration: BoxDecoration(
                                      color: Colora.scaffold_,
                                      borderRadius: BorderRadius.circular(26),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width * 0.05,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 5.0,
                                          ),
                                          child: Text(
                                            'نقد',
                                            style: TextStyle(
                                              color: Colora.primaryColor,
                                              fontSize: Dimensions.width * 0.03,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile(
                                            visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity,
                                            ),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,

                                            contentPadding: EdgeInsets.zero,
                                            dense: true,
                                            fillColor: WidgetStateProperty.all(
                                              Colora.primaryColor,
                                            ),

                                            value:
                                                1, // Assign a value of 1 to this option
                                            groupValue:
                                                '_selectedValue', // Use _selectedValue to track the selected option
                                            onChanged: (value) {
                                              // setState(() {
                                              //   // _selectedValue = value!; // Update _selectedValue when option 1 is selected
                                              // });
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 5.0,
                                          ),
                                          child: Text(
                                            'اینترنتی',
                                            style: TextStyle(
                                              color: Colora.primaryColor,
                                              fontSize: Dimensions.width * 0.03,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile(
                                            visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity,
                                            ),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,

                                            contentPadding: EdgeInsets.zero,
                                            dense: true,
                                            fillColor: WidgetStateProperty.all(
                                              Colora.primaryColor,
                                            ),

                                            value:
                                                1, // Assign a value of 1 to this option
                                            groupValue:
                                                '_selectedValue', // Use _selectedValue to track the selected option
                                            onChanged: (value) {
                                              // setState(() {
                                              //   // _selectedValue = value!; // Update _selectedValue when option 1 is selected
                                              // });
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 5.0,
                                          ),
                                          child: Text(
                                            'حواله',
                                            style: TextStyle(
                                              color: Colora.primaryColor,
                                              fontSize: Dimensions.width * 0.03,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile(
                                            visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity,
                                            ),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,

                                            contentPadding: EdgeInsets.zero,
                                            dense: true,
                                            fillColor: WidgetStateProperty.all(
                                              Colora.primaryColor,
                                            ),

                                            value:
                                                1, // Assign a value of 1 to this option
                                            groupValue:
                                                '_selectedValue', // Use _selectedValue to track the selected option
                                            onChanged: (value) {
                                              // setState(() {
                                              //   // _selectedValue = value!; // Update _selectedValue when option 1 is selected
                                              // });
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 5.0,
                                          ),
                                          child: Text(
                                            'چک',
                                            style: TextStyle(
                                              color: Colora.primaryColor,
                                              fontSize: Dimensions.width * 0.03,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile(
                                            visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity,
                                            ),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,

                                            contentPadding: EdgeInsets.zero,
                                            dense: true,
                                            fillColor: WidgetStateProperty.all(
                                              Colora.primaryColor,
                                            ),

                                            value:
                                                1, // Assign a value of 1 to this option
                                            groupValue:
                                                '_selectedValue', // Use _selectedValue to track the selected option
                                            onChanged: (value) {
                                              // setState(() {
                                              //   // _selectedValue = value!; // Update _selectedValue when option 1 is selected
                                              // });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: Dimensions.height * 0.14),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      //cancel
                                      Container(
                                        width: Dimensions.width * 0.3,
                                        decoration: BoxDecoration(
                                          color: Colora.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            26,
                                          ),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            setState(() {
                                              showInvoice = false;
                                            });
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

                                      SizedBox(width: Dimensions.width * 0.03),

                                      //confirm
                                      Container(
                                        width: Dimensions.width * 0.3,
                                        decoration: BoxDecoration(
                                          color: Colora.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            26,
                                          ),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            setState(() {
                                              showFinalMessage = true;
                                            });
                                          },
                                          child: const Text(
                                            'ثبت نهایی',
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
                        ),
                      ],

                      if (showFinalMessage == true) ...[
                        Container(
                          width: Dimensions.width,
                          height: Dimensions.height,
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width * 0.05,
                            vertical: Dimensions.height * 0.25,
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
                                  'تایید نهایی',
                                  style: TextStyle(
                                    color: Colora.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const Divider(
                                  color: Colora.primaryColor,
                                  thickness: 2,
                                ),
                                const Text(
                                  'خریدار گرامی ، سفارش شما با موفقیت تایید گردید . شما می‌توانید فرایند سفارش خود را از پیگیری خرید ،‌مشاهده نمائید',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    height: 1.5,
                                    color: Colora.primaryColor,
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: Dimensions.height * 0.02,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width * 0.04,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colora.primaryColor,
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        showInvoice = false;
                                        showFinalMessage = false;
                                      });
                                    },
                                    child: Text(
                                      'رویت شد',
                                      style: TextStyle(
                                        color: Colora.scaffold,
                                        fontSize: Dimensions.width * 0.05,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
        ),
      ),
    );
  }

  Widget productCart(index, order) {
    return Container(
      width: Dimensions.width * 0.9,
      height: Dimensions.height * 0.15,
      margin: EdgeInsets.symmetric(
        vertical: Dimensions.height * 0.005,
        horizontal: Dimensions.width * 0.04,
      ),
      decoration: BoxDecoration(
        color: Colora.lightBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          goToProductPage();
        },
        child: Row(
          children: [
            //image
            SizedBox(
              width: Dimensions.width * 0.32,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      goToProductPage();
                    },
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        child: Container(
                          color: Colora.borderAvatar,
                          child: Container(),
                          // order['product']['images'] != []
                          //     ? CachedNetworkImage(
                          //       imageUrl:
                          //           'https://asoud.ir/${order['product']['images'][0]['image']}',
                          //       fit: BoxFit.cover,
                          //     )
                          //     : Container(),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    width: Dimensions.width * 0.32,
                    child: Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Container(
                          width: Dimensions.width * 0.25,
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colora.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                // removeProductFromCart(prefIds[index]);
                              });
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.delete_rounded,
                                  color: Colora.scaffold,
                                  size: 20,
                                ),
                                Text(
                                  'حذف کردن',
                                  style: TextStyle(
                                    color: Colora.scaffold,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Dimensions.width * 0.6,
              child: Column(
                children: [
                  //title
                  InkWell(
                    onTap: () {
                      goToProductPage();
                    },
                    child: Container(
                      width: Dimensions.width * 0.6,
                      height: Dimensions.height * 0.06,
                      margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.width * 0.03,
                        vertical: Dimensions.height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: Colora.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: FutureBuilder(
                        future: nameOfProduct(order['product']['id']),
                        builder: (context, asyncSnapshot) {
                          return Text(
                            asyncSnapshot.data ?? '',
                            style: TextStyle(
                              color: Colora.scaffold,
                              fontSize: Dimensions.width * 0.03,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  //price and count
                  Container(
                    width: Dimensions.width * 0.7,
                    height: Dimensions.height * 0.07,
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width * 0.03,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '120.000 تومان',
                          style: TextStyle(
                            color: Colora.scaffold,
                            fontSize: Dimensions.width * 0.03,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colora.primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 2,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      addQuantity(
                                        order['id'],
                                        order['product']['id'],
                                        order['quantity'],
                                      );
                                    });
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colora.scaffold,
                                    size: 15,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 2,
                                ),
                                child: Text(
                                  '${order["quantity"]}',
                                  style: const TextStyle(
                                    color: Colora.scaffold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      removeQuantity(
                                        order['id'],
                                        order['product']['id'],
                                        order['quantity'],
                                      );
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: Colora.scaffold,
                                    size: 15,
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
          ],
        ),
      ),
    );
  }

  Widget cartInvoice() {
    return Container(
      width: Dimensions.width,
      height: Dimensions.height,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width * 0.05,
        vertical: Dimensions.height * 0.05,
      ),
      color: Colora.primaryColor.withOpacity(0.5),
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
                  'فاکتور - ثبت نهایی',
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

              //payment text
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height * 0.02,
                  ),
                  child: const Text(
                    'شیوه پرداخت :',
                    style: TextStyle(
                      color: Colora.primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              //payment method
              Container(
                height: Dimensions.height * 0.06,
                decoration: BoxDecoration(
                  color: Colora.scaffold_,
                  borderRadius: BorderRadius.circular(26),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'نقد',
                        style: TextStyle(
                          color: Colora.primaryColor,
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
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        controlAffinity: ListTileControlAffinity.trailing,

                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        fillColor: WidgetStateProperty.all(Colora.primaryColor),

                        value: 1, // Assign a value of 1 to this option
                        groupValue:
                            '_selectedValue', // Use _selectedValue to track the selected option
                        onChanged: (value) {
                          // setState(() {
                          //   // _selectedValue = value!; // Update _selectedValue when option 1 is selected
                          // });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'اینترنتی',
                        style: TextStyle(
                          color: Colora.primaryColor,
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
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        controlAffinity: ListTileControlAffinity.trailing,

                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        fillColor: WidgetStateProperty.all(Colora.primaryColor),

                        value: 1, // Assign a value of 1 to this option
                        groupValue:
                            '_selectedValue', // Use _selectedValue to track the selected option
                        onChanged: (value) {
                          // setState(() {
                          //   // _selectedValue = value!; // Update _selectedValue when option 1 is selected
                          // });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'حواله',
                        style: TextStyle(
                          color: Colora.primaryColor,
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
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        controlAffinity: ListTileControlAffinity.trailing,

                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        fillColor: WidgetStateProperty.all(Colora.primaryColor),

                        value: 1, // Assign a value of 1 to this option
                        groupValue:
                            '_selectedValue', // Use _selectedValue to track the selected option
                        onChanged: (value) {
                          // setState(() {
                          //   // _selectedValue = value!; // Update _selectedValue when option 1 is selected
                          // });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'چک',
                        style: TextStyle(
                          color: Colora.primaryColor,
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
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        controlAffinity: ListTileControlAffinity.trailing,

                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        fillColor: WidgetStateProperty.all(Colora.primaryColor),

                        value: 1, // Assign a value of 1 to this option
                        groupValue:
                            '_selectedValue', // Use _selectedValue to track the selected option
                        onChanged: (value) {
                          // setState(() {
                          //   // _selectedValue = value!; // Update _selectedValue when option 1 is selected
                          // });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: Dimensions.height * 0.14),

              StatefulBuilder(
                builder: (context, setState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: Dimensions.width * 0.3,
                        decoration: BoxDecoration(
                          color: Colora.primaryColor,
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              showInvoice = false;
                            });
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
                      SizedBox(width: Dimensions.width * 0.03),
                      Container(
                        width: Dimensions.width * 0.3,
                        decoration: BoxDecoration(
                          color: Colora.primaryColor,
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: MaterialButton(
                          onPressed: () {},
                          child: const Text(
                            'ثبت نهایی',
                            style: TextStyle(
                              color: Colora.scaffold_,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
