import 'dart:convert';
import 'dart:developer';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/secure_storage.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/features/bank_card/screens/bank_card_sharing_screen.dart';
import 'package:asood/features/bank_card/screens/card_sample.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/endpoints.dart';

class BankCardListScreen extends StatefulWidget {
  const BankCardListScreen({super.key});

  @override
  State<BankCardListScreen> createState() => _BankCardListScreenState();
}

class _BankCardListScreenState extends State<BankCardListScreen> {
  String bankInfo = '';
  String cardNumber = '';
  String accountNumber = '';
  String branchId = '';
  String branchName = '';
  String fullName = '';

  List<Map<String, dynamic>> bankCards = [
    {
      "id": "noId",
      "bank_info": "ملت",
      "created_at": "2025-07-06 01:59:17",
      "updated_at": "2025-07-06 02:00:31",
      "card_number": "08909",
      "account_number": "0980",
      "iban": null,
      "full_name": "",
      "branch_id": 1234,
      "branch_name": "shobe.",
      "description": "test",
      "user": 4,
    },
  ];

  List<dynamic> banks = [];

  int whichExpanded = -1;

  void getBanks() async {
    String url = '${Endpoints.baseUrl}user/bank-info/list/';
    String? token = await SecureStorage.readSecureStorage(Keys.token);

    var response2 = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    log(jsonDecode(response2.body)['data'][0]['name'].toString());

    setState(() {
      banks = jsonDecode(response2.body)['data'];
    });
  }

  void getBankCards() async {
    String url = '${Endpoints.baseUrl}user/bank/info/list/';
    String? token = await SecureStorage.readSecureStorage(Keys.token);

    var response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
    bankCards.clear();

    for (var bankCard in jsonDecode(response.body)['data']) {
      setState(() {
        bankCards.add(bankCard);
      });
    }

    log(bankCards.toString());

    getBanks();
  }

  void sendBankCard(
    info,
    card,
    account,
    name,
    branchId,
    branchName,
    description,
  ) async {
    String url = '${Endpoints.baseUrl}user/bank/info/create/';
    String? token = await SecureStorage.readSecureStorage(Keys.token);

    Map<String, dynamic> data_ = {
      "bank_info": info,
      "card_number": card,
      "account_number": account,
      "full_name": name,
      "branch_id": int.parse(branchId),
      "branch_name": branchName,
      "description": "",
    };

    var data = json.encode(data_);

    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: data,
    );

    log(jsonDecode(response.body).toString());
    log(response.statusCode.toString());
    log(data.toString());

