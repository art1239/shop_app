import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Order.dart';
import 'package:shop_app/providers/Cart.dart';

class TotalBar extends StatefulWidget {
  final Cart cart;

  TotalBar(this.cart);
  @override
  _TotalBarState createState() => _TotalBarState();
}

class _TotalBarState extends State<TotalBar> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    print(isLoading);
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
              label: Text('${widget.cart.totalPrice.toStringAsFixed(2)}\$'),
              labelStyle: TextStyle(),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            FlatButton(
              child: !isLoading
                  ? Text('ORDER NOW',
                      style: TextStyle(
                        color: (widget.cart.cardItemslength <= 0)
                            ? Colors.grey
                            : Colors.red,
                      ))
                  : CircularProgressIndicator(),
              color: Colors.white,
              onPressed: (widget.cart.cardItemslength <= 0 || isLoading)
                  ? null
                  : () async {
                      setState(() {
                        isLoading = true;
                      });

                      await Provider.of<Orders>(context, listen: false)
                          .addOrders(widget.cart.totalPrice,
                              widget.cart.cartItems.values.toList());

                      setState(() {
                        isLoading = false;
                      });
                      widget.cart.clearCart();
                    },
            ),
          ],
        ),
      ),
    );
  }
}
