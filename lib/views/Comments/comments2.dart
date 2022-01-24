import 'package:flutter/material.dart';
import 'package:mangakiku_app/views/Comments/comments.dart';
import 'package:mangakiku_app/views/Home/homePage.dart';

class MangaComment2 extends StatefulWidget {
  const MangaComment2({ Key? key }) : super(key: key);

  @override
  _MangaComment2State createState() => _MangaComment2State();
}

class _MangaComment2State extends State<MangaComment2> {
  @override
  Widget build(BuildContext context) { 
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: ListView(children: [
              Stack(
                children: <Widget>[
                  Container(
                    height: screenHeight * (18 / 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Image(
                      image: AssetImage("assets/image-4.png"),
                      width: screenWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 145.0, vertical: 50.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Chapter 2 ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center),
                          ])),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {
                              Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                      );
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.keyboard_control_rounded,
                                color: Colors.white,
                              ),
                              onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                ],
              ),
               
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                     IconButton(
                        icon: Icon(Icons.arrow_back_ios_new),
                        color: Colors.white,
                        onPressed: () {
                       
                        }),

                   // SizedBox(width: screenWidth * (1 / 10)),
                    IconButton(
                        icon: Icon(Icons.thumb_up_off_alt ),
                        color: Colors.white,
                        onPressed: () {
                       
                        }),
                 //  SizedBox(width: screenWidth * (1 / 10)),
                     IconButton(
                        icon: Icon(Icons.comment_outlined),
                        color: Colors.white,
                        onPressed: () {
                       
                        }),
                  //  SizedBox(width: screenWidth * (1 / 10)),
                     IconButton(
                        icon: Icon(Icons.favorite),
                        color: Colors.white,
                        onPressed: () {
                       
                        }),
                  //   SizedBox(width: screenWidth * (1 / 10)),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        color: Colors.white,
                        onPressed: () {
                       
                        }),
                  
               
                  ],
                ),
              
      
            ])));
  }
}