part of 'inquiry_bloc.dart';

class InquiryState {
  const InquiryState({
    required this.status,
    required this.inquiryType,
    required this.inquiryTitle,
    required this.inquiryDescription,
    required this.inquiryDetails,
    required this.inquiryCategory,
    required this.inquiryAmount,
    required this.inquiryUnit,
    required this.inquiryName,
    required this.inquirySearch,
    required this.inquiryList,
    required this.inquiryImages,
    required this.inquiryDeadline,
    required this.inquiryCity,
  });

  final CWSStatus status;
  // ثبت استعلام
  final String inquiryType;
  final String inquiryTitle;
  final String inquiryDescription;
  final String inquiryDetails;
  final String inquiryCategory;
  final double inquiryAmount;
  final String inquiryUnit;
  final String inquiryName;
  final List<File> inquiryImages;
  // لیست استعلام
  final String inquirySearch;
  final List<InquiryCardModel> inquiryList;
  // تایید استعلام
  final DateTime inquiryDeadline;
  final String inquiryCity;

  factory InquiryState.initial() {
    return InquiryState(
      status: CWSStatus.initial,
      inquiryType: 'product',
      inquiryTitle: '',
      inquiryDescription: '',
      inquiryDetails: '',
      inquiryCategory: '',
      inquiryAmount: 0.0,
      inquiryUnit: '',
      inquiryName: '',
      inquirySearch: '',
      inquiryList: const [],
      inquiryImages: const [],
      inquiryCity: '',
      inquiryDeadline: DateTime.now(),
    );
  }

  InquiryState copyWith({
    CWSStatus? status,
    String? inquiryType,
    String? inquiryTitle,
    String? inquiryDescription,
    String? inquiryDetails,
    String? inquiryCategory,
    double? inquiryAmount,
    String? inquiryUnit,
    String? inquiryName,
    String? inquirySearch,
    List<InquiryCardModel>? inquiryList,
    List<File>? inquiryImages,
    String? inquiryCity,
    DateTime? inquiryDeadline,
  }) {
    return InquiryState(
      status: status ?? this.status,
      inquiryType: inquiryType ?? this.inquiryType,
      inquiryTitle: inquiryTitle ?? this.inquiryTitle,
      inquiryDescription: inquiryDescription ?? this.inquiryDescription,
      inquiryDetails: inquiryDetails ?? this.inquiryDetails,
      inquiryCategory: inquiryCategory ?? this.inquiryCategory,
      inquiryAmount: inquiryAmount ?? this.inquiryAmount,
      inquiryUnit: inquiryUnit ?? this.inquiryUnit,
      inquiryName: inquiryName ?? this.inquiryName,
      inquirySearch: inquirySearch ?? this.inquirySearch,
      inquiryList: inquiryList ?? this.inquiryList,
      inquiryImages: inquiryImages ?? this.inquiryImages,
      inquiryCity: inquiryCity ?? this.inquiryCity,
      inquiryDeadline: inquiryDeadline ?? this.inquiryDeadline,
    );
  }

  @override
  List<Object> get props {
    return [
      status,
      inquiryType,
      inquiryTitle,
      inquiryDescription,
      inquiryDetails,
      inquiryCategory,
      inquiryAmount,
      inquiryUnit,
      inquiryName,
      inquirySearch,
      inquiryList,
      inquiryImages,
      inquiryCity,
      inquiryDeadline,
    ];
  }

  @override
  bool get stringify => true;
}
