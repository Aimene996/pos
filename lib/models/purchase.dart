// purchase.dart
import 'package:hive/hive.dart';

part 'purchase.g.dart';

@HiveType(typeId: 1)
class Purchase {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String productId;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final int quantity;

  @HiveField(4)
  final DateTime date;

  Purchase(
      {required this.id,
      required this.productId,
      required this.price,
      required this.quantity,
      required this.date});
}