    if (response.statusCode == 201) {
      Navigator.pop(context);
      setState(() {
        getBankCards();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('کارت بانکی با موفقیت اضافه شد'),
        ),
      );
    }
  }

  @override
  void initState() {
    getBankCards();
    super.initState();
  }

  void addCart() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colora.primaryColor.withOpacity(0.7),
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width * 0.03,
                ),
                content: SizedBox(
                  width: Dimensions.width * 0.8,
                  height: Dimensions.height * 0.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'مشخصات حساب بانکی',
                        style: TextStyle(
                          color: Colora.primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(color: Colora.primaryColor),
                      Container(
                        width: Dimensions.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(29),
                          border: Border.all(color: Colora.lightBlue, width: 9),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: Dimensions.height * 0.01,
                                horizontal: Dimensions.width * 0.01,
                              ),
                              child: const Text(
                                'انتخاب بانک : ',
                                style: TextStyle(
                                  color: Colora.primaryColor,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: Dimensions.height * 0.05,
                              ),
                              child: SizedBox(
                                height: Dimensions.height * 0.11,
                                width: Dimensions.width * 0.4,
                                child: DropdownButtonFormField<String>(
                                  style: TextStyle(color: Colors.white),
                                  // hint: Text(''),
                                  value: banks[0]['name'],
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colora.primaryColor,

                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.twenty,
                                      ),
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.twenty,
                                  ),
                                  dropdownColor: Colora.primaryColor,
                                  iconEnabledColor: Colors.white,
                                  // value: 'selectedPlatform',
                                  items:
                                      banks.map((bank) {
                                        return DropdownMenuItem<String>(
                                          value: bank['name'],
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                bank['name'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 30),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      5,
                                                    ),
                                                child: Image.network(
                                                  'https://asoud.ir/${bank['logo']}',
                                                  height: 30,
                                                  width: 30,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                  onChanged: (value) {
                                    // log(value.toString());
                                    for (var bank in banks) {
                                      if (value == bank['name']) {
                                        setState(() {
                                          bankInfo = '${bank['id']}';
                                        });
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                            // DropdownButtonHideUnderline(
                            //   child: DropdownButton<DiscountType>(
                            //     dropdownColor: Colora.primaryColor,
                            //     iconEnabledColor: Colora.primaryColor,
                            //     borderRadius: BorderRadius.circular(15),
                            //     value: DiscountType.none,
                            //     hint: Text(
                            //       'انتخاب نمایید',
                            //       style: TextStyle(
                            //         color: Colora.scaffold,
                            //         fontSize: Dimensions.width * 0.03,
                            //       ),
                            //     ),
                            //     items:
                            //         banks.map((bank) {
                            //           return DropdownMenuItem<DiscountType>(
                            //             value: bank['name'],
                            //             child: Text(
                            //               bank['name'],
                            //               style: const TextStyle(
                            //                 color: Colors.white,
                            //               ),
                            //             ),
                            //           );
                            //         }).toList(),
                            //     onChanged: (value) {
                            //       if (value != null) {
                            //         context.read<AddProductBloc>().add(
                            //           DiscountTypeEvent(type: value),
                            //         );
                            //       }
                            //     },
                            //   ),
                            // ),
                            // Container(
                            //   width: Dimensions.width * 0.45,
                            //   height: Dimensions.height * 0.045,
                            //   margin: EdgeInsets.symmetric(
                            //     vertical: Dimensions.height * 0.005,
                            //   ),
                            //   decoration: BoxDecoration(
                            //     color: Colora.primaryColor,
                            //     borderRadius: BorderRadius.circular(29),
                            //   ),
                            //   child: const Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceAround,
                            //     children: [
                            //       Text(
                            //         'بانک ملت',
                            //         style: TextStyle(
                            //           color: Colora.scaffold,
                            //           fontSize: 10,
                            //         ),
                            //       ),
                            //       Icon(Icons.food_bank, color: Colora.scaffold),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Dimensions.width * 0.25,
                            height: Dimensions.height * 0.05,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                color: Colora.primaryColor,
                              ),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9۰-۹]'),
                                ),
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(29),
                                  borderSide: const BorderSide(
                                    color: Colora.primaryColor,
                                  ),
                                ),
                                hintText: 'کد شعبه',

                                hintStyle: const TextStyle(
                                  color: Colora.primaryColor,
                                  fontSize: 11,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  branchId = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width * 0.45,
                            height: Dimensions.height * 0.05,
                            child: TextField(
                              style: const TextStyle(
                                color: Colora.primaryColor,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(29),
                                  borderSide: const BorderSide(
                                    color: Colora.primaryColor,
                                  ),
                                ),
                                hintText: 'نام شعبه',
                                hintStyle: const TextStyle(
                                  color: Colora.primaryColor,
                                  fontSize: 11,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  branchName = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: Dimensions.width * 0.75,
                        height: Dimensions.height * 0.05,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colora.primaryColor),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(29),
                              borderSide: const BorderSide(
                                color: Colora.primaryColor,
                              ),
                            ),
                            hintText: 'شماره حساب',
                            hintStyle: const TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 11,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              accountNumber = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width * 0.75,
                        height: Dimensions.height * 0.05,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(color: Colora.primaryColor),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(29),
                              borderSide: const BorderSide(
                                color: Colora.primaryColor,
                              ),
                            ),
                            hintText: 'شماره شبا',
                            hintStyle: const TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 11,
                            ),
                            suffixText: 'IR',
                            suffixStyle: const TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width * 0.75,
                        height: Dimensions.height * 0.05,
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CardNumberFormatter(),
                          ],
                          // textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(color: Colora.primaryColor),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              left: Dimensions.width * 0.09,
                              right: Dimensions.width * 0.04,
                            ),
                            // prefixIcon: Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Image.network(
                            //     'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/800px-Mastercard-logo.svg.png',
                            //     height: 30,
                            //     width: 30,
                            //   ),
                            // ),
                            // suffixIcon: const Padding(
                            //   padding: EdgeInsets.all(8.0),
                            //   child: Text(
                            //     'Change',
                            //     style: TextStyle(color: Colors.green),
                            //   ),
                            // ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(29),
                              borderSide: const BorderSide(
                                color: Colora.primaryColor,
                              ),
                            ),
                            hintText: 'شماره کارت',

                            hintStyle: const TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 11,
                            ),
                            // labelText: 'Card Number',
                            counterText: "",
                          ),
                          maxLength: 19,
                          onChanged: (value) {
                            setState(() {
                              cardNumber = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width * 0.75,
                        height: Dimensions.height * 0.05,
                        child: TextField(
                          style: const TextStyle(
                            color: Colora.primaryColor,
                            // fontSize: 11
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(29),
                              borderSide: const BorderSide(
                                color: Colora.primaryColor,
                              ),
                            ),
                            hintText: 'نام صاحب حساب',
                            hintStyle: const TextStyle(
                              color: Colora.primaryColor,
                              fontSize: 11,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              fullName = value;
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Dimensions.width * 0.35,
                            height: Dimensions.height * 0.05,
                            margin: EdgeInsets.only(
                              top: Dimensions.height * 0.01,
                            ),
                            decoration: BoxDecoration(
                              color: Colora.primaryColor,
                              borderRadius: BorderRadius.circular(29),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'لغو',
                                style: TextStyle(
                                  color: Colora.scaffold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: Dimensions.width * 0.35,
                            height: Dimensions.height * 0.05,
                            margin: EdgeInsets.only(
                              top: Dimensions.height * 0.01,
                            ),
                            decoration: BoxDecoration(
                              color: Colora.primaryColor,
                              borderRadius: BorderRadius.circular(29),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                sendBankCard(
                                  bankInfo,
                                  cardNumber,
                                  accountNumber,
                                  fullName,
                                  branchId,
                                  branchName,
                                  '',
                                );
                              },
                              child: const Text(
                                'ذخیره',
                                style: TextStyle(
                                  color: Colora.scaffold,
                                  fontSize: 18,
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
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(title: 'لیست مشخصات بانکی'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addCart();
        },
        backgroundColor: Colora.primaryColor,
        child: Icon(Icons.add, color: Colora.scaffold),
      ),
      body:
          bankCards.isEmpty
              // : true
              ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: Dimensions.height * 0.05,
                    ),
                    child: Text(
                      'لیست کارت بانکی های شما خالی است، یک کارت مثل نمونه پایین اضافه کنید:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colora.backgroundDialog,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height * 0.1),

                  BankSample(),
                ],
              )
              : bankCards[0]['id'] == 'noId'
              ? Center(
                child: SizedBox(
                  height: Dimensions.width * 0.1,
                  width: Dimensions.width * 0.1,
                  child: CircularProgressIndicator(
                    color: Colora.backgroundDialog,
                  ),
                ),
              )
              : Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: Dimensions.height * 0.05,
                  bottom: Dimensions.height * 0.05,
                ),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      width: Dimensions.width,
                      padding: EdgeInsets.only(
                        bottom: Dimensions.width * 0.015,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: Dimensions.height * 0.01,
                        horizontal: Dimensions.width * 0.03,
                      ),
                      decoration: BoxDecoration(
                        color: Colora.primaryColor,
                        border: Border.all(
                          color: Colora.primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colora.scaffold,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              width: Dimensions.width,
                              height: Dimensions.height * 0.06,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colora.primaryColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: Dimensions.width * 0.1),
                                  Text(
                                    'بانک ${bankCards[index]['bank_info']}',
                                    style: TextStyle(
                                      color: Colora.primaryColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        // isExpanded = !isExpanded;
                                        if (whichExpanded == index) {
                                          whichExpanded = -1;
                                        } else {
                                          whichExpanded = index;
                                        }
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.swap_vert_rounded,
                                      color: Colora.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //bank
                            Padding(
                              padding: EdgeInsets.only(
                                top: Dimensions.height * 0.015,
                                right: Dimensions.width * 0.05,
                              ),
                              child: Text(
                                'نام شعبه : ${bankCards[index]['branch_name']}',
                                style: TextStyle(
                                  color: Colora.primaryColor,
                                  fontSize: 11,
                                ),
                              ),
                            ),

                            //account
                            Padding(
                              padding: EdgeInsets.only(
                                right: Dimensions.width * 0.05,
                                left: Dimensions.width * 0.02,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'کد شعبه : ${bankCards[index]['branch_id']}',
                                    style: TextStyle(
                                      color: Colora.primaryColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    '${bankCards[index]['account_number']}',
                                    style: TextStyle(
                                      color: Colora.primaryColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //shaba
                            Container(
                              width: Dimensions.width,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                left: Dimensions.width * 0.02,
                              ),
                              child: Text(
                                // 'IR52 2522 3547 6584 9824 9014 24',
                                '${bankCards[index]['iban']}' == 'null'
                                    ? ''
                                    : '${bankCards[index]['iban']}',
                                style: TextStyle(
                                  color: Colora.primaryColor,
                                  fontSize: 11,
                                ),
                              ),
                            ),

                            //cart number
                            Container(
                              width: Dimensions.width,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                vertical: Dimensions.height * 0.01,
                              ),
                              child: Text(
                                '${bankCards[index]['card_number']}',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: Colora.primaryColor,
                                  fontSize: 25,
                                  fontFamily: 't',
                                ),
                              ),
                            ),

                            //name
                            Padding(
                              padding: EdgeInsets.only(
                                top: Dimensions.height * 0.01,
                                right: Dimensions.width * 0.03,
                                bottom: Dimensions.height * 0.01,
                              ),
                              child: Text(
                                '${bankCards[index]['full_name']}',
                                style: TextStyle(
                                  color: Colora.primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            //buttons
                            Container(
                              color: Colora.primaryColor,
                              child:
                                  whichExpanded == index
                                      ? Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width: Dimensions.width * 0.4,
                                                child: CheckboxListTile(
                                                  title: const Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 5.0,
                                                    ),
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        'شماره حساب',
                                                        style: TextStyle(
                                                          color:
                                                              Colora.scaffold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  value: false,
                                                  onChanged: (newValue) {
                                                    // setState(() {
                                                    //   // checkedValue = newValue;
                                                    // });
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  side: const BorderSide(
                                                    color: Colora.scaffold,
                                                  ),
                                                  fillColor:
                                                      WidgetStateProperty.all(
                                                        Colora.scaffold,
                                                      ),
                                                  activeColor: Colora.scaffold,
                                                  checkColor:
                                                      Colora.primaryColor,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width * 0.4,
                                                child: CheckboxListTile(
                                                  title: const Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 5.0,
                                                    ),
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        'شماره شبا',
                                                        style: TextStyle(
                                                          color:
                                                              Colora.scaffold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  value: false,
                                                  onChanged: (newValue) {
                                                    // bloc.add(IsMarketerEvent(isMarketer: !state.isMarketer));
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  side: const BorderSide(
                                                    color: Colora.scaffold,
                                                  ),
                                                  activeColor: Colora.scaffold,
                                                  fillColor:
                                                      WidgetStateProperty.all(
                                                        Colora.scaffold,
                                                      ),
                                                  checkColor:
                                                      Colora.primaryColor,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width: Dimensions.width * 0.4,
                                                child: CheckboxListTile(
                                                  title: const Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 5.0,
                                                    ),
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        'شماره کارت',
                                                        style: TextStyle(
                                                          color:
                                                              Colora.scaffold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  value: false,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  side: const BorderSide(
                                                    color: Colora.scaffold,
                                                  ),
                                                  fillColor:
                                                      WidgetStateProperty.all(
                                                        Colora.scaffold,
                                                      ),
                                                  activeColor: Colora.scaffold,
                                                  checkColor:
                                                      Colora.primaryColor,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  onChanged: (bool? value) {},
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width * 0.4,
                                                child: CheckboxListTile(
                                                  title: const Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 5.0,
                                                    ),
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        'نام صاحب حساب',
                                                        style: TextStyle(
                                                          color:
                                                              Colora.scaffold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  value: false,
                                                  onChanged: (newValue) {
                                                    // bloc.add(IsMarketerEvent(isMarketer: !state.isMarketer));
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  side: const BorderSide(
                                                    color: Colora.scaffold,
                                                  ),
                                                  activeColor: Colora.scaffold,
                                                  fillColor:
                                                      WidgetStateProperty.all(
                                                        Colora.scaffold,
                                                      ),
                                                  checkColor:
                                                      Colora.primaryColor,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  Dimensions.width * 0.03,
                                            ),
                                            child: TextField(
                                              maxLines: 3,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                filled: true,
                                                fillColor: Colora.scaffold,
                                                hintText: 'یادداشت',
                                                hintStyle: TextStyle(
                                                  color: Colora.primaryColor
                                                      .withOpacity(0.5),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: Dimensions.width * 0.4,
                                                height:
                                                    Dimensions.height * 0.05,
                                                margin: EdgeInsets.only(
                                                  top: Dimensions.height * 0.01,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colora.scaffold,
                                                  borderRadius:
                                                      BorderRadius.circular(29),
                                                ),
                                                child: MaterialButton(
                                                  onPressed: () {},
                                                  child: const Text(
                                                    'کپی',
                                                    style: TextStyle(
                                                      color:
                                                          Colora.primaryColor,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: Dimensions.width * 0.4,
                                                height:
                                                    Dimensions.height * 0.05,
                                                margin: EdgeInsets.only(
                                                  top: Dimensions.height * 0.01,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colora.scaffold,
                                                  borderRadius:
                                                      BorderRadius.circular(29),
                                                ),
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                const BankCardSharingScreen(),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                    'اشتراک گذاری',
                                                    style: TextStyle(
                                                      color:
                                                          Colora.primaryColor,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                      : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: bankCards.length,
                ),
              ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
