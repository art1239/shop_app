import 'package:flutter/material.dart';
import 'package:shop_app/widgets/product_container.dart';
import '../models/product.dart';

class ProductsCatalog extends StatelessWidget {
  final List<Product> products = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
        id: 'p2',
        title: 'Trousers',
        description: 'A nice pair of trousers.',
        price: 59.99,
        imageUrl:
            'https://lh3.googleusercontent.com/proxy/EDClC78_cTzfFJ-qB3k-hEv36h6N5INAa6Ky6x4A33UHok6UPrsUixXwf9EIicmCko3KorZUvc5B7cryEiSvZPcFWCyNE60fiKZDxU82PTaqXccBMM4SzYdijWDrZgriG13p'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Catalog'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ProductContainer(
            title: products[index].title,
            id: products[index].id,
            imageUrl: products[index].imageUrl,
          );
        },
        itemCount: products.length,
      ),
    );
  }
}
