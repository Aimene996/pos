import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:point/views/home_screen/home_screen.dart';
import 'package:point/views/product/product_screen.dart';
import 'package:point/views/puchase/add_puchase_screen.dart';
import 'package:point/views/puchase/purchas_screen.dart';
import 'package:point/views/sale/sale_screen.dart';
import 'models/product.dart';
import 'models/purchase.dart';
import 'models/sale.dart';
import 'models/client.dart';
import 'views/product/add_product_screen.dart';
import 'views/sale/add_sale_product_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(PurchaseAdapter());
  Hive.registerAdapter(SaleAdapter());
  Hive.registerAdapter(ClientAdapter());
  Hive.registerAdapter(ClientBoxAdapter());

  await Hive.openBox<Product>('products');
  await Hive.openBox<Purchase>('purchases');
  await Hive.openBox<Sale>('sales');
  await Hive.openBox<Client>('clients');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Candy Inventory App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Ensure LTR directionality
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: child!,
        );
      },
      home: const HomeScreen(),
      routes: {
        '/add-product': (context) => const AddProductScreen(),
        '/add-purchase': (context) => const AddPurchaseScreen(),
        '/add-sale': (context) => const AddSaleScreen(
              price: 100,
              quantity: 1,
            ),
        '/products': (context) => const ProductListScreen(),
        '/purchases': (context) => const PurchaseListScreen(),
        '/sales': (context) => const SaleListScreen(),
      },
    );
  }
}
