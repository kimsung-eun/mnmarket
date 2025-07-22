class ProductModel {
  final int id;
  final String name;
  final int price;
  final String imageUrl;
  final String description;
  final String category; // 'dog' 또는 'cat'

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
  });
}
