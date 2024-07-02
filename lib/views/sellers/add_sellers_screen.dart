// views/add_client_screen.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../models/sellers.dart';
import '../../providers/controller/client_controller.dart';

class AddClientScreen extends ConsumerStatefulWidget {
  const AddClientScreen({super.key});

  @override
  _AddClientScreenState createState() => _AddClientScreenState();
}

class _AddClientScreenState extends ConsumerState<AddClientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  void _saveClient() {
    if (_formKey.currentState!.validate()) {
      final client = Client(
        id: const Uuid().v4(),
        name: _nameController.text,
        boxes: [],
      );

      ref.read(clientsProvider.notifier).addClient(client);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Client')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Client Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter a client name' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveClient,
                child: const Text('Save Client'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
