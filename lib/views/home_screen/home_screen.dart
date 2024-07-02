import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../providers/controller/product_controller.dart';
import '../../providers/controller/puchase_controller.dart';
import '../../providers/controller/sale_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final Box productBox;
  late final Box purchaseBox;
  late final Box saleBox;

  @override
  Widget build(BuildContext context) {
    final productsCount = ref.watch(productsProvider).length;
    final purchasesCount = ref.watch(purchasesProvider).length;
    final salesCount = ref.watch(salesProvider).length;

    // final barcodeController = ref.read(barcodeControllerProvider(context));

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إدارة المخزون'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCard('إضافة منتج', Icons.add, '/add-product'),
              _buildCard(
                  'إضافة عملية شراء', Icons.shopping_cart, '/add-purchase'),
              _buildCard('إضافة عملية بيع', Icons.local_mall, '/add-sale'),
              _buildCard('عرض المنتجات', Icons.list, '/products'),
              _buildCard('عرض عمليات الشراء', Icons.shopping_bag, '/purchases'),
              _buildCard('عرض عمليات البيع', Icons.receipt, '/sales'),
              const SizedBox(height: 24.0),
              const Divider(),
              const SizedBox(height: 12.0),
              Text(
                'الملخص',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12.0),
              Card(
                elevation: 3.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'إجمالي المنتجات: $productsCount',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'إجمالي عمليات الشراء: $purchasesCount',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'إجمالي عمليات البيع: $salesCount',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add-product');
              },
              tooltip: 'Add Product',
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 10),
            // FloatingActionButton(
            //   onPressed: () async {
            //     await barcodeController.scanBarcode();
            //   },
            //   tooltip: 'Scan Barcode',
            //   child: const Icon(Icons.qr_code_scanner,
            //       color: Colors.red), // Set color to red
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, String route) {
    return Card(
      elevation: 3.0,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40.0,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 12.0),
              Text(
                title,
                style: const TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
