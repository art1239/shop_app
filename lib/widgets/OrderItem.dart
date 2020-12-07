import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/Order.dart';

class OrderItem extends StatefulWidget {
  final Order order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$ ${this.widget.order.amount}',
            ),
            subtitle:
                Text('${DateFormat.yMMMMEEEEd().format(widget.order.date)}'),
            trailing: IconButton(
              icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
            ),
          ),
          if (expanded)
            Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              height:
                  min(widget.order.products.length.toDouble() * 20 + 105, 180),
              child: ListView(
                children: widget.order.products
                    .map(
                      (e) => Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 0.3, color: Colors.grey)),
                        ),
                        margin: EdgeInsets.all(2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.title),
                                Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Text('${e.quantity * e.price} \$')),
                              ],
                            ),
                            Text(
                              e.quantity.toString() + ' X',
                            ),
                            // Divider(),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
