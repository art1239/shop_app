import 'package:flutter/material.dart';
import 'package:shop_app/constants/constantSizes.dart';

class AccountFields extends StatelessWidget {
  final String labelText;
  final Function onSaved;
  final Function validator;
  final double height;
  final double width;
  final Color cursorColor;
  final bool passwordField;

  final String initialValue;
  final TextEditingController controller;
  AccountFields({
    this.controller,
    @required this.labelText,
    @required this.onSaved,
    this.validator,
    this.height,
    this.width,
    this.cursorColor: Colors.pink,
    this.passwordField: false,
    this.initialValue,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: SizeConfig().getAccountFeaturesHeight(context, height),
      width: SizeConfig().getAccountFeaturesWidth(context, width),
      child: TextFormField(
        controller: controller,
        initialValue: this.initialValue,
        validator: this.validator,
        obscureText: passwordField,
        cursorColor: Colors.pink,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
          // isDense: true,
          focusedErrorBorder: InputBorder.none,

          // errorBorder: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          labelText: labelText,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
      ),
    );
  }
}
