import 'package:asood/core/constants/constants.dart';
import 'package:flutter/material.dart';

class RowWidgetTitle extends StatelessWidget {
  const RowWidgetTitle({super.key, required this.title, required this.widget});

  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title, style: ATextStyle.lightBlue18), widget],
    );
  }
}
