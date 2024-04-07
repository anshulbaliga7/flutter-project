// product.dart

class Product {
  final String name;
  final List<Variant> variants;

  Product({
    required this.name,
    required this.variants,
  });
}

class Variant {
  final String size;
  final int price;

  Variant({
    required this.size,
    required this.price,
  });
}

List<Product> products = [
  Product(
    name: 'Munch',
    variants: [
      Variant(size: '10g - Regular', price: 10),
      Variant(size: '30g - Medium', price: 30),
      Variant(size: '110g - Large', price: 90),
    ],
  ),
  Product(
    name: 'DairyMilk',
    variants: [
      Variant(size: '10g - Regular', price: 10),
      Variant(size: '35g - Regular', price: 30),
      Variant(size: '110g - Regular', price: 80),
      Variant(size: '110g - Silk', price: 95),
    ],
  ),
  Product(
    name: 'KitKat',
    variants: [
      Variant(size: '10g - Regular', price: 5),
      Variant(size: '30g - Medium', price: 15),
      Variant(size: '110g - Large', price: 60),
    ],
  ),
  Product(
    name: 'FiveStar',
    variants: [
      Variant(size: '15g - Regular', price: 20),
      Variant(size: '35g - Medium', price: 45),
      Variant(size: '110g - Large', price: 75),
    ],
  ),
  Product(
    name: 'Perk',
    variants: [
      Variant(size: '10g - Regular', price: 11),
      Variant(size: '35g - Medium', price: 48),
      Variant(size: '110g - Large', price: 95),
    ],
  ),
];
