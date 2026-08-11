class ThemeModel{

  String? color;
  String? backgroundColor;
  String? secondaryColor;

  String? font;
  String? fontColor;
  String? secondaryFontColor;

  ThemeModel({

    this.color,
    this.backgroundColor,
    this.secondaryColor,

    this.font,
    this.fontColor,
    this.secondaryFontColor

  });

  ThemeModel.fromJson(Map<String, dynamic> json) {

    color = json['color'];
    backgroundColor = json['background_color'];
    secondaryColor = json['secondary_color'];

    font = json['font'];
    fontColor = json['font_color'];
    secondaryFontColor = json['secondary_font_color'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['color'] = color;
    data['background_color'] = backgroundColor;
    data['secondary_color'] = secondaryColor;

    data['font'] = font;
    data['font_color'] = fontColor;
    data['secondary_font_color'] = secondaryFontColor;

    return data;
  }

}