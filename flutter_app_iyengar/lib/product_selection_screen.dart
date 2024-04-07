import 'package:flutter/material.dart';
import 'models/product.dart'; 

class ProductSelectionScreen extends StatefulWidget {
  @override
  _ProductSelectionScreenState createState() => _ProductSelectionScreenState();
}

class _ProductSelectionScreenState extends State<ProductSelectionScreen> {
  Map<Product, int> selectedProducts = {};

  void incrementQuantity(Product product) {
    setState(() {
      if (selectedProducts.containsKey(product)) {
        selectedProducts[product] = selectedProducts[product]! + 1;
      } else {
        selectedProducts[product] = 1;
      }
    });
  }

  void decrementQuantity(Product product) {
    setState(() {
      if (selectedProducts.containsKey(product)) {
        if (selectedProducts[product]! > 1) {
          selectedProducts[product] = selectedProducts[product]! - 1;
        } else {
          selectedProducts.remove(product);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Selection'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: product.variants.map((variant) {
                return Row(
                  children: [
                    Text('${variant.size} - ${variant.price} INR'),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => decrementQuantity(product),
                    ),
                    Text(selectedProducts.containsKey(product) &&
                            selectedProducts[product]! > 0
                        ? '${selectedProducts[product]}'
                        : '0'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => incrementQuantity(product),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
