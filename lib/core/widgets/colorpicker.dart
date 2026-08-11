import 'package:asood/core/constants/constants.dart';
import 'package:asood/features/vendor/presentation/bloc/vendor/vendor_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AColorPicker extends StatefulWidget {
  const AColorPicker({
    super.key,
    required this.titleWidget,
    this.paletteType = PaletteType.hsvWithHue,
    this.currentIndex = 0,
    this.mainColor,
    this.backgroundColor,
    this.secondColor,
  });

  final Widget titleWidget;
  final PaletteType paletteType;
  final int? currentIndex;
  final Function(Color)? mainColor;
  final Function(Color)? backgroundColor;
  final Function(Color)? secondColor;

  @override
  State<AColorPicker> createState() => _AColorPickerState();
}

class _AColorPickerState extends State<AColorPicker> {
  late VendorBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of<VendorBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.seven),
      height: Dimensions.height * .34,
      decoration: const BoxDecoration(
        color: Colora.lightBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.fifteen),
          topRight: Radius.circular(Dimensions.fifteen),
        ),
      ),
      child: Column(
        children: [
          widget.titleWidget,
          Dimensions.seven.height,
          Container(
            padding: const EdgeInsets.only(top: Dimensions.ten),
            decoration: BoxDecoration(
              color: Colora.primaryColor,
              borderRadius: BorderRadius.circular(Dimensions.fifteen),
            ),
            child: ColorPicker(
              paletteType: widget.paletteType,
              hexInputBar: false,
              colorPickerWidth: Dimensions.width * .7,
              pickerAreaBorderRadius: BorderRadius.circular(Dimensions.fifteen),
              onColorChanged: (Color color) {
                if (widget.currentIndex == 0) {
                  widget.mainColor!(color);
                  bloc.add(SelectTopColor(topColor: color));
                }
                if (widget.currentIndex == 1) {
                  widget.secondColor!(color);
                  bloc.add(SelectSecondColor(secondColor: color));
                }
                if (widget.currentIndex == 2) {
                  widget.backgroundColor!(color);
                  bloc.add(SelectBackColor(backColor: color));
                }
              },
              displayThumbColor: true,
              portraitOnly: true,
              enableAlpha: false,
              labelTypes: const [],
              // labelTextStyle: const TextStyle(color: Colora.scaffold_),
              pickerAreaHeightPercent: .5,
              pickerColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class BColorPicker extends StatefulWidget {
  const BColorPicker({
    super.key,
    required this.titleWidget,
    this.paletteType = PaletteType.hsvWithHue,
    this.currentIndex = 0,
    this.fontColor,
    this.fontSecondColor,
  });

  final Widget titleWidget;
  final PaletteType paletteType;
  final int currentIndex;

  final Function(Color)? fontColor;
  final Function(Color)? fontSecondColor;

  @override
  State<BColorPicker> createState() => _BColorPickerState();
}

class _BColorPickerState extends State<BColorPicker> {
  late VendorBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of<VendorBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.seven),
      height: Dimensions.height * .35,
      decoration: const BoxDecoration(
        color: Colora.lightBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.fifteen),
          topRight: Radius.circular(Dimensions.fifteen),
        ),
      ),
      child: Column(
        children: [
          widget.titleWidget,
          Dimensions.seven.height,
          Container(
            padding: const EdgeInsets.only(top: Dimensions.ten),
            decoration: BoxDecoration(
              color: Colora.primaryColor,
              borderRadius: BorderRadius.circular(Dimensions.fifteen),
            ),
            child: ColorPicker(
              paletteType: widget.paletteType,
              hexInputBar: false,
              colorPickerWidth: Dimensions.width * .7,
              pickerAreaBorderRadius: BorderRadius.circular(Dimensions.fifteen),
              onColorChanged: (Color color) {
                if (widget.currentIndex == 1) {
                  widget.fontColor!(color);
                  bloc.add(SelectFontColor(fontColor: color));
                } else if (widget.currentIndex == 2) {
                  widget.fontSecondColor!(color);
                  bloc.add(SelectSecondFontColor(secondFontColor: color));
                }
              },
              displayThumbColor: false,
              portraitOnly: false,
              // showLabel: false,
              enableAlpha: false,
              labelTypes: const [],
              pickerAreaHeightPercent: .5,
              pickerColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
