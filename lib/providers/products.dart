import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/HttpException.dart';
import 'package:shop_app/models/MuttableProduct.dart';

import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://atlas-content-cdn.pixelsquid.com/stock-images/cargo-pants-0M3qXPF-600.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
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

  Future<void> addProducts(MuttableProduct p) async {
    final url =
        'https://shopapp-28279-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': p.title,
            'price': p.price,
            'description': p.desc,
            'imageUrl': p.imageUrl,
            'isFavorite': p.isFavorite
          }));

      final productToBeAdded = Product(
        title: p.title,
        id: json.decode(response.body)['name'],
        imageUrl: p.imageUrl,
        description: p.desc,
        price: p.price,
      );
      _items.add(productToBeAdded);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> modifyProduct(MuttableProduct p, String id) async {
    final url =
        'https://shopapp-28279-default-rtdb.firebaseio.com/products/$id.json';

    final index = _items.indexWhere((element) => element.id == id);
    if (index >= 0) {
      final response = await http.patch(url,
          body: json.encode({
            'title': p.title,
            'price': p.price,
            'description': p.desc,
            'imageUrl': p.imageUrl,
          }));
      final productToBeUpdated = Product(
        title: p.title,
        id: json.decode(response.body)['name'],
        imageUrl: p.imageUrl,
        description: p.desc,
        price: p.price,
        isFavorite: p.isFavorite,
      );
      _items[index] = productToBeUpdated;
      notifyListeners();
    }
  }

  Future<void> getProducts() async {
    final url =
        'https://shopapp-28279-default-rtdb.firebaseio.com/products.json';
    final response = await http.get(url);
    final exctractedData = json.decode(response.body) as Map<String, dynamic>;
    if (exctractedData == null) {
      return;
    }
    _items = exctractedData.entries
        .map(
          (product) => Product(
            id: product.key,
            isFavorite: product.value['isFavorite'],
            title: product.value['title'],
            description: product.value['description'],
            price: product.value['price'],
            imageUrl: product.value['imageUrl'],
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> removeProduct(String id) async {
    final url =
        'https://shopapp-28279-default-rtdb.firebaseio.com/products/$id.json';
    final indexOfDeletedProduct =
        _items.indexWhere((element) => element.id == id);
    var temporaryProduct = _items[indexOfDeletedProduct];
    _items.removeAt(indexOfDeletedProduct);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(indexOfDeletedProduct, temporaryProduct);
      notifyListeners();

      throw HttpException(message: 'Could not connect to the server');
    }
    temporaryProduct = null;
  }
}
