// product_repository.dart
import 'package:hive/hive.dart';

import '../../models/product.dart';

class ProductRepository {
  final Box<Product> _productBox = Hive.box<Product>('products');

  List<Product> getAllProducts() => _productBox.values.toList();

  void addProduct(Product product) => _productBox.put(product.id, product);

  Product? getProduct(String id) => _productBox.get(id);

  void deleteProduct(String id) => _productBox.delete(id);
}
