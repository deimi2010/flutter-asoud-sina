part of "./constants.dart";

//i create a custom decoration for box and
const double cKmanualradius = 10;
const double bigRadius = 15;
const double largRadius = 20;
const double buttonRadius = 50;

BoxDecoration decos = BoxDecoration(
  color: Colora.primaryColor,
  borderRadius: BorderRadius.circular(cKmanualradius),
);

class Deco {
  static List<BoxShadow> kshadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.3),
      spreadRadius: 1,
      blurRadius: 7,
      offset: const Offset(0, 1), // changes position of shadow
      // changes position of shadow
    ),
  ];
}
