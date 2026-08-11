class CartModel {
  final String id;
  final List<CartItemModel> items;
  final double totalPrice;
  final int totalItems;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartModel({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.totalItems,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id']?.toString() ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => CartItemModel.fromJson(item))
              .toList() ??
          [],
      totalPrice: (json['total_price'] ?? 0.0).toDouble(),
      totalItems: json['total_items'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'total_price': totalPrice,
      'total_items': totalItems,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
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
      productId: json['product']?['id']?.toString(),
      productName: json['product']?['name']?.toString() ??
          json['product_name']?.toString(),
      productImage: json['product']?['images'] != null &&
              (json['product']?['images'] as List).isNotEmpty
          ? json['product']?['images']?[0]?['image']?.toString()
          : null,
      affiliateId: json['affiliate']?['id']?.toString(),
      affiliateName: json['affiliate']?['name']?.toString() ??
          json['affiliate_name']?.toString(),
      quantity: json['quantity'] ?? 1,
      price: json['price']?.toDouble() ?? json['product']?['main_price']?.toDouble(),
      totalPrice: json['total_price']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'affiliate_id': affiliateId,
      'affiliate_name': affiliateName,
      'quantity': quantity,
      'price': price,
      'total_price': totalPrice,
    };
  }

  String get itemName => productName ?? affiliateName ?? 'Unknown';
  String? get itemImage => productImage;
}

