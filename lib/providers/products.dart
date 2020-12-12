import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://atlas-content-cdn.pixelsquid.com/stock-images/cargo-pants-0M3qXPF-600.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findItemById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Future<void> addProducts(Product p) {
    const url =
        'https://shopapp-28279-default-rtdb.firebaseio.com/products.json';
    return http
        .post(url,
            body: json.encode({
              'title': p.title,
              'price': p.price,
              'description': p.description,
              'imageUrl': p.imageUrl,
              'isFavorite': p.isFavorite
            }))
        .then((response) {
      final product = Product(
        title: p.title,
        id: json.decode(response.body)['name'],
        imageUrl: p.imageUrl,
        description: p.description,
        price: p.price,
        isFavorite: p.isFavorite,
      );
      _items.add(product);
      notifyListeners();
    });
  }

  void modifyProduct(Product p, String id) {
    final index = _items.indexWhere((element) => element.id == id);
    _items[index] = p;
    notifyListeners();
  }

  void removeProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
