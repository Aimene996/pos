// views/client_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/controller/client_controller.dart';

class ClientDetailsScreen extends ConsumerWidget {
  final String clientId;

  const ClientDetailsScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client =
        ref.read(clientsProvider).firstWhere((client) => client.id == clientId);

    return Scaffold(
      appBar: AppBar(title: Text('Client Details - ${client.name}')),
      body: ListView.builder(
        itemCount: client.boxes.length,
        itemBuilder: (context, index) {
          final box = client.boxes[index];
          return ListTile(
            title: Text('Box Size: ${box.boxSize}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sale Price: \$${box.salePrice}'),
                Text('Date: ${box.date.toLocal().toString().split(' ')[0]}'),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AddBoxToClientScreen(client: ,),
          //   ),
          // );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
