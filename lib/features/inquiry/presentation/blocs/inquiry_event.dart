part of 'inquiry_bloc.dart';

sealed class InquiryEvent {
  const InquiryEvent();
}

class InquirySubmit extends InquiryEvent {
  const InquirySubmit({
    required this.inquiryType,
    required this.inquiryTitle,
    this.inquiryDescription,
    this.inquiryDetails,
    required this.inquiryCategory,
    this.inquiryAmount,
    this.inquiryUnit,
    this.inquiryName,
    this.inquiryImages,
  });

  final String inquiryType;
  final String inquiryTitle;
  final String? inquiryDescription;
  final String? inquiryDetails;
  final String inquiryCategory;
  final double? inquiryAmount;
  final String? inquiryUnit;
  final String? inquiryName;
  final List<File>? inquiryImages;
}

class InquiryTypeSwitch extends InquiryEvent {
  const InquiryTypeSwitch(this.inquiryType);

  final String inquiryType;
}

class InquiryAddImage extends InquiryEvent {
  const InquiryAddImage(this.image);

  final File image;
}

class InquiryRemoveImage extends InquiryEvent {
  const InquiryRemoveImage(this.index);

  final int index;
}

class InquiryAddDeadline extends InquiryEvent {
  const InquiryAddDeadline(this.deadline);

  final DateTime deadline;
}

class InquiryAddCity extends InquiryEvent {
  const InquiryAddCity(this.city);

  final String city;
}
