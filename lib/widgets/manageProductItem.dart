import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/addOrEditProduct_screen.dart';

class ManageProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  ManageProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AddEditProduct.path, arguments: id);
              },
              color: Colors.lightBlue,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                return showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text('Are you Sure?'),
                        content: Text('You are about to delete the item'),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(ctx).pop(true);
                            },
                            child: Text('Yes'),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(ctx).pop(false);
                            },
                            child: Text('No'),
                          ),
                        ],
                      );
                    }).then((value) {
                  if (value) {
                    Provider.of<Products>(context, listen: false)
                        .removeProduct(id);
                  }
                });
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
