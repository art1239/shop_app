import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/addOrEditProduct_screen.dart';
import 'package:shop_app/widgets/mainDrawer.dart';
import 'package:shop_app/widgets/manageProductItem.dart';

class UserProductScreen extends StatelessWidget {
  static const path = '/manageProducts';
  Future<void> _refreshPage(BuildContext context) async {
    print('refreshi');
    await Provider.of<Products>(context, listen: false).getProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final products = Provider.of<Products>(context).items;

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
      body: FutureBuilder(
        future: _refreshPage(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ))
                : Consumer<Products>(
                    builder: (context, products, child) {
                      return RefreshIndicator(
                        onRefresh: () => _refreshPage(context),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ListView.builder(
                              itemBuilder: (context, i) {
                                return Column(
                                  children: [
                                    ManageProductItem(
                                        products.items[i].id,
                                        products.items[i].title,
                                        products.items[i].imageUrl),
                                    Divider()
                                  ],
                                );
                              },
                              itemCount: products.items.length),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
