import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:flutter/material.dart';

class InquiryReply extends StatefulWidget {
  const InquiryReply({super.key});

  @override
  State<InquiryReply> createState() => _InquiryReplyState();
}

class _InquiryReplyState extends State<InquiryReply> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(title: 'پاسخ استعلام'),
      body: SingleChildScrollView(child: Column()),
    );
  }
}
