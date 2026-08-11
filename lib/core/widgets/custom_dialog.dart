// ignore_for_file: unnecessary_import

import 'package:asood/core/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.context,
    required this.title,
    required this.widget,
    this.height,
    this.color,
    this.backgroundColor,
    this.textColor,
  });

  final double? height;
  final BuildContext context;
  final String title;
  final Widget widget;
  final Color? color;
  final Color? backgroundColor;
  final Color? textColor;

  void showCustomDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: backgroundColor ?? Colora.primaryColor,
          content: FittedBox(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: color ?? Colors.white,
              ),
              height: height ?? 220,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(color: textColor ?? Colora.primaryColor),
                  ),
                  const Divider(thickness: 1),
                  const SizedBox(height: 10),
                  widget,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
