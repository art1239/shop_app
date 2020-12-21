import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Order.dart';
import 'package:shop_app/widgets/OrderItem.dart';
import 'package:shop_app/widgets/mainDrawer.dart';

class OrderScreen extends StatelessWidget {
  static const path = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).getOrders(),
          builder: (
            ctx,
            snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Consumer<Orders>(
                builder: (context, orderData, child) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return OrderItem(orderData.allOrders[index]);
                    },
                    itemCount: orderData.allOrders.length,
                  );
                },
              );
            }
          }),
    );
  }
}
