import 'package:flutter/material.dart';
import 'package:shop_app/models/Cart.dart';

class SingleCartItem extends StatelessWidget {
  final CartItem cartItem;
  SingleCartItem(this.cartItem);
  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
