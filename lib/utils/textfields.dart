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
  final TextEditingController editingController;
  AccountFields({
    @required this.labelText,
    @required this.onSaved,
    this.validator,
    this.height,
    this.width,
    this.cursorColor: Colors.pink,
    this.passwordField: false,
    this.editingController,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig().getAccountFeaturesHeight(context, height),
      width: SizeConfig().getAccountFeaturesWidth(context, width),
      color: Colors.white,
      child: TextFormField(
        controller: TextEditingController(),
        style: TextStyle(backgroundColor: Colors.white),
        obscureText: passwordField,
        cursorColor: Colors.pink,
        cursorHeight: 20,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          labelText: labelText,
          contentPadding: EdgeInsets.only(left: 25),
        ),
      ),
    );
  }
}
