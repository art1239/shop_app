import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

  double getAccountFeaturesWidth(BuildContext context, double width) {
    return width == null ? MediaQuery.of(context).size.width * 0.845 : width;
  }

  double getAccountFeaturesHeight(BuildContext context, double height) {
    return height == null ? 50 : height;
  }
}
