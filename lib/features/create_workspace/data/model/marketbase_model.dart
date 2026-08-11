class MarketBaseModel {
  final String market;
  final String type;
  final String businessId;
  final String name;
  final String description;
  final String nationalCode;
  final String subCategory;
  final String slogan;

  MarketBaseModel({
    required this.market,
    required this.type,
    required this.businessId,
    required this.name,
    required this.description,
    required this.nationalCode,
    required this.subCategory,
    required this.slogan,
  });

  factory MarketBaseModel.fromJson(Map<String, dynamic> json) {
    return MarketBaseModel(
      market: json['market'],
      type: json['type'],
      businessId: json['business_id'],
      name: json['name'],
      description: json['description'],
      nationalCode: json['national_code'] ?? "",
      subCategory: json['sub_category'],
      slogan: json['slogan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'market': market,
      'type': type,
      'business_id': businessId,
      'name': name,
      'description': description,
      'national_code': nationalCode,
      'sub_category': subCategory,
      'slogan': slogan,
    };
  }
}
