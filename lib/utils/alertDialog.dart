import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showAlertDialog(
  BuildContext context, {
  @required String title,
  @required String content,
  @required String defaultOptionText,
  String optionalText,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        if (optionalText != null)
          FlatButton(
            child: Text(optionalText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        FlatButton(
          child: Text(defaultOptionText),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}
