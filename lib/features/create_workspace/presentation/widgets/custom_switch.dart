import 'package:asood/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required this.title,
    required this.onChanged,
    required this.switchValue,
  });

  final String title;
  final Function(bool)? onChanged;
  final bool switchValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(title, style: ATextStyle.lightBlue16),
            ),
            CupertinoSwitch(
              activeTrackColor: Colora.primaryColor,
              value: switchValue,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
