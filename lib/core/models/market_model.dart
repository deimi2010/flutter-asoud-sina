import 'package:asood/core/models/theme_model.dart';

class MarketModel {
  String? id;
  String? businessId;
  String? name;
  String? subCategory;
  String? subCategoryTitle;
  String? status;
  bool? isPaid;
  String? createdAt;
  String? inactiveUrl;
  String? queueUrl;
  String? logoImg;
  String? backgroundImg;

  ThemeModel? theme;

  MarketModel({
    this.id,
    this.businessId,
    this.name,
    this.subCategory,
    this.subCategoryTitle,
    this.status,
    this.isPaid,
    this.createdAt,
    this.inactiveUrl,
    this.queueUrl,
    this.logoImg,
    this.backgroundImg,
    this.theme,
  });

  MarketModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    name = json['name'];
    subCategory = json['sub_category'];
    subCategoryTitle = json['sub_category_title'];
    status = json['status'];
    isPaid = json['is_paid'];
    createdAt = json['created_at'];
    inactiveUrl = json['inactive_url'];
    queueUrl = json['queue_url'];
    logoImg = json['logo_img'];
    backgroundImg = json['background_img'];
    theme = json['theme'] != null ? ThemeModel.fromJson(json['theme']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['business_id'] = businessId;
    data['name'] = name;
    data['sub_category'] = subCategory;
    data['sub_category_title'] = subCategoryTitle;
    data['status'] = status;
    data['is_paid'] = isPaid;
    data['created_at'] = createdAt;
    data['inactive_url'] = inactiveUrl;
    data['queue_url'] = queueUrl;
    data['logo_img'] = logoImg;
    data['background_img'] = backgroundImg;
    if (theme != null) {
      data['theme'] = theme!.toJson();
    }
    return data;
  }
}
