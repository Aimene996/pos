// views/add_sale_screen.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../models/sale.dart';
import '../../providers/controller/product_controller.dart';
import '../../providers/controller/sale_controller.dart';

class AddSaleScreen extends ConsumerStatefulWidget {
  final double? price;
  final int? quantity;

  const AddSaleScreen({
    super.key,
    required this.price,
    required this.quantity,
  });

  @override
  _AddSaleScreenState createState() => _AddSaleScreenState();
}

class _AddSaleScreenState extends ConsumerState<AddSaleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameController = TextEditingController();
  String? _selectedProductId;
  bool _paid = false;

  @override
  void initState() {
    super.initState();
    _priceController.text = widget.price.toString();
    _quantityController.text = widget.quantity.toString();
  }

  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  void _saveSale() {
    if (_formKey.currentState!.validate()) {
      final id = const Uuid().v4(); // Generate UUID
      final salePrice = double.parse(_priceController.text);
      final quantity = int.parse(_quantityController.text);
      final clientName = _clientNameController.text;

      final sale = Sale(
        id: id,
        salePrice: salePrice,
        quantity: quantity,
        clientName: clientName,
        paid: _paid,
        date: DateTime.now(), // Replace with actual selected date
      );

      ref.read(salesProvider.notifier).addSale(sale);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('إضافة بيع')),
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
                decoration: const InputDecoration(labelText: 'سعر البيع'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'أدخل سعر البيع' : null,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'الكمية'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'أدخل الكمية' : null,
              ),
              TextFormField(
                controller: _clientNameController,
                decoration: const InputDecoration(labelText: 'اسم العميل'),
                validator: (value) => value!.isEmpty ? 'أدخل اسم العميل' : null,
              ),
              CheckboxListTile(
                title: const Text('مدفوع'),
                value: _paid,
                onChanged: (value) {
                  setState(() {
                    _paid = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _saveSale,
                child: const Text('حفظ البيع'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
