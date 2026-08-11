// این مدل برای قسمت لود محصولات از اندپوینت `owner/product/list/` استفاده میشود
// به خاطر این اندپوینت از ایدی استفاده میکنه به جای مارکت به عنوان کلید مپ

class ThemeProductModel {
  final String id;
  final String name;
  final String description;
  final String mainPrice;
  final String stock;
  final List<ProductImage> images;
  final String? themeIndex;

  ThemeProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.mainPrice,
    required this.stock,
    required this.images,
    this.themeIndex,
  });

  factory ThemeProductModel.fromJson(Map<String, dynamic> json) {
    return ThemeProductModel(
      id: json['id'],
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      mainPrice: json['main_price'].toString(),
      stock: json['stock'].toString(),
      images:
          (json['images'] as List<dynamic>)
              .map((img) => ProductImage.fromJson(img))
              .toList(),
      themeIndex: json['theme_index'],
    );
  }
}

class ProductImage {
  final String id;
  final String image;

  ProductImage({required this.id, required this.image});

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(id: json['id'], image: json['image']);
  }
}
