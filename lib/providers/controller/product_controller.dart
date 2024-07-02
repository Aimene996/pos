// product_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/product.dart';
import '../repository/product_repository.dart';

final productRepositoryProvider = Provider((ref) => ProductRepository());

final productsProvider =
    StateNotifierProvider<ProductsNotifier, List<Product>>((ref) {
  return ProductsNotifier(ref.read(productRepositoryProvider));
});

class ProductsNotifier extends StateNotifier<List<Product>> {
  final ProductRepository _productRepository;

  ProductsNotifier(this._productRepository)
      : super(_productRepository.getAllProducts());

  void addProduct(Product product) {
    _productRepository.addProduct(product);
    state = _productRepository.getAllProducts();
  }
}
