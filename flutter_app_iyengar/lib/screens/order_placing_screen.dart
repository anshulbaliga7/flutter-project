import 'package:flutter/material.dart';
import 'package:flutter_app_iyengar/models/product.dart'; // Import your product data
import 'package:flutter_app_iyengar/screens/order_summary_screen.dart'; // Import your order summary screen

class OrderPlacingScreen extends StatefulWidget {
  @override
  _OrderPlacingScreenState createState() => _OrderPlacingScreenState();
}

class _OrderPlacingScreenState extends State<OrderPlacingScreen> {
  // Define variables to hold user selections
  Map<Product, Map<Variant, int>> selectedProducts = {};

  // Method to handle product selection
  void _selectProduct(Product product, int quantity, Variant variant) {
    setState(() {
      // Check if the product already exists in the map
      if (selectedProducts.containsKey(product)) {
        // If yes, update the quantity for the specific variant
        selectedProducts[product]![variant] = quantity;
      } else {
        // If no, add the product to the map with the quantity
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
          style: TextStyle(fontWeight: FontWeight.bold), // Make the app bar title bold
        ),
        backgroundColor: Colors.deepOrange, // Set app bar background color
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
                fontWeight: FontWeight.bold, // Make product name bold
                color: Colors.deepPurple, // Set product name color
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
                        '${variant.price} INR', // Add INR after the price
                        style: TextStyle(
                          color: Colors.black87, // Set price color
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
          // Navigate to order summary screen
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
        backgroundColor: Colors.deepPurple, // Set FAB background color
      ),
    );
  }
}
