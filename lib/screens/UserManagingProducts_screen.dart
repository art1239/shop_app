import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/addOrEditProduct_screen.dart';
import 'package:shop_app/widgets/mainDrawer.dart';
import 'package:shop_app/widgets/manageProductItem.dart';

class UserProductScreen extends StatelessWidget {
  static const path = '/manageProducts';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed(AddEditProduct.path);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemBuilder: (context, i) {
              return Column(
                children: [
                  ManageProductItem(
                      products[i].id, products[i].title, products[i].imageUrl),
                  Divider()
                ],
              );
            },
            itemCount: products.length),
      ),
    );
  }
}
