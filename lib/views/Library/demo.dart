// import 'package:flutter/material.dart';

// import 'package:mangakiku_app/_helpers/constants.dart';
// import 'package:mangakiku_app/component/bottomNavigationBar.dart';
// import 'package:mangakiku_app/views/Home/homePage.dart';

// class CommentScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//         //   appBar: AppBar(
//         //   backgroundColor: Colors.white,
//         //   elevation: 0.0,
//         //   centerTitle: true,
//         //   leading: IconButton(
//         //     icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
//         //     onPressed: () {},
//         //   ),
//         //   title: Text('Pickup',
//         //       style: TextStyle(
//         //           fontFamily: 'Varela',
//         //           fontSize: 20.0,
//         //           color: Color(0xFF545D68))),
//         //   actions: <Widget>[
//         //     IconButton(
//         //       icon: Icon(Icons.notifications_none, color: Color(0xFF545D68)),
//         //       onPressed: () {},
//         //     ),
//         //   ],
//         // ),
//         backgroundColor: primaryColor,
//         body: SingleChildScrollView(
//             child: Column(children: <Widget>[
//           Stack(
//             children: <Widget>[
//               Container(
//                 height: screenHeight * (6 / 20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(0.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       offset: Offset(0.0, 2.0),
//                       blurRadius: 6.0,
//                     ),
//                   ],
//                 ),
//                 child: Image(
//                   image: AssetImage("assets/image-4.png"),
//                   width: 800,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Padding(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 145.0, vertical: 50.0),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Text('Chapter 2 ',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                             ),
//                             textAlign: TextAlign.center),
//                       ])),
//               Container(
//                 margin: EdgeInsets.only(top: 40),
//                 child: Align(
//                   alignment: Alignment.topCenter,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                           icon: Icon(
//                             Icons.arrow_back_ios,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           }),
//                       IconButton(
//                           icon: Icon(
//                             Icons.keyboard_control_rounded,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {})
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: 140,
//                   height: 35,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "122 Comments",
//                         style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: 100,
//                   height: 35,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Top",
//                         style: TextStyle(fontSize: 13, color: Colors.grey),
//                       ),
//                       Icon(
//                         Icons.more_vert,
//                         color: Colors.white,
//                       ),
//                       Text(
//                         "New",
//                         style:
//                             TextStyle(fontSize: 13, color: Colors.purple[900]),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
//             const Padding(
//               padding: EdgeInsets.only(left: 20.0, top: 30),
//               child: CircleAvatar(
//                 radius: 20,
//                 backgroundImage: AssetImage(
//                   "assets/profile-img.png",
//                 ),
//               ),
//             ),
//             Padding(
//                 padding: const EdgeInsets.only(left: 40.0, top: 40),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       const Text(
//                         "Jake",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 5),
//                         child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               Container(
//                                 width: 130,
//                                 height: 30,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     // gradient: LinearGradient(colors: [secondary, primary]),
//                                     borderRadius: BorderRadius.circular(15)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.batch_prediction,
//                                       color: Colors.purple,
//                                     ),
//                                     Text(
//                                       "Top 100 Readers",
//                                       style: TextStyle(
//                                           fontSize: 13,
//                                           color: Colors.purple[900]),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ]),
//                       ),
//                        Container(
//                                 width: 500,
//                                 height: 30,
//                                 // decoration: BoxDecoration(
//                                 //     color: Colors.white,
//                                 //     // gradient: LinearGradient(colors: [secondary, primary]),
//                                 //     borderRadius: BorderRadius.circular(15)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.batch_prediction,
//                                       color: Colors.purple,
//                                     ),
//                                     Text(
//                                       "Top 100 Readers The definition of a character is a unique symbol, letter or mark used in writing. ... Character is defined as a trait, quality or high moral code. An example of character is someone who is known for being funny. An example of character is a person who is trustworthy.",
//                                       style: TextStyle(
//                                           fontSize: 13,
//                                           color: Colors.purple[900]),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                       //       Padding(
//                       //   padding: const EdgeInsets.only(top: 10),
//                       //   child: Row(
//                       //       crossAxisAlignment: CrossAxisAlignment.center,
//                       //       children: const <Widget>[
//                       //         Text(
//                       //           "It is a long establish fact The definition of a character is a unique symbol, letter or mark used in writing. ... Character is defined as a trait, quality or high moral code. An example of character is someone who is known for being funny. An example of character is a person who is trustworthy.",
//                       //           style: TextStyle(
//                       //               color: Colors.white,
//                       //               fontSize: 14.0,
//                       //               fontWeight: FontWeight.bold),
//                       //         ),
//                       //       ]),
//                       // )
//                     ]))
//           ]),
//         ])));
//   }
// }

