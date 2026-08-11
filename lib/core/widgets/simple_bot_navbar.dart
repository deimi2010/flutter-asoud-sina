// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:asood/core/constants/constants.dart';
import 'package:flutter/material.dart';

class SimpleBotNavBar extends StatelessWidget {
  const SimpleBotNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.0,
      child: CustomPaint(
        painter: HalfCirclePainter(),
        child: Container(
          margin: EdgeInsets.only(top: Dimensions.height * 0.04),
          child: const Center(
            child: Text(
              "Asud @ 2021",
              style: TextStyle(color: Colora.scaffold),
            ),
          ),
        ),
      ),
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = Colora.primaryColor
          ..style = PaintingStyle.fill;

    // double radius = size.height;

    canvas.drawCircle(Offset(size.width / 2, 6 * size.height), 500, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
