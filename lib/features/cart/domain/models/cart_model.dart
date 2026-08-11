class CartModel {
  final String id;
  final List<CartItemModel> items;
  final double totalPrice;
  final int totalItems;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CartModel({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.totalItems,
    this.createdAt,
    this.updatedAt,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id']?.toString() ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map(
                (item) => CartItemModel.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList() ??
          [],
      totalPrice: double.tryParse(
              json['total_price']?.toString() ?? '0') ??
          0,
      totalItems: int.tryParse(
              json['total_items']?.toString() ?? '0') ??
          0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}


class CartItemModel {
  final String id;
  final String? productId;
  final String? productName;
  final String? productImage;
  final String? affiliateId;
  final String? affiliateName;
  final int quantity;
  final double? price;
  final double? totalPrice;

  CartItemModel({
    required this.id,
    this.productId,
    this.productName,
    this.productImage,
    this.affiliateId,
    this.affiliateName,
    required this.quantity,
    this.price,
    this.totalPrice,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id']?.toString() ?? '',

      productId:
          json['product']?['id']?.toString(),

      productName:
          json['product']?['name']?.toString() ??
          json['product_name']?.toString(),

      productImage:
          json['product']?['images'] != null &&
          (json['product']['images'] as List).isNotEmpty
              ? json['product']['images'][0]['image']
                  ?.toString()
              : null,

      affiliateId:
          json['affiliate']?['id']?.toString(),

      affiliateName:
          json['affiliate']?['name']?.toString() ??
          json['affiliate_name']?.toString(),

      quantity:
          int.tryParse(
            json['quantity']?.toString() ?? '1',
          ) ??
          1,

      price:
          double.tryParse(
            json['price']?.toString() ?? '0',
          ),

      totalPrice:
          double.tryParse(
            json['total_price']?.toString() ?? '0',
          ),
    );
  }

  String get itemName => productName ?? affiliateName ?? 'Unknown';

  String? get itemImage => productImage;
}
