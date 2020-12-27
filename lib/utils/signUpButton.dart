import 'package:flutter/cupertino.dart';
import 'package:shop_app/constants/constantColors.dart';
import 'package:shop_app/utils/buttons.dart';

class SignUpButton extends AccountButton {
  SignUpButton(
      {String text,
      VoidCallback onTap,
      double height,
      double width,
      Border border})
      : super(
            onTap: onTap,
            text: 'Create An Account',
            borders: AppColors.bordersOfSignUpButton,
            height: height,
            width: width);
}
