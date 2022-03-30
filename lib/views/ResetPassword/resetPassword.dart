import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/views/ForgotPassword/forgotPassword.dart';
import 'package:mangakiku_app/views/ResetPassword/OTP.dart';
import 'package:mangakiku_app/views/SignIn/signin.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  const ResetPassword({
    Key? key,
    required this.title,
    required this.email,
  }) : super(key: key);

  final String title;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? bodyError;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  String? confirm, password;

  bool showPassword = true;
  bool showconfirmPassword = true;
  late String email;

  @override
  void initState() {
    //initialize  id for chapterimage
    email = widget.email;
    print(email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: primaryColor,
        body: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Reset Password',
                  style: TextStyle(
                      fontSize: 20,
                      color: kPrimaryPurpleColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * (1 / 20)),
                _password(),
                SizedBox(height: screenHeight * (0.5 / 20)),
                _confirmpassword(),
                SizedBox(height: screenHeight * (0.5 / 20)),
                _reset(),
              ],
            ),
          ),
        ));
  }

  _password() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: TextFormField(
          style: const TextStyle(fontSize: 14.0, color: kPrimaryWhiteColor),
          cursorColor: kPrimaryPurpleColor,
          keyboardType: TextInputType.text,
          obscureText: showPassword,
          validator: (value) {
            RegExp regex = RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
            if (value!.isEmpty) {
              return 'Password required';
            } else if (!regex.hasMatch(value)) {
              return 'Password Must contains \n - Minimum 1 Upper case \n - Minimum 1 lowercase \n - Minimum 1 Number \n - Minimum 1 Special Character \n - Minimum 8 letters';
            }
            return null;
          },
          onSaved: (String? val) {
            password = val;
          },
          controller: _passwordController,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            hintText: "New Password",
            hintStyle: TextStyle(fontSize: 16.0, color: kPrimaryWhiteColor),
            fillColor: kPrimarylightGreyColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              borderSide: BorderSide.none,
              gapPadding: 0,
            ),
          ),
        ));
  }

  _confirmpassword() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: TextFormField(
          style: const TextStyle(fontSize: 14.0, color: kPrimaryWhiteColor),
          cursorColor: kPrimaryPurpleColor,
          keyboardType: TextInputType.text,
          obscureText: showconfirmPassword,
          validator: (value) {
            RegExp regex = RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
            if (value!.isEmpty) {
              return 'Password required';
            } else if (!regex.hasMatch(value)) {
              return 'Password Must contains \n - Minimum 1 Upper case \n - Minimum 1 lowercase \n - Minimum 1 Number \n - Minimum 1 Special Character \n - Minimum 8 letters';
            } else if (value != _passwordController.text) {
              return 'Not Matched';
            }
            return null;
          },
          onSaved: (String? val) {
            confirm = val;
          },
          controller: _confirmpasswordController,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            hintText: "Confirm Password",
            hintStyle: TextStyle(fontSize: 16.0, color: kPrimaryWhiteColor),
            fillColor: kPrimarylightGreyColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              borderSide: BorderSide.none,
              gapPadding: 0,
            ),
          ),
        ));
  }

  _reset() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        child: ButtonTheme(
            minWidth: 150.0,
            height: 40.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryPurpleColor, // background
                onPrimary: Colors.transparent,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  // use the email provided here
                  _changePassword();
                }
              },
              child: const Text(
                'Reset',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )),
      ),
    );
  }

  void _changePassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var data = {
        "email": widget.email,
        "newPassword": _passwordController.text,
      };
      var res = await CallApi().updatePassword(data, 'otpVerify');
      var body = json.decode(res.body);
      print(body);

      bodyError = body['message'];

      if (body['errorMessage'] == false) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Signin()),
        );
      } else {}
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
