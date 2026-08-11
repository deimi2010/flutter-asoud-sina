import 'package:asood/features/market/data/model/theme_model_model.dart';

class TemplateModel {
  final String id;
  final String name;
  final int order;
  final List<ThemeProductModel> products;

  TemplateModel({
    required this.id,
    required this.name,
    required this.order,
    required this.products,
  });

  factory TemplateModel.fromJson(Map<String, dynamic> json) {
    return TemplateModel(
      id: json['id'],
      name: json['name'],
      order: json['order'],
      products:
          (json['products'] as List<dynamic>)
              .map((item) => ThemeProductModel.fromJson(item))
              .toList(),
    );
  }
}
