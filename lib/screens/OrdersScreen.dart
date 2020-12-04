import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Order.dart';
import 'package:shop_app/widgets/OrderItem.dart';
import 'package:shop_app/widgets/mainDrawer.dart';

class OrderScreen extends StatelessWidget {
  static const path = '/orders';
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: MainDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return OrderItem(orders.allOrders[index]);
        },
        itemCount: orders.allOrders.length,
      ),
    );
  }
}
