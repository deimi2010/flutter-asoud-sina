part of "./constants.dart";

extension SizedBoxExtention on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}
