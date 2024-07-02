// models/product.dart
import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double productionPrice;

  @HiveField(3)
  final int quantity;

  @HiveField(4)
  final List<int> boxSizes;

  @HiveField(5)
  final List<String> barcodes;

  Product({
    required this.id,
    required this.name,
    required this.productionPrice,
    required this.quantity,
    required this.boxSizes,
    required this.barcodes,
  });

  Product copyWith({
    String? id,
    String? name,
    double? productionPrice,
    int? quantity,
    List<int>? boxSizes,
    List<String>? barcodes,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      productionPrice: productionPrice ?? this.productionPrice,
      quantity: quantity ?? this.quantity,
      boxSizes: boxSizes ?? this.boxSizes,
      barcodes: barcodes ?? this.barcodes,
    );
  }
}
