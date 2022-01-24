import 'package:flutter/material.dart';

import 'package:mangakiku_app/_helpers/constants.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ForgetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ForgetPassword> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  String? email;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _scaffoldKey,
            backgroundColor: primaryColor,
        body: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Forget Password?',
                  style: TextStyle(
                      fontSize: 24,
                      color: kPrimaryPurpleColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * (0.7 / 20)),
                const Text(
                  'We will Send a link to recover password',
                  style: TextStyle(
                    fontSize: 12,
                    color: kPrimaryPurpleColor,
                  ),
                ),
                SizedBox(height: screenHeight * (1 / 20)),
                _password(),
                SizedBox(height: screenHeight * (0.5 / 20)),
                _reset(),
              ],
            ),
          ),
        ));
  }

  _password() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: TextFormField(
          style: const TextStyle(
              fontSize: 18.0, color: Colors.white),
          cursorColor: kPurple,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            RegExp regex = RegExp(
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                r"{0,253}[a-zA-Z0-9])?)*$");
            if (value == null || value.isEmpty || !regex.hasMatch(value)) {
              return 'Enter a valid email address';
            }

            return null;
          },
          onSaved: (String? val) {
            email = val;
          },
          controller: _emailController,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            hintText: "Email",
            hintStyle: TextStyle(
                fontSize: 16.0, color: kWhite, fontWeight: FontWeight.bold),
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
    return Container(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        child: ButtonTheme(
            minWidth: 100.0,
            height: 30.0,
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
                      MaterialPageRoute(
                          builder: (context) => const ForgetPassword(title: '')),
                    );
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )),
      ),
    );
  }
}