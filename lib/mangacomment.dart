// import 'package:flutter/material.dart';
// import 'package:mangakiku_app/component/dialogbox.dart';

// class MangaComments extends StatefulWidget {
//   const MangaComments({Key? key}) : super(key: key);

//   @override
//   _MangaCommentsState createState() => _MangaCommentsState();
// }

// class _MangaCommentsState extends State<MangaComments> {
//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//         backgroundColor: Colors.black,
//         body: Padding(
//             padding: EdgeInsets.only(top: 0.0),
//             child: ListView(children: [
//               Stack(
//                 children: <Widget>[
//                   Container(
//                     height: screenHeight * (6 / 20),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(0.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           offset: Offset(0.0, 2.0),
//                           blurRadius: 6.0,
//                         ),
//                       ],
//                     ),
//                     child: Image(
//                       image: AssetImage("assets/image-4.png"),
//                       width: 800,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 145.0, vertical: 50.0),
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text('Chapter 2 ',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                 ),
//                                 textAlign: TextAlign.center),
//                           ])),
//                   Container(
//                     margin: EdgeInsets.only(top: 40),
//                     child: Align(
//                       alignment: Alignment.topCenter,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                               icon: Icon(
//                                 Icons.arrow_back_ios,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               }),
//                           IconButton(
//                               icon: Icon(
//                                 Icons.keyboard_control_rounded,
//                                 color: Colors.white,
//                               ),
//                               onPressed: () {})
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 140,
//                       height: 35,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "122 Comments",
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: 100,
//                       height: 35,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Top",
//                             style: TextStyle(fontSize: 13, color: Colors.grey),
//                           ),
//                           Icon(
//                             Icons.more_vert,
//                             color: Colors.white,
//                           ),
//                           Text(
//                             "New",
//                             style: TextStyle(
//                                 fontSize: 13, color: Colors.purple[900]),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(mainAxisAlignment: MainAxisAlignment.start, children: <
//                   Widget>[
//                 const Padding(
//                   padding: EdgeInsets.only(left: 20.0, top: 30),
//                   child: CircleAvatar(
//                     radius: 20,
//                     backgroundImage: AssetImage(
//                       "assets/profile-img.png",
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 40.0, top: 40),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         const Text(
//                           "Jake",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 5),
//                           child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: <Widget>[
//                                 Container(
//                                   width: 130,
//                                   height: 30,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
                                      
//                                       borderRadius: BorderRadius.circular(15)),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(
//                                         Icons.batch_prediction,
//                                         color: Colors.purple,
//                                       ),
//                                       Text(
//                                         "Top 100 Readers",
//                                         style: TextStyle(
//                                             fontSize: 13,
//                                             color: Colors.purple[900]),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ]),
//                         ),
                        
//                       ]),
//                 )
//               ]),
//               SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0, left: 100, right: 5),
//                 child: Text(
//                   "The definition of a character is a unique symbol, letter or mark used in writing. Character is defined as a trait, quality or high moral code. An example of character is someone who is known for being funny. An example of character is a person who is trustworthy.One way to classify characters is by examining how they change (or don't change) over the course of a story. Grouped in this way by character development, character types include the dynamic character, the round character, the static character, the stock character, and the symbolic character.",
//                   style: TextStyle(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14),
//                 ),
//               ),
//               SizedBox(height: 10),
//               SizedBox(width: 10),
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0, left: 100, right: 5),
//                 child: Row(
//                   children: <Widget>[
//                     Text("21.12.2021",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                         )),

