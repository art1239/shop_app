import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/Cart.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _cardItems;

  Map<String, CartItem> get cardItems {
    return {..._cardItems};
  }

  void addItemToCar(
      String prodId, String prodTitle, int quantity, double price) {
    if (_cardItems.containsKey(prodId)) {
      _cardItems.update(
        prodId,
        (updatedCartItem) => CartItem(
            id: updatedCartItem.id,
            title: updatedCartItem.title,
            price: updatedCartItem.price,
            quantity: updatedCartItem.quantity + 1),
      );
    } else {
      _cardItems.putIfAbsent(prodId, () {
        return CartItem(
            title: prodTitle,
            quantity: 1,
            price: price,
            id: DateTime.now().toString());
      });
    }
  }
}
