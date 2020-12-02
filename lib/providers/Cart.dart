import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/Cart.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  int get cardItemslength {
    return _cartItems.length;
  }

  CartItem getCartItemAt(int index) {
    return _cartItems.values.elementAt(index);
  }

  double get totalPrice {
    double sum = 0;
    return _cartItems.values.fold(
        sum,
        (accumulator, cartProduct) =>
            accumulator + cartProduct.price * cartProduct.quantity);
  }

  void addItemToCart(String prodId, String prodTitle, double price) {
    if (_cartItems.containsKey(prodId)) {
      _cartItems.update(
        prodId,
        (updatedCartItem) => CartItem(
            id: updatedCartItem.id,
            title: updatedCartItem.title,
            price: updatedCartItem.price,
            quantity: updatedCartItem.quantity + 1),
      );
    } else {
      _cartItems.putIfAbsent(prodId, () {
        return CartItem(
            title: prodTitle,
            quantity: 1,
            price: price,
            id: DateTime.now().toString());
      });
    }
    notifyListeners();
  }
}