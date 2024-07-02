// models/client.dart
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'sellers.g.dart';

@HiveType(typeId: 4)
class Client {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<ClientBox> boxes;

  Client({
    required this.id,
    required this.name,
    required this.boxes,
  });

  factory Client.initial() {
    return Client(
      id: const Uuid().v4(),
      name: '',
      boxes: [],
    );
  }
}

@HiveType(typeId: 5)
class ClientBox {
  @HiveField(0)
  final int boxSize;

  @HiveField(1)
  final double salePrice;

  @HiveField(2)
  final DateTime date;

  ClientBox({
    required this.boxSize,
    required this.salePrice,
    required this.date,
  });
}
