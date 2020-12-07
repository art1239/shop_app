import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/providers/Cart.dart';

class SingleCartItem extends StatelessWidget {
  final CartItem cartItem;
  final String productId;
  SingleCartItem(this.cartItem, this.productId);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Are you Sure?'),
                content: Text(
                    'You are about to delete the whole item from the card'),
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
            });
      },
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(cartItem.price.toString() + '\$'))),
          ),
          title: Text(cartItem.title),
          subtitle: Text('Total: ${cartItem.price * cartItem.quantity}\$'),
          trailing: Text(cartItem.quantity.toString() + ' x'),
        ),
      ),
    );
  }
}
