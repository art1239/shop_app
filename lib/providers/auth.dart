import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/HttpException.dart';

class Auth with ChangeNotifier {
  String _userId;
  DateTime _expiry;
  String _token;

  bool get isAuth {
    return token == null ? false : true;
  }

  String get token {
    if (_expiry != null && _expiry.isAfter(DateTime.now()) && _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> signUpUser(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCOadP3He1MFYctvn14nbRrEYi6lc3Ui34';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(message: responseData['error']['message']);
      }
      _expiry = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signInUser(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
