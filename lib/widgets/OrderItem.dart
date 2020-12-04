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
    return ListTile(
      title: Text(
        '\$ ${this.widget.order.amount}',
      ),
      subtitle: Text('${DateFormat.yMMMMEEEEd().format(widget.order.date)}'),
      trailing: IconButton(
        icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
        onPressed: () {
          setState(() {
            expanded = !expanded;
          });
        },
      ),
    );
  }
}
