import 'package:asood/core/constants/constants.dart';
import 'package:asood/features/market/presentation/blocs/add_product/add_product_bloc.dart';
import 'package:flutter/material.dart';

class PositionSelectorWidget extends StatelessWidget {
  final PositionEnum selectedPosition;
  final bool? whiteMode;
  final Function(PositionEnum) onChanged;
  const PositionSelectorWidget({
    super.key,
    required this.selectedPosition,
    required this.onChanged,
    this.whiteMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.symmetric(vertical: Dimensions.height * 0.01),
          child: Text(
            'محل قرارگیری :',
            style: TextStyle(
              color: whiteMode == true ? Colora.scaffold : Colora.primaryColor,
              fontSize: Dimensions.width * 0.035,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              PositionEnum.values.map((position) {
                return Expanded(
                  child: Row(
                    spacing: 5,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              _positionToString(position),
                              style: TextStyle(
                                color:
                                    whiteMode == true
                                        ? Colora.scaffold
                                        : Colora.primaryColor,
                                fontSize: Dimensions.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Radio<PositionEnum>(
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),

                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,

                          fillColor: WidgetStateProperty.resolveWith<Color>((
                            Set<WidgetState> states,
                          ) {
                            if (states.contains(WidgetState.selected)) {
                              return whiteMode == true
                                  ? Colora.scaffold
                                  : Colora.primaryColor;
                            }
                            return whiteMode == true
                                ? Colora.scaffold
                                : Colora.primaryColor;
                          }),

                          value: position,
                          groupValue: selectedPosition,
                          onChanged: (value) {
                            if (value != null) {
                              onChanged(value);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  /// تابعی برای تبدیل `enum` به متن فارسی
  String _positionToString(PositionEnum position) {
    switch (position) {
      case PositionEnum.topLeft:
        return 'چپ بالا';
      case PositionEnum.bottomLeft:
        return 'چپ پایین';
      case PositionEnum.topRight:
        return 'راست بالا';
      case PositionEnum.bottomRight:
        return 'راست پایین';
    }
  }
}
