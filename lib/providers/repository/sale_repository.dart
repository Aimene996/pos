// repositories/sale_repository.dart
import 'package:hive/hive.dart';

import '../../models/sale.dart';

class SaleRepository {
  final Box<Sale> _saleBox = Hive.box<Sale>('sales');

  List<Sale> getAllSales() => _saleBox.values.toList();

  void addSale(Sale sale) => _saleBox.put(sale.id, sale);

  Sale? getSale(String id) => _saleBox.get(id);

  void deleteSale(String id) => _saleBox.delete(id);
}
