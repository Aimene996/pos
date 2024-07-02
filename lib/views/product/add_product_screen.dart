// views/add_product_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';
import '../../models/product.dart';
import '../../providers/controller/product_controller.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _boxSizeController = TextEditingController();
  List<int> _boxSizes = [];

  void _addBoxSize() {
    if (_boxSizeController.text.isNotEmpty) {
      setState(() {
        _boxSizes.add(int.parse(_boxSizeController.text));
        _boxSizeController.clear();
      });
    }
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final id = const Uuid().v4();
      final name = _nameController.text;
      final productionPrice = double.parse(_priceController.text);
      final quantity = int.parse(_quantityController.text);
      final barcodes =
          List<String>.generate(_boxSizes.length, (index) => const Uuid().v4());

      final product = Product(
        id: id,
        name: name,
        productionPrice: productionPrice,
        quantity: quantity,
        boxSizes: _boxSizes,
        barcodes: barcodes,
      );

      ref.read(productsProvider.notifier).addProduct(product);
      Navigator.pop(context);
    }
  }

  void _generateRandomBarcodes() {
    const boxSizes = [6, 12, 24, 36];
    final productNames = ['جوزية 06', 'جوزية 12', 'جوزية 24', 'جوزية 36'];
    final prices = [300.0, 600.0, 900.0, 1000.0];
    final random = Random();

    for (int i = 0; i < boxSizes.length; i++) {
      final id = const Uuid().v4();
      final name = productNames[i];
      final productionPrice = prices[i];
      final quantity = 1; // Adjust quantity if necessary
      final barcodes = List<String>.generate(
          3, (index) => random.nextInt(1000000).toString());

      final product = Product(
        id: id,
        name: name,
        productionPrice: productionPrice,
        quantity: quantity,
        boxSizes: [boxSizes[i]],
        barcodes: barcodes,
      );

      ref.read(productsProvider.notifier).addProduct(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Product')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a product name' : null,
                ),
                TextFormField(
                  controller: _priceController,
                  decoration:
                      const InputDecoration(labelText: 'Production Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter a price' : null,
                ),
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a quantity' : null,
                ),
                TextFormField(
                  controller: _boxSizeController,
                  decoration: const InputDecoration(labelText: 'Box Size'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: _addBoxSize,
                  child: const Text('Add Box Size'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _saveProduct,
                  child: const Text('Save Product'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _generateRandomBarcodes,
          child: const Icon(Icons.qr_code),
          tooltip: 'Generate Barcodes',
        ),
      ),
    );
  }
}
