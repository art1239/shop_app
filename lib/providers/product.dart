import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/HttpException.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});
  Future<void> toggleFavorite(String authToken, String userId) async {
    final url =
        'https://shopapp-28279-default-rtdb.firebaseio.com/favoriteProducts/$userId/$id.json?auth=$authToken';
    isFavorite = !isFavorite;
    notifyListeners();
    final response = await http.put(url, body: json.encode(isFavorite));
    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();
      throw HttpException(message: 'Failded to make update');
    }
  }
}
