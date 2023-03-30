import 'package:my_app/model/product_item.dart';

class OrderItem {
  final String id;
  final String name;
  final double price;
  final List<ProductItem> products;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderItem({
    required this.id,
    required this.name,
    required this.products,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });
}
