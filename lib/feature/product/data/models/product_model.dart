class ProductModel {
  final String id;
  final String name;
  final String description;
  final num price;
  final String? imageUrl;
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.createdAt,
    this.imageUrl,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        price: (map['price'] as num).toDouble(),
        imageUrl: map['image_url'],
        createdAt: DateTime.parse(map['created_at']),
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'description': description,
        'price': price,
        'image_url': imageUrl,
      };
}
