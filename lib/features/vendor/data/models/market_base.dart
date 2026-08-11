import 'dart:convert';
import 'package:hive/hive.dart';

class MarketBaseModel extends HiveObject {
  int? id;

  final String marketType;

  final String businessId;

  final String name;

  final String description;

  final int subCategory;

  final String slogan;

  MarketBaseModel({
    this.id,
    required this.marketType,
    required this.businessId,
    required this.name,
    required this.description,
    required this.subCategory,
    required this.slogan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'marketType': marketType,
      'businessId': businessId,
      'name': name,
      'description': description,
      'subCategory': subCategory,
      'slogan': slogan,
    };
  }

  factory MarketBaseModel.fromMap(Map<String, dynamic> map) {
    return MarketBaseModel(
      id: map['id'] as int?,
      marketType: map['marketType'] as String,
      businessId: map['businessId'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      subCategory: map['subCategory'] as int,
      slogan: map['slogan'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MarketBaseModel.fromJson(String source) =>
      MarketBaseModel.fromMap(json.decode(source));
}
