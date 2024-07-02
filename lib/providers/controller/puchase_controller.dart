// controllers/purchase_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/purchase.dart';
import '../repository/purchase_repository.dart';

final purchaseRepositoryProvider = Provider((ref) => PurchaseRepository());

final purchasesProvider =
    StateNotifierProvider<PurchasesNotifier, List<Purchase>>((ref) {
  return PurchasesNotifier(ref.read(purchaseRepositoryProvider));
});

class PurchasesNotifier extends StateNotifier<List<Purchase>> {
  final PurchaseRepository _purchaseRepository;

  PurchasesNotifier(this._purchaseRepository)
      : super(_purchaseRepository.getAllPurchases());

  void addPurchase(Purchase purchase) {
    _purchaseRepository.addPurchase(purchase);
    state = _purchaseRepository.getAllPurchases();
  }
}
