import 'package:flutter/material.dart';

class HttpException implements Exception {
  final String message;
  HttpException({@required this.message});
  @override
  String toString() {
    return message;
  }

  String manageAuthUser() {
    var errorMessage = 'Authentication failed';
    if (message.toString().contains('EMAIL_EXISTS')) {
      errorMessage = 'This email address is already in use.';
    } else if (message.toString().contains('INVALID_EMAIL')) {
      errorMessage = 'This is not a valid email address';
    } else if (message.toString().contains('WEAK_PASSWORD')) {
      errorMessage = 'This password is too weak.';
    } else if (message.toString().contains('EMAIL_NOT_FOUND')) {
      errorMessage = 'Could not find a user with that email.';
    } else if (message.toString().contains('INVALID_PASSWORD')) {
      errorMessage = 'Invalid password.';
    }
    return errorMessage;
  }
}