// class CharacterPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //final TextStyle textStyle = Theme.of(context).textTheme.display1;
//     return SingleChildScrollView(
//         child: Column(children: [
//       Padding(
//         padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: 140,
//                     height: 30,
//                     decoration: BoxDecoration(
//                         color: Colors.grey,
//                         // gradient: LinearGradient(colors: [secondary, primary]),
//                         borderRadius: BorderRadius.circular(1)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Select Language",
//                           style: TextStyle(fontSize: 13, color: Colors.white),
//                         ),
//                         Icon(
//                           Icons.keyboard_arrow_down,
//                           color: Colors.white,
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       DataTable(
//         border: TableBorder(
//           horizontalInside: BorderSide(color: Colors.white),
//         ),
//         columns: [
//           DataColumn(
//             label: Container(
//               width: 120,
//               height: 25,
//               decoration: BoxDecoration(
//                   color: Colors.grey,
//                   // gradient: LinearGradient(colors: [secondary, primary]),
//                   borderRadius: BorderRadius.circular(1)),
//               child: Padding(
//                   padding: const EdgeInsets.only(top: 10.0, left: 5),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         hintText: "Select Chapter",
//                         hintStyle:
//                             TextStyle(fontSize: 12.0, color: Colors.white),
//                         border: InputBorder.none,
//                         fillColor: Colors.grey,
//                         focusColor: Colors.grey),
//                   )),
//             ),
//           ),
//           DataColumn(
//               label: Text(
//             'Date',
//             style: TextStyle(fontSize: 14, color: Colors.white),
//           )),
//           DataColumn(
//               label: Text(
//             'Language',
//             style: TextStyle(fontSize: 14, color: Colors.white),
//           )),
//         ],
//         rows: [
//           DataRow(cells: [
//             DataCell(Text(
//               'CH 12',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Text(
//               '2 days ',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Icon(
//               Icons.flag_rounded,
//               color: Colors.red,
//             )),
//           ]),
//           DataRow(cells: [
//             DataCell(Text(
//               'CH 12',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Text(
//               '2 days ',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Icon(
//               Icons.flag_rounded,
//               color: Colors.red,
//             )),
//           ]),
//           DataRow(cells: [
//             DataCell(Text(
//               'CH 12',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Text(
//               '2 days ',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Icon(
//               Icons.flag_rounded,
//               color: Colors.red,
//             )),
//           ]),
//           DataRow(cells: [
//             DataCell(Text(
//               'CH 12',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Text(
//               '2 days ',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Icon(
//               Icons.flag_rounded,
//               color: Colors.red,
//             )),
//           ]),
//           DataRow(cells: [
//             DataCell(Text(
//               'CH 12',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Text(
//               '2 days ',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Icon(
//               Icons.flag_rounded,
//               color: Colors.red,
//             )),
//           ]),
//           DataRow(cells: [
//             DataCell(Text(
//               'CH 12',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Text(
//               '2 days ',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Icon(
//               Icons.flag_rounded,
//               color: Colors.red,
//             )),
//           ]),
//           DataRow(cells: [
//             DataCell(Text(
//               'CH 12',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Text(
//               '2 days ',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Icon(
//               Icons.flag_rounded,
//               color: Colors.red,
//             )),
//           ]),
//           DataRow(cells: [
//             DataCell(Text(
//               'CH 12',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Text(
//               '2 days ',
//               style: TextStyle(fontSize: 14, color: Colors.white),
//             )),
//             DataCell(Icon(
//               Icons.flag_rounded,
//               color: Colors.red,
//             )),
//           ]),
//         ],
//       ),
//     ]));
//   }
// }