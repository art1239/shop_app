import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/mainDrawer.dart';

import 'package:shop_app/widgets/product_grid.dart';

enum MenuOption {
  FAVORITES,
  ALL,
}

class ProductsCatalog extends StatefulWidget {
  @override
  _ProductsCatalogState createState() => _ProductsCatalogState();
}

class _ProductsCatalogState extends State<ProductsCatalog> {
  bool isFavorite = false;
  var isLoading = false;
  var response;
  @override
  void initState() {
    isLoading = true;

    Provider.of<Products>(context, listen: false).getProducts().then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Catalog'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 5),
            child: PopupMenuButton(
              child: Icon(Icons.more_vert),
              itemBuilder: (ctx) => [
                PopupMenuItem(
                  child: Text('Favorites'),
                  value: MenuOption.FAVORITES,
                ),
                PopupMenuItem(
                  child: Text('All Items'),
                  value: MenuOption.ALL,
                ),
              ],
              onSelected: (MenuOption option) {
                setState(() {
                  if (option == MenuOption.FAVORITES) {
                    isFavorite = true;
                  } else {
                    isFavorite = false;
                  }
                });
              },
            ),
          ),
          Consumer<Cart>(
            builder: (ctx, value, ch) {
              return Badge(ch, value.cardItemslength.toString());
            },
            child: Builder(builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Scaffold.of(context).hideCurrentSnackBar();
                  Navigator.pushNamed(context, '/cart');
                },
              );
            }),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: !isLoading
          ? ProductGrid(isFavorite)
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
                semanticsLabel: 'Loading Products',
              ),
            ),
    );
  }
}
