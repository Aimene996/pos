// models/sale.dart

import 'package:hive/hive.dart';

part 'sale.g.dart';

@HiveType(typeId: 2)
class Sale extends HiveObject {
  @HiveField(0)
  final String clientName;

  @HiveField(1)
  final double salePrice;

  @HiveField(2)
  final int quantity;

  @HiveField(3)
  bool paid; // Remove final here

  @HiveField(4)
  final DateTime date;

  @HiveField(5)
  final String id;

  Sale(
      {required this.clientName,
      required this.salePrice,
      required this.quantity,
      required this.paid,
      required this.date,
      required this.id});
}
