import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/SingleItem.dart';

class UserProductScreen extends StatelessWidget {
  static const path = '/manageProducts';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          FlatButton(
            onPressed: () {},
            child: IconButton(
              icon: Icon(Icons.add),
              color: Colors.white,
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemBuilder: (context, i) {
              return Column(
                children: [
                  SingleItem(products[i].title, products[i].imageUrl),
                  Divider()
                ],
              );
            },
            itemCount: products.length),
      ),
    );
  }
}
