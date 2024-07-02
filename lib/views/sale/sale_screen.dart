// views/sale/sale_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/controller/sale_controller.dart';
import 'add_sale_product_screen.dart';

class SaleListScreen extends ConsumerStatefulWidget {
  const SaleListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SaleListScreenState();
}

class _SaleListScreenState extends ConsumerState<SaleListScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final sales = searchQuery.isEmpty
        ? ref.watch(salesProvider)
        : ref.read(salesProvider.notifier).filterSales(searchQuery);

    return Scaffold(
      appBar: AppBar(title: const Text('المبيعات')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'البحث بواسطة اسم العميل',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      searchQuery = searchController.text;
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sales.length,
              itemBuilder: (context, index) {
                final sale = sales[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('العميل: ${sale.clientName}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        // Text('التاريخ: ${sale.date.toLocal().toString().split(' ')[0]}'),
                        const Divider(),
                        const Text('تفاصيل المنتج:'),
                        Text('الكمية: ${sale.quantity}'),
                        Text('سعر البيع: \$${sale.salePrice}'),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'الحالة: ${sale.paid ? "مدفوع" : "غير مدفوع"}'),
                            ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(salesProvider.notifier)
                                    .togglePaidStatus(index);
                              },
                              child: Text(sale.paid
                                  ? 'وضع على أنه غير مدفوع'
                                  : 'وضع على أنه مدفوع'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddSaleScreen(
                      price: 0,
                      quantity: 1,
                    )),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
