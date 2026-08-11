import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:flutter/material.dart';

class ListInquiry extends StatefulWidget {
  const ListInquiry({super.key});

  @override
  State<ListInquiry> createState() => _ListInquiryState();
}

class _ListInquiryState extends State<ListInquiry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(title: 'لیست استعلام'),
      body: SingleChildScrollView(child: Column()),
    );
  }
}
