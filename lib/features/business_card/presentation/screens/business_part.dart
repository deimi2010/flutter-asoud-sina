import 'dart:convert';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/secure_storage.dart';
import 'package:asood/features/business_card/presentation/screens/business_list.dart';
import 'package:asood/features/business_card/presentation/screens/without_market_visit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/endpoints.dart';

class BusinessPart extends StatefulWidget {
  const BusinessPart({super.key});

  @override
  State<BusinessPart> createState() => _BusinessPartState();
}

class _BusinessPartState extends State<BusinessPart> {
  List<Map<String, dynamic>> dataList = [];

  void getVisitCard() async {
    String url = '${Endpoints.baseUrl}owner/market/list/';
    String? token = await SecureStorage.readSecureStorage(Keys.token);

    var response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );
    dataList.clear();

    for (var market in jsonDecode(response.body)['data']) {
      String businessId = market['business_id'];

      var getVisitCard = await http.get(
        Uri.parse('https://asoud.ir/$businessId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      setState(() {
        dataList.add(jsonDecode(getVisitCard.body));
      });
    }

    if (dataList.isEmpty) {
      dataList.add({'first': 'null'});
    }
  }

  @override
  void initState() {
    getVisitCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          dataList.isEmpty
              ? Center(
                child: SizedBox(
                  height: Dimensions.width * 0.1,
                  width: Dimensions.width * 0.1,
                  child: CircularProgressIndicator(
                    color: Colora.backgroundDialog,
                  ),
                ),
              )
              : dataList[0] == {'first': 'null'}
              // : true
              ? WithoutMarketVisit()
              : BusinessList(data: dataList),
    );
  }
}
