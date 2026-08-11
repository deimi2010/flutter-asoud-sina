part of 'vendor_bloc.dart';

class VendorEvent {
  const VendorEvent();
}

//----------------- logo ------------------
class AddLogoEvent extends VendorEvent {
  final String id;
  final XFile logoImage;

  const AddLogoEvent({required this.id, required this.logoImage});
}

class DeleteLogoEvent extends VendorEvent {
  final String id;

  const DeleteLogoEvent({required this.id});
}

//----------------- background ------------------
class AddBackgroundEvent extends VendorEvent {
  final String id;
  final XFile backgroundImage;

  const AddBackgroundEvent({required this.id, required this.backgroundImage});
}

class DeleteBackgroundEvent extends VendorEvent {
  final String id;

  const DeleteBackgroundEvent({required this.id});
}

//----------------- slider ------------------
class LoadSlider extends VendorEvent {
  final String marketId;
  const LoadSlider({required this.marketId});
}

class AddSliderEvent extends VendorEvent {
  final String id;
  final XFile sliderImage;

  const AddSliderEvent({required this.id, required this.sliderImage});
}

class EditSliderEvent extends VendorEvent {
  final String id;
  final XFile sliderImage;

  const EditSliderEvent({required this.id, required this.sliderImage});
}

class DeleteSliderEvent extends VendorEvent {
  final String id;

  const DeleteSliderEvent({required this.id});
}

//----------------- color ------------------
class SelectTopColor extends VendorEvent {
  final Color topColor;
  const SelectTopColor({required this.topColor});
}

class SelectSecondColor extends VendorEvent {
  final Color secondColor;
  const SelectSecondColor({required this.secondColor});
}

class SelectBackColor extends VendorEvent {
  final Color backColor;
  const SelectBackColor({required this.backColor});
}

//----------------- font ------------------
class SelectFontColor extends VendorEvent {
  final Color fontColor;
  const SelectFontColor({required this.fontColor});
}

class SelectSecondFontColor extends VendorEvent {
  final Color secondFontColor;
  const SelectSecondFontColor({required this.secondFontColor});
}

class SelectFontFamily extends VendorEvent {
  final String fontFamily;
  const SelectFontFamily({required this.fontFamily});
}

//----------------- theme ------------------
class SelectTheme extends VendorEvent {
  final String marketId;
  final String? color;
  final String? backgroundColor;
  final String? secondaryColor;

  final String? font;
  final String? fontColor;
  final String? fontSecondaryColor;

  const SelectTheme({
    required this.marketId,
    this.color,
    this.backgroundColor,
    this.secondaryColor,

    this.font,
    this.fontColor,
    this.fontSecondaryColor,
  });
}

//----------------- comments ------------------
class LoadComments extends VendorEvent {
  final int marketId;
  const LoadComments({required this.marketId});
}
