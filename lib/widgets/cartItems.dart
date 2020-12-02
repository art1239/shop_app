import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/providers/Cart.dart';

import 'singleCartItem.dart';

class CartItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Expanded(
      child: ListView.builder(
        itemBuilder: (_, index) {
          return SingleCartItem(
            cart.getCartItemAt(index),
          );
        },
        itemCount: cart.cardItemslength,
      ),
    );
  }
}
