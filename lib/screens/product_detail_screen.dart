import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetail extends StatelessWidget {
  static const path = '/products-detail';

  ProductDetail();
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final productDetails =
        Provider.of<Products>(context, listen: false).findItemById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(productDetails.title),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              productDetails.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              '\$ ${productDetails.price}',
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              '${productDetails.description}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
