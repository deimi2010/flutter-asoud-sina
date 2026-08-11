part of "./constants.dart";

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Drawing the curved path
    var paint =
        Paint()
          ..color = Colora.primaryColor
          ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.1,
      size.width,
      size.height * 0.4,
    );
    // path.quadraticBezierTo(
    //     size.width * 0.5, size.height * 0.1, size.width, size.height * 0.4);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);

    // Drawing circles on the curved path
    // var circlePaint =
    //     Paint()
    //       ..color = Colora.primaryColor
    //       ..style = PaintingStyle.fill;

    // var circleBorderPaint =
    //     Paint()
    //       ..color = Colors.white
    //       ..style = PaintingStyle.stroke
    //       ..strokeWidth = 5;

    // Circle 3 (larger)
    // double circle3X = size.width * 0.87;
    // double circle3X = size.width * 0.89;
    // // double circle3Y = size.height * 0.6;
    // double circle3Y = size.height * 0.5;
    // double circle3Radius = 27.0;
    // canvas.drawCircle(Offset(circle3X, circle3Y), circle3Radius, circlePaint);
    // canvas.drawCircle(
    //   Offset(circle3X, circle3Y),
    //   circle3Radius,
    //   circleBorderPaint,
    // );

    // Circle 3 (larger)
    // double circle2X = size.width * 0.7;
    // double circle2X = size.width * 0.71;
    // // double circle2Y = size.height * 0.5;
    // double circle2Y = size.height * 0.4;
    // double circle2Radius = 30;
    // canvas.drawCircle(Offset(circle2X, circle2Y), circle2Radius, circlePaint);
    // canvas.drawCircle(
    //   Offset(circle2X, circle2Y),
    //   circle2Radius,
    //   circleBorderPaint,
    // );

    // Circle 3 (larger)
    // double circle3x = size.width * 0.5;
    // // double circle1Y = size.height * 0.45;
    // double circle1Y = size.height * 0.3;
    // double circle1Radius = 35.0;
    // canvas.drawCircle(Offset(circle3x, circle1Y), circle1Radius, circlePaint);
    // canvas.drawCircle(
    //   Offset(circle3x, circle1Y),
    //   circle1Radius,
    //   circleBorderPaint,
    // );

    // double circle4x = size.width * 0.32;
    // double circle4x = size.width * 0.29;
    // // double circle4Y = size.height * 0.5;
    // double circle4Y = size.height * 0.4;
    // double circle4Radius = 30.0;
    // canvas.drawCircle(Offset(circle4x, circle4Y), circle4Radius, circlePaint);
    // canvas.drawCircle(
    //   Offset(circle4x, circle4Y),
    //   circle4Radius,
    //   circleBorderPaint,
    // );

    // double circle5x = size.width * 0.15;
    // double circle5x = size.width * 0.11;
    // // double circle5Y = size.height * 0.6;
    // double circle5Y = size.height * 0.5;
    // double circle5Radius = 27.0;
    // canvas.drawCircle(Offset(circle5x, circle5Y), circle5Radius, circlePaint);
    // canvas.drawCircle(
    //   Offset(circle5x, circle5Y),
    //   circle5Radius,
    //   circleBorderPaint,
    // );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CCurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Drawing the curved path
    var paint =
        Paint()
          ..color = Colora.primaryColor
          ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.4);
    // path.quadraticBezierTo(
    //     size.width * 0.5, -35, size.width, size.height * 0.4);
    path.quadraticBezierTo(
      size.width * 0.5,
      -25,
      size.width,
      size.height * 0.4,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
