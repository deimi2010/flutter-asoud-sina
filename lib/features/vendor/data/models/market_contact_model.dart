import 'package:hive/hive.dart';

class MarketContactModel extends HiveObject {
  int? id;

  int? market;

  String? firstMobileNumber;

  String? secondMobileNumber;

  String? telephone;

  String? fax;

  String? email;

  String? websiteUrl;

  String? instagramId;

  String? telegramId;

  MarketContactModel({
    this.id, // مقدار id در Hive باید هنگام ذخیره مقداردهی شود
    this.market,
    this.firstMobileNumber,
    this.secondMobileNumber,
    this.telephone,
    this.fax,
    this.email,
    this.websiteUrl,
    this.instagramId,
    this.telegramId,
  });

  factory MarketContactModel.fromJson(Map<String, dynamic> json) {
    return MarketContactModel(
      market: json['market'],
      firstMobileNumber: json['first_mobile_number'],
      secondMobileNumber: json['second_mobile_number'],
      telephone: json['telephone'],
      fax: json['fax'],
      email: json['email'],
      websiteUrl: json['website_url'],
      instagramId: json['instagram_id'],
      telegramId: json['telegram_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'market': market,
      'first_mobile_number': firstMobileNumber,
      'second_mobile_number': secondMobileNumber,
      'telephone': telephone,
      'fax': fax,
      'email': email,
      'website_url': websiteUrl,
      'instagram_id': instagramId,
      'telegram_id': telegramId,
    };
  }
}