//                     SizedBox(width: 10.0),
//                     Text("09.23 am",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                         )),
//                     SizedBox(width: 10.0),
//                     Icon(
//                       Icons.arrow_upward,
//                       size: 25.0,
//                       color: Colors.purple[900],
//                     ),
//                     SizedBox(width: 5.0),
//                     Text("233",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                         )),
//                     SizedBox(width: 10.0),
//                     Icon(
//                       Icons.arrow_downward,
//                       size: 25.0,
//                       color: Colors.grey,
//                     ),
//                     SizedBox(width: 5.0),
//                     Text("43",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                         )),
//                     SizedBox(width: 10.0),
//                     Icon(
//                       Icons.comment,
//                       size: 25.0,
//                       color: Colors.grey,
//                     ),
//                     SizedBox(width: 5.0),
//                     Text("22",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                         )),
//                     SizedBox(width: 5.0),
               
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0, left: 100, right: 5),
//                 child: Container(
//                   height: 150,
//                   child: IntrinsicHeight(
//                     child: Row(
//                       children: [
//                         VerticalDivider(
//                           color: Colors.grey,
//                           thickness: 2,
//                         ),
//                         Container(
//                           width: 300,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: Colors.grey,
//                               border:
//                                   Border.all(color: Colors.grey, width: 4.0),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(8.0))),
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Text("Peter:",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                       )),
//                                 ],
//                               ),
//                               SizedBox(height: 5),
//                               Text(
//                                   'The definition of a character is a unique symbol, letter or mark used in writing. Character is defined as a trait, quality or high moral code.',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                   )),
//                               SizedBox(height: 15),
//                               Row(
//                                 children: <Widget>[
//                                   Text("21.12.2021",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                       )),

//                                   SizedBox(width: 5.0),
//                                   Text("09.23 am",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                       )),
//                                   SizedBox(width: 5.0),
//                                   Icon(
//                                     Icons.arrow_upward,
//                                     size: 25.0,
//                                     color: Colors.purple[900],
//                                   ),
//                                   SizedBox(width: 5.0),
//                                   Text("233",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                       )),
//                                   SizedBox(width: 5.0),
//                                   Icon(
//                                     Icons.arrow_downward,
//                                     size: 25.0,
//                                     color: Colors.black,
//                                   ),
//                                   SizedBox(width: 5.0),
//                                   Text("43",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                       )),
//                                   SizedBox(width: 10.0),
//                                   Icon(
//                                     Icons.comment,
//                                     size: 25.0,
//                                     color: Colors.black,
//                                   ),
//                                   SizedBox(width: 5.0),
//                                   Text("22",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                       )),
//                                   SizedBox(width: 5.0),
                                 
//                                 ],
//                               ),
//                               SizedBox(height: 15),
//                               Row(
//                                 children: [
//                                   Text("Total 23 Replies",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                       )),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 15),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 50,
//                     width: 380,
//                     child: TextFormField(
//                       textAlign: TextAlign.right,
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.grey,
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               const BorderSide(width: 3, color: Colors.grey),
//                           borderRadius: BorderRadius.circular(0),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     child: IconButton(
//                         icon: Icon(Icons.arrow_right),
//                         color: Colors.white,
//                         onPressed: () {
//                           showAlert(context);
//                         }),
//                   )
//                 ],
//               ),
          
//             ])));
//   }
// }


// //dailog box
// showAlert(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: Colors.black,
//         title: Center(
//           child: Text("Report Comments ?",
//               style: TextStyle(color: Colors.white, fontSize: 18)),
//         ),
      
//       actions:
//       <Widget>[
//         FlatButton(
//           child: Padding(
//             padding: const EdgeInsets.only(right:68.0),
//             child: Text("Cancle",
//                 style: TextStyle(color: Colors.grey, fontSize: 16)),
//           ),
//           onPressed: () {
//             //Put your code here which you want to execute on Yes button click.
//             Navigator.of(context).pop();
//           },
//         ),
//         FlatButton(
//           child: Text("Report",
//               style: TextStyle(color: Colors.purple[900], fontSize: 16)),
//           onPressed: () {
//             //Put your code here which you want to execute on Cancel button click.
//             Navigator.of(context).pop();
//           },
//         ),
//       ]);
//     },
//   );
// }
