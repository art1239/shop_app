import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Catalog'),
        actions: [
          PopupMenuButton(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                  child: Text('Favorites'), value: MenuOption.FAVORITES),
              PopupMenuItem(child: Text('All Items'), value: MenuOption.ALL),
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
        ],
      ),
      body: ProductGrid(isFavorite),
    );
  }
}
