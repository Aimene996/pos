// repositories/purchase_repository.dart
import 'package:hive/hive.dart';

import '../../models/purchase.dart';

class PurchaseRepository {
  final Box<Purchase> _purchaseBox = Hive.box<Purchase>('purchases');

  List<Purchase> getAllPurchases() => _purchaseBox.values.toList();

  void addPurchase(Purchase purchase) =>
      _purchaseBox.put(purchase.id, purchase);

  Purchase? getPurchase(String id) => _purchaseBox.get(id);

  void deletePurchase(String id) => _purchaseBox.delete(id);
}
