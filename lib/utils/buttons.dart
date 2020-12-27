import 'package:flutter/material.dart';

import 'package:shop_app/constants/constantSizes.dart';

class AccountButton extends StatelessWidget {
  final VoidCallback onTap;
  final double height;
  final double width;
  final String text;
  final Color color;
  final double fontSize;
  final Border borders;
  AccountButton(
      {@required this.text,
      this.height,
      this.width,
      this.color,
      this.fontSize: 20,
      this.onTap,
      this.borders});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: this.color, border: borders),
      height: SizeConfig().getAccountFeaturesHeight(context, height),
      width: SizeConfig().getAccountFeaturesWidth(context, width),
      child: FlatButton(
        padding: EdgeInsets.all(13),
        onPressed: this.onTap,
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
      ),
    );
  }
}
