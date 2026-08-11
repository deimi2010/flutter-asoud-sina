import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/core/widgets/colorpicker.dart';
import 'package:asood/core/widgets/custom_button.dart';

import 'package:asood/core/widgets/simple_bot_navbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorSettingScreen extends StatefulWidget {
  const ColorSettingScreen({super.key});

  @override
  State<ColorSettingScreen> createState() => _ColorSettingScreenState();
}

class _ColorSettingScreenState extends State<ColorSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      bottomNavigationBar: const SimpleBotNavBar(),
      body: Container(
        height: Dimensions.height,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AColorPicker(
                paletteType: PaletteType.hsl,
                titleWidget: Container(
                  height: 40,
                  width: Dimensions.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colora.primaryColor,
                  ),
                  child: const Center(
                    child: Text(
                      "رنگ بندی قسمت بالا",
                      style: TextStyle(color: Colora.scaffold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              AColorPicker(
                titleWidget: Container(
                  height: 40,
                  width: Dimensions.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colora.primaryColor,
                  ),
                  child: const Center(
                    child: Text(
                      "رنگ بندی قسمت پایین",
                      style: TextStyle(color: Colora.scaffold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                onPress: () {},
                text: "ذخیره",
                color: Colora.primaryColor,
                height: 40,
                width: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
