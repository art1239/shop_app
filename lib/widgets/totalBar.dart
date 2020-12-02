import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Cart.dart';

class TotalBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              'Total',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Spacer(),
            Chip(
              label: Text('${cart.totalPrice}\$'),
              labelStyle: TextStyle(),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'ORDER NOW',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
