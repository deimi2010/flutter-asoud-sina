import 'dart:convert';

import 'package:asood/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/endpoints.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  String terms = '';

  void getTerms() async {
    String url = '${Endpoints.baseUrl}info/term/';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Token 735ec7ebd6c0f1c63af1f076f8ef2c7970819375',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        // terms = response.body;
        // terms = jsonDecode(response.body)[0]['ter'];
        terms = jsonDecode(response.body)['data']['content'];
      });
    }
    print(response.body);
  }

  @override
  void initState() {
    getTerms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: Dimensions.width * 0.8,
                height: Dimensions.height * 0.1,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => Navigator.of(context).pop(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'توافق نامه کاربری',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: Dimensions.width * 0.8,
                  child: Text(terms),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
