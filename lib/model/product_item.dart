class ProductItem {
  final String id;
  final String name;
  final String image;
  final double price;
  final int quantity;
  final String description;
  bool favorite;

  ProductItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.description,
    required this.favorite,
  });

  copyWith({
    String? id,
    String? name,
    String? image,
    double? price,
    int? quantity,
    String? description,
    bool? favorite,
  }) {
    return ProductItem(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        description: description ?? this.description,
        favorite: favorite ?? this.favorite);
  }
}
