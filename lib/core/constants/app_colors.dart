part of "./constants.dart";

abstract class Colora {
  Colora._();

  //bottom colors
  static const primaryColor = Color.fromARGB(255, 10, 25, 146);
  static const lightBlue = Color.fromARGB(255, 37, 55, 197);

  /// blue text fields colors
  static const borderAvatar = Color.fromARGB(255, 64, 90, 235);
  static const borderTag = Color.fromARGB(255, 8, 23, 136);
  static const backgroundDialog = Color.fromARGB(200, 9, 24, 143);
  static const scaffold_ = Color.fromARGB(200, 239, 240, 246);
  static const backgroundSwitch = Color.fromARGB(255, 82, 100, 243);

  /// white color
  static const scaffold = Color.fromARGB(255, 255, 252, 255);
  static var appBarForgroundColor = const Color.fromARGB(
    255,
    10,
    25,
    146,
  ).withValues(alpha: 0.64);
  static var posterForgroundColor = const Color.fromARGB(
    255,
    10,
    25,
    146,
  ).withValues(alpha: 0.30);
  static const shadow = Color.fromARGB(122, 0, 0, 0);
}
