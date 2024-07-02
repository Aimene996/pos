// providers/controller/sale_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/sale.dart';
import 'package:hive/hive.dart';

final salesProvider = StateNotifierProvider<SalesController, List<Sale>>((ref) {
  return SalesController();
});

class SalesController extends StateNotifier<List<Sale>> {
  SalesController() : super(Hive.box<Sale>('sales').values.toList());

  void addSale(Sale sale) {
    state = [...state, sale];
    Hive.box<Sale>('sales').add(sale);
  }

  void togglePaidStatus(int index) {
    Sale updatedSale = state[index];
    updatedSale.paid = !updatedSale.paid;
    state = [...state]..[index] = updatedSale;
    Hive.box<Sale>('sales').putAt(index, updatedSale);
  }

  List<Sale> filterSales(String query) {
    return state
        .where((sale) =>
            sale.clientName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
