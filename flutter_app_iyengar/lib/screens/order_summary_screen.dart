import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_iyengar/models/product.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'thankyou.dart'; // Import the ThankYouPage

class OrderSummaryScreen extends StatelessWidget {
  final Map<Product, Map<Variant, int>> selectedProducts;
  final GlobalKey _globalKey = GlobalKey();

  OrderSummaryScreen({Key? key, required this.selectedProducts}) : super(key: key);

  Future<void> _saveAsImage(BuildContext context) async {
    RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    await ImageGallerySaver.saveImage(pngBytes);
  }

  Future<void> _saveAsPdf(BuildContext context) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Center(
          child: pw.Text('Order Summary'),
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/order_summary.pdf');
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF saved successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = 0;

    selectedProducts.forEach((product, variantQuantities) {
      variantQuantities.forEach((variant, quantity) {
        totalPrice += variant.price * quantity;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: () => _saveAsPdf(context),
          ),
          IconButton(
            icon: Icon(Icons.image),
            onPressed: () => _saveAsImage(context),
          ),
        ],
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: selectedProducts.length,
                  itemBuilder: (context, index) {
                    final product = selectedProducts.keys.toList()[index];
                    final variantQuantities = selectedProducts[product]!;
                    return ListTile(
                      title: Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: variantQuantities.entries.map((entry) {
                          final variant = entry.key;
                          final quantity = entry.value;
                          if (quantity > 0) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                '${variant.size}: ${variant.price} INR x $quantity',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total Price: $totalPrice INR',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThankYouPage()), // Navigate to ThankYouPage
                  );
                },
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  backgroundColor: Colors.black87, // Customize button color
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Proceed to Thank You Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
