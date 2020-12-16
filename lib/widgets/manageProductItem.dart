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
    final scaffoldContext = Scaffold.of(context);

    print('buildi i deletit');
    //  print(Scaffold.of(context).mounted);

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
              onPressed: () async {
                final response = await showDialog<bool>(
                    barrierDismissible: false,
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
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              }),
                        ],
                      );
                    });
                if (response) {
                  await Provider.of<Products>(context, listen: false)
                      .removeProduct(id)
                      .catchError((_) {
                    // print(Scaffold.of(context).mounted);
                    scaffoldContext.showSnackBar(
                        SnackBar(content: Text('Something went wrong')));
                  });
                }
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
