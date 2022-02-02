import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/views/ForgotPassword/forgotPassword.dart';
import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:mangakiku_app/views/Signup/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? password;
  String? bodyError;
  bool _isLoading = false;
  bool showPassword = true;
  bool showconfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: primaryColor,
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'SIGN IN',
                  style: TextStyle(
                      fontSize: 20,
                      color: kPrimaryPurpleColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * (1 / 20)),
                _email(),
                SizedBox(height: screenHeight * (0.5 / 20)),
                _password(),
                !_isLoading
                    ? bodyError != null
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                            child: Container(
                              padding: EdgeInsets.only(top: 10),
                              alignment: Alignment.topLeft,
                              child: Text(
                                bodyError.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.red),
                              ),
                            ))
                        : SizedBox()
                    : SizedBox(),
                SizedBox(height: screenHeight * (0.25 / 20)),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Container(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassword()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: Text(
                          'Forget Password ?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: kPrimaryPurpleColor),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * (0.5 / 20)),
                !_isLoading
                    ? _signIn()
                    : CupertinoActivityIndicator(
                        radius: 20,
                      ),
                SizedBox(height: screenHeight * (1 / 20)),
                Padding(
                  padding: const EdgeInsets.only(left: 80.0, right: 50.0),
                  child: Row(
                    children: [
                      Text(
                        "Don't have an Account ?",
                        style: TextStyle(
                          color: kPrimaryWhiteColor,
                        ),
                      ),
                      Column(
                        children: [
                          InkWell(
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signup(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                " Sign up",
                                style: TextStyle(color: kPrimaryPurpleColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

//Email
  _email() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: TextFormField(
          style: const TextStyle(fontSize: 16, color: Colors.white),
          cursorColor: kPurple,
          keyboardType: TextInputType.text,
          validator: (value) {
            RegExp regex = RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
            if (value!.isEmpty) {
              return 'Email Required !!';
            } else if (!regex.hasMatch(value)) {
              return 'Email Required !!';
            }
            return null;
          },
          onSaved: (String? val) {
            password = val;
          },
          controller: _emailController,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            hintText: "Email /UserName",
            hintStyle: TextStyle(
              fontSize: 16.0,
              color: kWhite,
            ),
            fillColor: kGrey,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              borderSide: BorderSide.none,
              gapPadding: 0,
            ),
          ),
        ));
  }

//Password
  _password() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: TextFormField(
          style: const TextStyle(fontSize: 16.0, color: Colors.white),
          cursorColor: kPurple,
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
            hintText: "Password",
            hintStyle: TextStyle(
              fontSize: 16.0,
              color: kWhite,
            ),
            fillColor: kGrey,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              borderSide: BorderSide.none,
              gapPadding: 0,
            ),
          ),
        ));
  }

//Sign In Button
  _signIn() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        child: ButtonTheme(
            minWidth: 150.0,
            height: 40.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryPurpleColor,
                onPrimary: Colors.transparent,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  _login();
                }
              },
              child: const Text(
                'Sign In',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )),
      ),
    );
  }

//Login CAll API
  void _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var data = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      var res = await CallApi().authData(data, 'login');
      var body = json.decode(res.body);
      if (body["errorMessage"] == false) {
        if (body['message']['token'] != null) {
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          var token = body['message']['token'];
          print(token);
          var userId = body['message']["user"]["id"];
          print(userId);
          localStorage.setString('token', token);
          localStorage.setInt('userId', userId);
          print(body['message']);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          );
        }
      } else {
        setState(() {
          bodyError = body['message'];
        });
        print(bodyError);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
