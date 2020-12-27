import 'package:flutter/material.dart';
import 'package:shop_app/constants/constantColors.dart';
import 'package:shop_app/constants/constantSizes.dart';

import 'package:shop_app/widgets/userForm.dart';

class AuthScreen extends StatelessWidget {
  static const path = '/auth';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.darkPinkHomeScreen,
                  AppColors.lightPinkHomeScren,
                ],
                stops: [0.3, 1],
              ),
            ),
          ),
          Container(
            height: deviceHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  // decoration: BoxDecoration(border: Border.all(width: 3)),
                  alignment: Alignment.center,
                  height: deviceHeight * 0.25,
                  child: Text(
                    'Shopping App',
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                      fontFamily: 'Anton',
                    ),
                  ),
                ),
                UserForm(deviceWidth, deviceHeight),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
