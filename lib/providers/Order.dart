import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/Cart.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;

  const Order({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.date,
  });
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];
  List<Order> get allOrders {
    return [..._orders];
  }

  void addOrders(double amount, List<CartItem> products) {
    _orders.insert(
        0,
        Order(
          id: DateTime.now().toString(),
          amount: amount,
          products: products,
          date: DateTime.now(),
        ));
    notifyListeners();
  }
}
