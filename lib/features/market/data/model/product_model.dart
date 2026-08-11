import 'package:image_picker/image_picker.dart';

class ProductModel {
  String? product;
  String? market;
  String? type;
  String? name;
  String? description;
  String? technicalDetail;
  String? subCategory;
  List<String>? keywords;
  int? stock;
  int? price;
  int? mainPrice;
  int? colleaguePrice;
  int? marketerPrice;
  int? maximumSellPrice;
  String? publishStatus;
  String? requiredProduct;
  String? giftProduct;
  bool? isMarketer;
  bool? isRequirement;
  String? tag;
  String? tagPosition;
  String? sellType;
  int? shipCost;
  String? shipCostPayType;
  List<XFile>? image;

  ProductModel({
    this.market,
    this.product,
    this.type,
    this.name,
    this.description,
    this.technicalDetail,
    this.subCategory,
    this.keywords,
    this.stock,
    this.price,
    this.requiredProduct,
    this.giftProduct,
    this.isMarketer,
    this.sellType,
    this.shipCost,
    this.shipCostPayType,
    this.publishStatus,
    this.tagPosition,
    this.mainPrice,
    this.colleaguePrice,
    this.marketerPrice,
    this.maximumSellPrice,
    this.isRequirement,
    this.tag,
    this.image,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    market = json['market'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['market'] = market;
    data['type'] = type;
    data['name'] = name;
    data['description'] = description;
    data['technical_detail'] = technicalDetail;
    data['sub_category'] = subCategory;
    data['keywords'] = keywords;
    data['stock'] = stock;
    data['price'] = price;
    data['gift_product'] = giftProduct ?? "";
    data['required_product'] = requiredProduct ?? "";
    data['is_marketer'] = isMarketer;
    data['sell_type'] = sellType;
    data['ship_cost'] = shipCost;
    data['ship_cost_pay_type'] = shipCostPayType;
    data['status'] = publishStatus;
    data['tag_position'] = tagPosition;
    data['main_price'] = mainPrice;
    if (colleaguePrice != null) {
      data['colleague_price'] = colleaguePrice;
    }
    if (marketerPrice != null) {
      data['marketer_price'] = marketerPrice;
    }
    if (maximumSellPrice != null) {
      data['maximum_sell_price'] = maximumSellPrice;
    }
    data['is_requirement'] = isRequirement;
    data['tag'] = tag;

    return data;
  }
}
