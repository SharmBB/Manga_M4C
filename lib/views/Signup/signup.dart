import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:mangakiku_app/views/SignIn/signin.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  String? password;
  String? confirm;

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
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'SIGN UP',
                  style: TextStyle(
                      fontSize: 20,
                      color: kPrimaryPurpleColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * (0.5 / 20)),
                _email(),
                SizedBox(height: screenHeight * (0.25 / 20)),
                _password(),
                SizedBox(height: screenHeight * (0.25 / 20)),
                _confirmpassword(),
                // SizedBox(height: 5.0),

                SizedBox(height: screenHeight * (0.5 / 20)),

                _reset(),
                SizedBox(height: screenHeight * (1 / 20)),
                Padding(
                  padding: const EdgeInsets.only(left: 80.0, right: 50.0),
                  child: Row(
                    children: [
                      Text(
                        "Already have an account ?",
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
                                  builder: (context) => Signin(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                " Login",
                                style: TextStyle(color: kPrimaryPurpleColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
        )));
  }

  _email() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: TextFormField(
          style: const TextStyle(fontSize: 14, color: Colors.white),
          cursorColor: kPurple,
          keyboardType: TextInputType.emailAddress,
          // obscureText: showPassword,
          validator: (value) {
            RegExp regex = RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
            if (value!.isEmpty) {
              return 'Email required';
            } else if (!regex.hasMatch(value)) {
              return 'abc@gmail.com';
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
            hintText: "Email / UserName",
            hintStyle: TextStyle(
              fontSize: 14.0,
              color: kPrimaryWhiteColor,
            ),
            fillColor: kPrimaryPurpleColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              borderSide: BorderSide.none,
              gapPadding: 0,
            ),
          ),
        ));
  }

  _password() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: TextFormField(
          style: const TextStyle(fontSize: 14, color: kPrimaryWhiteColor),
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
            hintText: "Password",
            hintStyle: TextStyle(
              fontSize: 14.0,
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

  _confirmpassword() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: TextFormField(
          style: const TextStyle(fontSize: 14, color: Colors.white),
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
            hintText: "Re-Enter Password",
            hintStyle: TextStyle(
                fontSize: 14.0, color:kPrimaryGreyColor),
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

  _reset() {
    return  ButtonTheme(
            minWidth: 300.0,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            
      ),
    );
  }
}
