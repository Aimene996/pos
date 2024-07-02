// views/add_box_to_client_screen.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/client.dart';

class AddBoxToClientScreen extends ConsumerStatefulWidget {
  final Client client;

  const AddBoxToClientScreen({super.key, required this.client});

  @override
  _AddBoxToClientScreenState createState() => _AddBoxToClientScreenState();
}

class _AddBoxToClientScreenState extends ConsumerState<AddBoxToClientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _boxSizeController = TextEditingController();
  final _salePriceController = TextEditingController();

  void _saveBox() {
    if (_formKey.currentState!.validate()) {
      // ignore: unused_local_variable
      final salePrice = double.parse(_salePriceController.text);

      // final updatedClient = widget.client.copyWith(
      //   boxes: [...widget.client.boxes, clientBox],
      // );

      // ref.read(clientsProvider.notifier).updateClient(updatedClient);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Box to ${widget.client.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _boxSizeController,
                decoration: const InputDecoration(labelText: 'Box Size'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter a box size' : null,
              ),
              TextFormField(
                controller: _salePriceController,
                decoration: const InputDecoration(labelText: 'Sale Price'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter a sale price' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveBox,
                child: const Text('Save Box'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
