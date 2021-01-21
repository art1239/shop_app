import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:http/http.dart' as http;

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
  final authToken;
  Orders({this.authToken});
  List<Order> get allOrders {
    return [..._orders];
  }

  Future<void> addOrders(double amount, List<CartItem> products) async {
    final url =
        'https://shopapp-28279-default-rtdb.firebaseio.com/orders.json?auth=$authToken';
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode(
        {
          'amount': amount,
          'products': products
              .map(
                (cartProduct) => {
                  'id': cartProduct.id,
                  'price': cartProduct.price,
                  'quantity': cartProduct.quantity,
                  'title': cartProduct.title,
                },
              )
              .toList(),
          'date': timeStamp.toIso8601String(),
        },
      ),
    );
    _orders.insert(
      0,
      Order(
        id: json.decode(response.body)['name'],
        amount: amount,
        products: products,
        date: timeStamp,
      ),
    );
    notifyListeners();
  }

  Future<void> getOrders() async {
    final url =
        'https://shopapp-28279-default-rtdb.firebaseio.com/orders.json?auth=$authToken';
    final response = await http.get(url);
    final exctractedData = json.decode(response.body) as Map<String, dynamic>;

    if (exctractedData == null) {
      return;
    }
    _orders = exctractedData.entries
        .map(
          (orders) => Order(
            id: orders.key,
            date: DateTime.tryParse(orders.value['date']),
            products: (orders.value['products'] as List<dynamic>)
                .map(
                  (product) => CartItem(
                    id: product['id'],
                    title: product['title'],
                    price: product['price'],
                    quantity: product['quantity'],
                  ),
                )
                .toList(),
            amount: orders.value['amount'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
