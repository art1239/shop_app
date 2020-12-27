import 'package:flutter/material.dart';
import 'package:shop_app/constants/constantColors.dart';

import 'package:shop_app/utils/buttons.dart';
import 'package:shop_app/utils/signInButton.dart';
import 'package:shop_app/utils/signUpButton.dart';
import 'package:shop_app/utils/textfields.dart';

class UserForm extends StatefulWidget {
  final height;
  final width;

  UserForm(this.width, this.height);
  @override
  _UserFormState createState() => _UserFormState();
}

enum AccountMode {
  LogIn,
  SignUp,
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  AccountMode mode;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: widget.height * 0.62,
        child: Column(
          children: [
            AccountFields(
              labelText: 'Email',
              onSaved: () {},
            ),
            SizedBox(height: 15),
            AccountFields(
              labelText: 'Password',
              onSaved: () {},
              validator: () {},
              passwordField: true,
            ),
            SizedBox(
              height: 15,
            ),
            mode == AccountMode.SignUp
                ? AccountFields(
                    labelText: 'Confirm Password',
                    onSaved: () {},
                    passwordField: true,
                  )
                : SizedBox(),
            SizedBox(height: 35),
            Column(
              children: [
                mode == AccountMode.LogIn
                    ? SignInButton(
                        onTap: () {},
                      )
                    : SignUpButton(),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: widget.height * 0.10),
            mode == AccountMode.LogIn
                ? SignUpButton(
                    onTap: () {
                      switchAccountMode(mode);
                    },
                  )
                : AccountButton(
                    text: 'Sign in',
                    color: AppColors.signInButtonColor,
                    onTap: () {
                      switchAccountMode(mode);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  void switchAccountMode(AccountMode mode) {
    if (mode == AccountMode.LogIn) {
      setState(() {
        this.mode = AccountMode.SignUp;
      });
    } else {
      setState(() {
        this.mode = AccountMode.LogIn;
      });
    }
  }
}
