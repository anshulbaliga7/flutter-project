import 'package:flutter/material.dart';
import 'package:flutter_app_iyengar/models/product.dart'; 
import 'package:flutter_app_iyengar/screens/order_summary_screen.dart'; 

class OrderPlacingScreen extends StatefulWidget {
  @override
  _OrderPlacingScreenState createState() => _OrderPlacingScreenState();
}

class _OrderPlacingScreenState extends State<OrderPlacingScreen> {
  Map<Product, Map<Variant, int>> selectedProducts = {};

  void _selectProduct(Product product, int quantity, Variant variant) {
    setState(() {
      if (selectedProducts.containsKey(product)) {
        selectedProducts[product]![variant] = quantity;
      } else {
        selectedProducts[product] = {variant: quantity};
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Place Your Order',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange, 
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(
              product.name,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple, 
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final variant in product.variants)
                  Row(
                    children: [
                      Text(variant.size),
                      SizedBox(width: 30),
                      Text(
                        '${variant.price} INR', 
                        style: TextStyle(
                          color: Colors.black87, 
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 200,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter quantity',
                          ),
                          onChanged: (value) {
                            int quantity = int.tryParse(value) ?? 0;
                            _selectProduct(product, quantity, variant);
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OrderSummaryScreen(selectedProducts: selectedProducts),
            ),
          );
        },
        label: Text('View Order Summary'),
        icon: Icon(Icons.shopping_cart),
        backgroundColor: Colors.deepPurple, 
      ),
    );
  }
}
