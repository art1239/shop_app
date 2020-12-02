import 'package:flutter/material.dart';
import 'package:shop_app/widgets/cartItems.dart';
import 'package:shop_app/widgets/totalBar.dart';

class CartScreen extends StatelessWidget {
  static const path = '/cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TotalBar(),
          SizedBox(
            height: 10,
          ),
          CartItems(),
        ],
      ),
    );
  }
}
