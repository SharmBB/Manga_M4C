// import 'package:flutter/material.dart';


// class ResetPassword extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<ResetPassword> {
//   final scaffoldKey = new GlobalKey<ScaffoldState>();
//   GlobalKey<FormState> formKey = new GlobalKey();
//   TextEditingController _newpasswordController = new TextEditingController();
//   TextEditingController _passwordController = new TextEditingController();

//   String? email, password;
//   bool showPassword = true;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(color: kPrimaryGreenColor),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Stack(children: [
//               Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     SizedBox(
//                       height: 70,
//                     ),
//                     Text(
//                       "Reset Password",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 25,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Form(
//                           key: formKey,
//                           autovalidate: true,
//                           child: Stack(
//                             children: <Widget>[
//                               Column(
//                                 children: <Widget>[
//                                   Container(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 15),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       shape: BoxShape.rectangle,
//                                       borderRadius: BorderRadius.circular(8),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(0.2),
//                                           spreadRadius: 1,
//                                           blurRadius: 10,
//                                           offset: Offset(0, 3),
//                                         )
//                                       ],
//                                     ),
//                                     child: Column(
//                                       children: <Widget>[
//                                         SizedBox(
//                                           height: 20,
//                                         ),
//                                         passwordInput(),
//                                         SizedBox(
//                                           height: 40,
//                                         ),
//                                         NewpasswordInput(),
//                                         SizedBox(
//                                           height: 40,
//                                         ),
//                                         SizedBox(
//                                           height: 50,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 80,
//                               ),
//                             ],
//                           ),
//                         )),
//                     SafeArea(
//                       child: Container(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             FlatButton(
//                               onPressed: () async {
//                                 await onClick();
//                               },
//                               textColor: Colors.white,
//                               padding: const EdgeInsets.all(0.0),
//                               shape: CircleBorder(
//                                 side: BorderSide(
//                                     color: Colors.white,
//                                     width: 5,
//                                     style: BorderStyle.solid),
//                               ),
//                               child: Container(
//                                 decoration: const BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(100.0)),
//                                   gradient: LinearGradient(
//                                     begin: Alignment.bottomRight,
//                                     end: Alignment.topLeft,
//                                     colors: [
//                                       Colors.green,
//                                       Colors.greenAccent,
//                                     ],
//                                   ),
//                                 ),
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: _isLoading
//                                     ? CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                         color: Colors.white,
//                                       )
//                                     : Icon(
//                                         Icons.arrow_forward,
//                                         size: 35.0,
//                                         color: Colors.white,
//                                       ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ])
//             ]),
//           ),
//         ),
//       )),
//     );
//   }

//   Widget NewpasswordInput() {
//     return TextFormField(
//       keyboardType: TextInputType.text,
//       obscureText: showPassword,
//       validator: (value) {
//         if (value.length == 0) {
//           return 'Confirm Password required';
//         } else if ((value != _passwordController.text)) {
//           return 'Both Password must match';
//         }
//         return null;
//       },
//       onSaved: (String val) {
//         password = val;
//       },
//       controller: _newpasswordController,
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//         labelText: "Confirm Password",
//         labelStyle: TextStyle(fontSize: 14),
//         contentPadding: new EdgeInsets.fromLTRB(0, 20, 0, 0),
//         suffixIcon: IconButton(
//           icon: Icon(Icons.remove_red_eye),
//           onPressed: () => setState(() => showPassword = !showPassword),
//         ),
//       ),
//     );
//   }

//   Widget passwordInput() {
//     return TextFormField(
//       keyboardType: TextInputType.text,
//       obscureText: showPassword,
//       validator: (value) {
//         RegExp regex = new RegExp(
//             r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
//         if (value.length == 0) {
//           return 'Password Required';
//         } else if (!regex.hasMatch(value)) {
//           return 'Password Must contains \n - Minimum 1 Upper case \n - Minimum 1 lowercase \n - Minimum 1 Number \n - Minimum 1 Special Character \n - Minimum 8 letters';
//         }
//         return null;
//       },
//       onSaved: (String val) {
//         password = val;
//       },
//       controller: _passwordController,
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//         labelText: "New Password",
//         labelStyle: TextStyle(fontSize: 14),
//         contentPadding: new EdgeInsets.fromLTRB(0, 20, 0, 0),
//         suffixIcon: IconButton(
//           icon: Icon(Icons.remove_red_eye),
//           onPressed: () => setState(() => showPassword = !showPassword),
//         ),
//       ),
//     );
//   }

//   onClick() async {
//     if (formKey.currentState.validate()) {
//       formKey.currentState.save();

//       Navigator.pop(context);
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => SignIn()),
//       );

//       print("Logging in");
//     } else {
//       print("validate");
//     }
//   }
// }