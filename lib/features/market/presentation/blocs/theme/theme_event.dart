part of 'theme_bloc.dart';

sealed class ThemeEvent {
  const ThemeEvent();
}

//----------------- color ------------------
class SelectTopColor extends ThemeEvent {
  final Color topColor;
  const SelectTopColor({required this.topColor});
}

class SelectSecondColor extends ThemeEvent {
  final Color secondColor;
  const SelectSecondColor({required this.secondColor});
}

class SelectBackColor extends ThemeEvent {
  final Color backColor;
  const SelectBackColor({required this.backColor});
}

//----------------- font ------------------
class SelectFontColor extends ThemeEvent {
  final Color fontColor;
  const SelectFontColor({required this.fontColor});
}

class SelectSecondFontColor extends ThemeEvent {
  final Color secondFontColor;
  const SelectSecondFontColor({required this.secondFontColor});
}

class SelectFontFamily extends ThemeEvent {
  final String fontFamily;
  const SelectFontFamily({required this.fontFamily});
}

//----------------- theme ------------------
class SelectTheme extends ThemeEvent {
  final int marketId;
  final String? color;
  final String? font;
  final String? fontColor;

  const SelectTheme({
    required this.marketId,
    this.color,
    this.font,
    this.fontColor,
  });
}
