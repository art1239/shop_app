import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/HttpException.dart';
import 'package:shop_app/providers/auth.dart';
import '../utils/exceptionAlertDialog.dart';
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
  TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  Map<String, String> user = {
    'email': '',
    'password': '',
  };

  AccountMode mode = AccountMode.LogIn;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: widget.height * 0.7,
        child: Column(
          children: [
            AccountFields(
              labelText: 'Email',
              onSaved: (value) {
                user['email'] = value.toString();
              },
              validator: (value) {
                RegExp rgx = RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                );
                if (rgx.hasMatch(value.toString())) {
                  return null;
                }
                return 'Not a valid Email';
              },
            ),
            SizedBox(height: 20),
            AccountFields(
              labelText: 'Password',
              controller: _passwordController,
              onSaved: (value) {
                user['password'] = value.toString();
              },
              validator: (value) {
                if (value.toString().length < 5) {
                  return 'Password to short';
                }
                return null;
              },
              passwordField: true,
            ),
            SizedBox(
              height: 20,
            ),
            mode == AccountMode.SignUp
                ? AccountFields(
                    onSaved: null,
                    labelText: 'Confirm Password',
                    validator: mode == AccountMode.SignUp
                        ? (value) {
                            if (value == _passwordController.text) {
                              return null;
                            }

                            return 'Paswords doesnt match';
                          }
                        : null,
                    passwordField: true,
                  )
                : SizedBox(),
            SizedBox(height: 30),
            Column(
              children: [
                mode == AccountMode.LogIn
                    ? !isLoading
                        ? SignInButton(
                            onTap: () {
                              validateForm();
                            },
                          )
                        : CircularProgressIndicator()
                    : !isLoading
                        ? SignUpButton(
                            onTap: () {
                              validateForm();
                            },
                          )
                        : CircularProgressIndicator(),
                Container(
                  margin: EdgeInsets.only(top: 15),
                )
              ],
            ),
            SizedBox(height: widget.height * 0.07),
            mode == AccountMode.LogIn
                ? SignUpButton(
                    onTap: () {
                      switchAccountMode(mode);
                    },
                  )
                : SignInButton(
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

  Future<void> validateForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    try {
      if (mode == AccountMode.LogIn) {
        await Provider.of<Auth>(context, listen: false)
            .signInUser(user['email'], user['password']);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signUpUser(user['email'], user['password']);
      }
    } on HttpException catch (e) {
      showExceptionAlertDialog(context, desc: e.manageAuthUser());
    } catch (e) {
      showExceptionAlertDialog(context, desc: 'An error occured');
    }
    setState(() {
      isLoading = false;
    });
  }
}
