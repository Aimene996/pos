// views/add_purchase_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/purchase.dart';
import '../../providers/controller/product_controller.dart';
import '../../providers/controller/puchase_controller.dart';

class AddPurchaseScreen extends ConsumerStatefulWidget {
  const AddPurchaseScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddPurchaseScreenState createState() => _AddPurchaseScreenState();
}

class _AddPurchaseScreenState extends ConsumerState<AddPurchaseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  String? _selectedProductId;

  void _savePurchase() {
    if (_formKey.currentState!.validate()) {
      final id = const Uuid().v4();
      final price = double.parse(_priceController.text);
      final quantity = int.parse(_quantityController.text);
      final date = DateTime.now();

      final purchase = Purchase(
        id: id,
        productId: _selectedProductId!,
        price: price,
        quantity: quantity,
        date: date,
      );

      ref.read(purchasesProvider.notifier).addPurchase(purchase);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('إضافة عملية شراء')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedProductId,
                items: products.map((product) {
                  return DropdownMenuItem(
                    value: product.id,
                    child: Text(product.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProductId = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'المنتج'),
                validator: (value) => value == null ? 'اختر منتجًا' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'السعر'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'أدخل السعر' : null,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'الكمية'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'أدخل الكمية' : null,
              ),
              ElevatedButton(
                onPressed: _savePurchase,
                child: const Text('حفظ عملية الشراء'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
