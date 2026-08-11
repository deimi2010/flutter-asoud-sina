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
              (json['product']['images'] as List).isNotEmpty
          ? json['product']['images'][0]['image']?.toString()
          : null,
      affiliateId: json['affiliate']?['id']?.toString(),
      affiliateName: json['affiliate']?['name']?.toString() ??
          json['affiliate_name']?.toString(),
      quantity: int.tryParse(json['quantity']?.toString() ?? '1') ?? 1,
      price: double.tryParse(
              json['price']?.toString() ??
              json['product']?['main_price']?.toString() ??
              '0') ??
          0,
      totalPrice: double.tryParse(json['total_price']?.toString() ?? '0'),
    );
  }
}
