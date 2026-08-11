import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'custom_textfield.dart';

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({
    super.key,
    this.backgroundColor = Colora.primaryColor,
    this.color = Colors.white,
  });

  final Color backgroundColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: CustomTextField(
        controller: TextEditingController(),
        text: 'جستجوی مخاطب',
        style: TextStyle(color: color),
        suffixIcon: Icon(Icons.search, color: color), // Set icon color to white
        color: backgroundColor,
        backgroundColor: backgroundColor,
        hintStyle: TextStyle(color: color),
      ),
    );
  }
}
