import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productItem = Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: productItem.isFavorite
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            onPressed: () {
              productItem.toggleFavorite();
            },
          ),
          title: Text(
            productItem.title,
            textAlign: TextAlign.center,
          ),
          trailing:
              IconButton(icon: Icon(Icons.shopping_cart), onPressed: null),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetail.path, arguments: productItem.id);
          },
          child: Image.network(
            productItem.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
