import 'package:flutter/cupertino.dart';
import 'package:shop_app/constants/constantColors.dart';
import 'package:shop_app/utils/buttons.dart';

class SignInButton extends AccountButton {
  SignInButton({
    String text,
    VoidCallback onTap,
    double height,
    double width,
    double fontSize,
  }) : super(
          onTap: onTap,
          text: 'Log In',
          color: AppColors.signInButtonColor,
        );
}
