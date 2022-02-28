import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:mangakiku_app/views/SignIn/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _profileController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  String? password;
  String? confirm;
  String? _uploadedFileURL;
  String? bodyError;

  bool _isLoading = false;
  bool showPassword = true;
  bool showconfirmPassword = true;
  bool image = false;

  File? _image;
  late Future<String> fileurl;
  var _ImageS;

  //get image
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        // _image = image;
        _image = File(pickedFile.path);
        _ImageS = pickedFile.path;

        //file path upload
        if (_image != null) {
          _profileController.text = "Sucessful Uploaded";
        } else {
          _profileController.text = "Unscessful Upload";
        }

        print(_image);
        print('------');
        print(pickedFile.path);
        // uploadFile();

        print(_ImageS);
        image = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
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
                _name(),
                SizedBox(height: screenHeight * (0.25 / 20)),
                _profile(),
                SizedBox(height: screenHeight * (0.25 / 20)),
                _bio(),
                SizedBox(height: screenHeight * (0.25 / 20)),
                _email(),
                SizedBox(height: screenHeight * (0.25 / 20)),
                _password(),
                SizedBox(height: screenHeight * (0.25 / 20)),
                _confirmpassword(),
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

                // SizedBox(height: 5.0),
                SizedBox(height: screenHeight * (0.5 / 20)),

                !_isLoading
                    ? _signUp()
                    : CupertinoActivityIndicator(
                        radius: 15,
                      ),
                SizedBox(height: screenHeight * (1 / 20)),

                Padding(
                  padding: const EdgeInsets.only(left: 80.0, right: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => Signin(),
                              //   ),
                              // );
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  _email() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: TextFormField(
        style: const TextStyle(fontSize: 14, color: Colors.white),
        cursorColor: kPrimaryPurpleColor,
        keyboardType: TextInputType.emailAddress,
        // obscureText: showPassword,
        validator: (value) {
          RegExp regex = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
          if (value!.isEmpty) {
            return 'Email Required';
          } else if (!regex.hasMatch(value)) {
            return 'Email FormRequired !!';
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
          fillColor: kPrimarylightGreyColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
            borderSide: BorderSide.none,
            gapPadding: 0,
          ),
        ),
      ),
    );
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
            color: kPrimaryWhiteColor,
          ),
          fillColor: kPrimarylightGreyColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
            borderSide: BorderSide.none,
            gapPadding: 0,
          ),
        ),
      ),
    );
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
          hintStyle: TextStyle(fontSize: 14.0, color: kPrimaryGreyColor),
          fillColor: kPrimarylightGreyColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
            borderSide: BorderSide.none,
            gapPadding: 0,
          ),
        ),
      ),
    );
  }

  _signUp() {
    return ButtonTheme(
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

            submitSubscription(file: _image, filename: _ImageS, token: "token");
          }
        },
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  _bio() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: TextFormField(
        style: const TextStyle(fontSize: 14, color: kPrimaryWhiteColor),
        maxLines: 5,
        cursorColor: kPrimaryPurpleColor,
        keyboardType: TextInputType.multiline,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Bio required';
          }
          return null;
        },
        controller: _bioController,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          hintText: "Bio",
          hintStyle: TextStyle(
            fontSize: 14.0,
            color: kPrimaryWhiteColor,
          ),
          fillColor: kPrimarylightGreyColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
            borderSide: BorderSide.none,
            gapPadding: 0,
          ),
        ),
      ),
    );
  }

  _name() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: TextFormField(
          style: const TextStyle(fontSize: 14, color: kPrimaryWhiteColor),
          cursorColor: kPrimaryPurpleColor,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Name required';
            }
            return null;
          },
          controller: _nameController,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            hintText: "Name",
            hintStyle: TextStyle(
              fontSize: 14.0,
              color: kPrimaryWhiteColor,
            ),
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

  _profile() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: TextFormField(
          style: const TextStyle(fontSize: 14, color: kPrimaryWhiteColor),
          minLines: 1,
          cursorColor: kPrimaryPurpleColor,
          keyboardType: TextInputType.none,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Profile required';
            }
            return null;
          },
          controller: _profileController,
          textInputAction: TextInputAction.none,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            hintText: "Profile",
            hintStyle: TextStyle(
              fontSize: 14.0,
              color: kPrimaryWhiteColor,
            ),
            fillColor: kPrimarylightGreyColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              borderSide: BorderSide.none,
              gapPadding: 0,
            ),
            suffixIcon: Container(
              width: 100,
              child: Row(
                children: [
                  Text("Upload",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kPrimaryWhiteColor,
                      )),
                  IconButton(
                    icon: Icon(
                      Icons.insert_photo_rounded,
                      color: kPrimaryWhiteColor,
                      size: 30.0,
                    ),
                    onPressed: () {
                      _getFromGallery();
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<int> submitSubscription(
      {File? file, String? filename, String? token}) async {
    setState(() {
      _isLoading = true;
    });

    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://mangakiku-api.moodfor.codes/api/addUser"),
    );
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-type": "multipart/form-data",
      'Accept': "multipart/form-data",
    };
    request.files.add(
      http.MultipartFile(
        'image',
        file!.readAsBytes().asStream(),
        file.lengthSync(),
        filename: filename,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);
    request.fields.addAll({
      "name": _nameController.text,
      "bio": _bioController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
    });
    // print("request: " + request.toString());
    var res = await request.send();
    // print("This is response:" + res.toString());

    final respStr = await res.stream.bytesToString();
    // print(respStr);

    final body = json.decode(respStr);
    print(body['message']);

    bodyError = body['message'];

    if (body["errorMessage"] == false) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomePage()),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
    }

    return res.statusCode;
  }
}
