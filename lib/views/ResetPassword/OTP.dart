import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/views/ResetPassword/resetPassword.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPPage extends StatefulWidget {
  @override
  _ForgetOTPPageState createState() => _ForgetOTPPageState();
}

class _ForgetOTPPageState extends State<OTPPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  bool _isLoading = false;
  var onTapRecognizer;
  final FocusNode _pinPutFocusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();

  String? bodyError;
  // loader
  // bool _isLoading = true;

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String? countryCodeNew;
  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldkey,
          backgroundColor: primaryColor,
          body: SingleChildScrollView(
            child: Center(
              child: new Form(
                key: formKey,
                child: new Column(children: <Widget>[
                  SizedBox(height: 75),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        'OTP.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: kPrimaryPurpleColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(height: screenHeight * 0.08),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 20.0, top: 0.0),
                    width: 380.0,
                    child: Text(
                      'Enter OTP',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: kPrimaryPurpleColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.9,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 80,
                        ),
                        PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: false,
                          obscuringCharacter: '*',
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v!.length < 5) {
                              return "OTP required";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            borderWidth: 2.0,
                            activeColor: kPrimaryPurpleColor,
                            selectedColor: kPrimaryPurpleColor,
                            inactiveColor: kPrimaryPurpleColor,
                            fieldHeight: 60,
                            fieldWidth: 50,
                          ),
                          cursorColor: kPrimaryWhiteColor,
                          animationDuration: Duration(milliseconds: 300),
                          textStyle: TextStyle(
                              fontSize: 20,
                              height: 1.6,
                              color: kPrimaryWhiteColor),
                          errorAnimationController: errorController,
                          focusNode: _pinPutFocusNode,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          boxShadows: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: primaryColor,
                              blurRadius: 10,
                            )
                          ],
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Container(
                          child: Text(
                            'Don\'t Receive the OTP?',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          margin: new EdgeInsets.symmetric(horizontal: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Resend Code',
                            style: TextStyle(
                                color: kPrimaryPurpleColor, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SafeArea(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ResetPassword(
                                                title: '',
                                              )),
                                    );
                                  },
                                  textColor: Colors.white,
                                  padding: const EdgeInsets.all(0.0),
                                  shape: CircleBorder(
                                    side: BorderSide(
                                        color: Colors.white,
                                        width: 5,
                                        style: BorderStyle.solid),
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100.0)),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topLeft,
                                        colors: [
                                          kPrimaryPurpleColor,
                                          kPrimaryPurpleColor,
                                        ],
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(15.0),
                                    child: _isLoading
                                        ? CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.arrow_forward,
                                            size: 35.0,
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
                              ],
                              // 6overflow: Overflow.visible,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          )),
    );
  }

  void _forgot() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var data = {
        "otp": "",
      };
      var res = await CallApi().postData(data, '');
      var body = json.decode(res.body);
      print(body);

      bodyError = body['message'];

      if (body['errorMessage'] == false) {
        if (body['token'] != null) {
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          var token = body['token'];
          localStorage.setString('token', token);

          print(bodyError);
        }
      } else {}
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
