import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../../views/sale/add_sale_product_screen.dart'; // Adjust import as needed

final barcodeControllerProvider =
    Provider.family<BarcodeController, BuildContext>((ref, context) {
  return BarcodeController(ref as WidgetRef, context);
});

class BarcodeController {
  final WidgetRef _ref;
  final BuildContext context;

  BarcodeController(this._ref, this.context);

  Future<void> scanBarcode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      if (barcodeScanRes != '-1') {
        handleBarcode(barcodeScanRes);
      }
    } catch (e) {
      barcodeScanRes = 'Failed to get barcode.';
    }
  }

  void handleBarcode(String barcode) {
    switch (barcode) {
      case 'box06':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddSaleScreen(price: 300, quantity: 1),
          ),
        );
        break;
      case 'box12':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddSaleScreen(price: 600, quantity: 1),
          ),
        );
        break;
      case 'box24':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddSaleScreen(price: 900, quantity: 1),
          ),
        );
        break;
      case 'box36':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddSaleScreen(price: 1200, quantity: 1),
          ),
        );
        break;
      default:
        // Handle unknown barcode
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unknown barcode: $barcode')),
        );
    }
  }
}
