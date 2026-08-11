part of 'theme_bloc.dart';

enum ThemeStatus { initial, loading, success, failure }

class ThemeState {
  final Color topColor;
  final Color backColor;
  final Color secondColor;

  final Color fontColor;
  final Color secondFontColor;
  final String fontFamily;

  const ThemeState({
    required this.topColor,
    required this.backColor,
    required this.secondColor,

    required this.fontColor,
    required this.secondFontColor,
    required this.fontFamily,
  });

  factory ThemeState.initial() {
    return const ThemeState(
      topColor: Color.fromARGB(255, 10, 25, 146),
      backColor: Color.fromARGB(255, 255, 255, 255),
      secondColor: Color.fromARGB(255, 37, 55, 197),

      fontColor: Color.fromARGB(255, 255, 255, 255),
      secondFontColor: Color.fromARGB(255, 10, 25, 146),
      fontFamily: '',
    );
  }

  ThemeState copyWith({
    Color? topColor,
    Color? backColor,
    Color? secondColor,

    Color? fontColor,
    Color? secondFontColor,
    String? fontFamily,
  }) {
    return ThemeState(
      topColor: topColor ?? this.topColor,
      backColor: backColor ?? this.backColor,
      secondColor: secondColor ?? this.secondColor,

      fontColor: fontColor ?? this.fontColor,
      secondFontColor: secondFontColor ?? this.secondFontColor,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }
}
