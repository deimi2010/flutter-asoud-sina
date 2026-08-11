import 'dart:convert';

class InquiryCardModel {
  final String inquiryTitle;
  final String inquiryDescription;
  final int inquiryDeadline;
  final int inquiryId;
  final DateTime inquiryDate;
  final String inquiryStatus;
  InquiryCardModel({
    required this.inquiryTitle,
    required this.inquiryDescription,
    required this.inquiryDeadline,
    required this.inquiryId,
    required this.inquiryDate,
    required this.inquiryStatus,
  });

  factory InquiryCardModel.fromMap(Map<String, dynamic> map) {
    return InquiryCardModel(
      inquiryTitle: map['inquiryTitle'] as String,
      inquiryDescription: map['inquiryDescription'] as String,
      inquiryDeadline: map['inquiryDeadline'] as int,
      inquiryId: map['inquiryId'] as int,
      inquiryDate: DateTime.fromMillisecondsSinceEpoch(
        map['inquiryDate'] as int,
      ),
      inquiryStatus: map['inquiryStatus'] as String,
    );
  }

  factory InquiryCardModel.fromJson(String source) =>
      InquiryCardModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
