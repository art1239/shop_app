import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/HttpException.dart';

class Auth with ChangeNotifier {
  String _userId;
  DateTime _expiry;
  String _token;
  Timer _logOutTimer;
  String get userId {
    return _userId;
  }

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

      autoLogOut();
      notifyListeners();
      final storage = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'dataExpired': _expiry.toIso8601String(),
      });
      storage.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signInUser(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> autoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    final data =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final expiryDate = DateTime.parse(data['dataExpired']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = data['token'];
    _userId = data['userId'];
    _expiry = expiryDate;
    notifyListeners();
    autoLogOut();
    return true;
  }

  Future<void> logOut() async {
    _userId = null;
    _token = null;
    _expiry = null;
    if (_logOutTimer != null) {
      _logOutTimer.cancel();
      _logOutTimer = null;
    }

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void autoLogOut() {
    if (_logOutTimer != null) {
      _logOutTimer.cancel();
    }
    final timeToLogOut = _expiry.difference(DateTime.now()).inSeconds;
    _logOutTimer = Timer(Duration(seconds: timeToLogOut), logOut);
  }
}
