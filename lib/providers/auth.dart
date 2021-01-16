import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _userId;
  DateTime _expiry;
  String _token;

  Future<void> signUpUser(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCOadP3He1MFYctvn14nbRrEYi6lc3Ui34';
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
    print('b');
    print(json.decode(response.body));
  }

  Future<void> signInUser(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
