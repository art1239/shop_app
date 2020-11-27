import 'package:flutter/material.dart';

class ProductContainer extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  ProductContainer({this.id, this.title, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: null,
        ),
        title: Text(
          this.title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(icon: Icon(Icons.shopping_cart), onPressed: null),
      ),
      child: Image.network(
        this.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
