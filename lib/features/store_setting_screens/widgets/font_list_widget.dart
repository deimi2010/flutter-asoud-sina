import 'package:asood/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AFontWidget extends StatelessWidget {
  const AFontWidget({
    super.key,
    required this.titleWidget,
    this.paletteType = PaletteType.hsvWithHue,
  });

  final Widget titleWidget;
  final PaletteType paletteType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.seven),
      height: Dimensions.height * .33,
      decoration: BoxDecoration(
        color: Colora.lightBlue,
        borderRadius: BorderRadius.circular(Dimensions.fifteen),
      ),
      child: Column(
        children: [
          titleWidget,
          Dimensions.seven.height,
          Container(
            padding: const EdgeInsets.only(top: Dimensions.ten),
            decoration: BoxDecoration(
              color: Colora.primaryColor,
              borderRadius: BorderRadius.circular(Dimensions.fifteen),
            ),
            child: SizedBox(
              height: Dimensions.height * .23,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (c, i) {
                  return SizedBox(
                    child: Column(
                      children: [
                        Text(
                          i % 3 == 0
                              ? 'ایران سنس '
                              : i % 3 == 1
                              ? 'شبنم'
                              : 'یکان',
                          style: ATextStyle.light13,
                        ),
                        const Divider(color: Colora.lightBlue),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
