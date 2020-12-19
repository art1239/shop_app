import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Cart.dart';
import 'package:shop_app/widgets/cartItems.dart';
import 'package:shop_app/widgets/totalBar.dart';

class CartScreen extends StatelessWidget {
  static const path = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TotalBar(cart),
          SizedBox(
            height: 10,
          ),
          CartItems(),
        ],
      ),
    );
  }
}
