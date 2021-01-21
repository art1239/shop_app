import 'package:flutter/material.dart';
import './alertDialog.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context, {
  String title,
  @required String desc,
}) =>
    showAlertDialog(
      context,
      title: title != null ? title : 'Something went wrong',
      content: _message(desc),
      defaultOptionText: 'OK',
    );

String _message(String desc) {
  return desc.toString();
}
