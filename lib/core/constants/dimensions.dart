part of "./constants.dart";

abstract class Dimensions {
  Dimensions._();

  static const double five = 5;
  static double width =
      MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.implicitView!,
      ).size.width;
  static double height =
      MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.implicitView!,
      ).size.height;
  static const double seven = 7;
  static const double ten = 10;
  static const double fifteen = 15;
  static const double twenty = 20;
  static const double fourty = 40;
  static const double khorisontal = 12;
}
