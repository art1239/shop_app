import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Order.dart';
import 'package:shop_app/widgets/OrderItem.dart';
import 'package:shop_app/widgets/mainDrawer.dart';

class OrderScreen extends StatefulWidget {
  static const path = '/orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = false;
  @override
  void initState() {
    _isLoading = true;
    Provider.of<Orders>(context, listen: false).getOrders().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: MainDrawer(),
      body: !_isLoading
          ? ListView.builder(
              itemBuilder: (context, index) {
                return OrderItem(_orders.allOrders[index]);
              },
              itemCount: _orders.allOrders.length,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
