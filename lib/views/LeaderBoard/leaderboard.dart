import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Leader Board",
              style: TextStyle(
                  fontSize: 18,
                  color: kPrimaryWhiteColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: primaryColor,
        ),
        body: Container(
            color: primaryColor,
            child:
                ListView(padding: EdgeInsets.only(top: 40), children: <Widget>[
              Center(
                child: Text(
                  "21 April 2021",
                  style: TextStyle(fontSize: 14, color: kPrimaryWhiteColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 12.0, left: 15, bottom: 5, right: 15),
                child: Container(
                  color: kPrimaryWhiteColor.withOpacity(0.1),
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: AssetImage(
                            "assets/profile-img.png",
                          ),
                        ),
                      ),
                      Expanded(
                        child: CircleAvatar(
                          radius: 10.0,
                          backgroundImage: AssetImage(
                            "assets/batch.jpg",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text('Neel Stive ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 10),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text(" 12 ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.end),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Text('Manga Read ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 10),
                            textAlign: TextAlign.left),
                      ),
                      Expanded(
                        child: Text(" 35 ",
                            style: TextStyle(
                                color: kPrimaryWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.end),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Text('Chapter Read ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 10),
                            textAlign: TextAlign.left),
                      ),
                      Expanded(
                        child: Text(" 53 ",
                            style: TextStyle(
                                color: kPrimaryWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.end),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Text('Hours Read  ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 10),
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),

                  /////
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 12.0, left: 15, bottom: 5, right: 15),
                child: Container(
                  color: kPrimaryWhiteColor.withOpacity(0.1),
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: AssetImage(
                            "assets/profile-img.png",
                          ),
                        ),
                      ),
                      Expanded(
                        child: CircleAvatar(
                          radius: 10.0,
                          backgroundImage: AssetImage(
                            "assets/batch.jpg",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text('Neel Stive ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 10),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text(" 12 ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.end),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Text('Manga Read ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 10),
                            textAlign: TextAlign.left),
                      ),
                      Expanded(
                        child: Text(" 35 ",
                            style: TextStyle(
                                color: kPrimaryWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.end),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Text('Chapter Read ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 10),
                            textAlign: TextAlign.left),
                      ),
                      Expanded(
                        child: Text(" 53 ",
                            style: TextStyle(
                                color: kPrimaryWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.end),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Text('Hours Read  ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 10),
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),

                  /////
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 12.0, left: 15, bottom: 5, right: 15),
                child: Container(
                  color: kPrimaryWhiteColor.withOpacity(0.1),
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: AssetImage(
                            "assets/profile-img.png",
                          ),
                        ),
                      ),
                      Expanded(
                        child: CircleAvatar(
                          radius: 10.0,
                          backgroundImage: AssetImage(
                            "assets/batch.jpg",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text('Neel Stive ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 10),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text(" 12 ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.end),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Text('Manga Read ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 10),
                            textAlign: TextAlign.left),
                      ),
                      Expanded(
                        child: Text(" 35 ",
                            style: TextStyle(
                                color: kPrimaryWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.end),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Text('Chapter Read ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 10),
                            textAlign: TextAlign.left),
                      ),
                      Expanded(
                        child: Text(" 53 ",
                            style: TextStyle(
                                color: kPrimaryWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.end),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Text('Hours Read  ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 10),
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),

                  /////
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5, right: 15),
                child: Container(
                  color: kPrimaryWhiteColor.withOpacity(0.1),
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundImage: AssetImage(
                            "assets/user-2.png",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text('John Mars ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Mangas Read: 12',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Chapters Read : 23',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Hours Read : 35',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5, right: 15),
                child: Container(
                  color: kPrimaryWhiteColor.withOpacity(0.1),
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundImage: AssetImage(
                            "assets/user-2.png",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text('John Mars ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Mangas Read: 12',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Chapters Read : 23',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Hours Read : 35',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5, right: 15),
                child: Container(
                  color: kPrimaryWhiteColor.withOpacity(0.1),
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundImage: AssetImage(
                            "assets/user-2.png",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text('John Mars ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Mangas Read: 12',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Chapters Read : 23',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Hours Read : 35',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5, right: 15),
                child: Container(
                  color: kPrimaryWhiteColor.withOpacity(0.1),
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundImage: AssetImage(
                            "assets/user-2.png",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text('John Mars ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Mangas Read: 12',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Chapters Read : 23',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Hours Read : 35',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5, right: 15),
                child: Container(
                  color: kPrimaryWhiteColor.withOpacity(0.1),
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundImage: AssetImage(
                            "assets/user-2.png",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text('John Mars ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Mangas Read: 12',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Chapters Read : 23',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Hours Read : 35',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5, right: 15),
                child: Container(
                  color: kPrimaryWhiteColor.withOpacity(0.1),
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundImage: AssetImage(
                            "assets/user-2.png",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text('John Mars ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Mangas Read: 12',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Chapters Read : 23',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Hours Read : 35',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5, right: 15),
                child: Container(
                  color: kPrimaryWhiteColor.withOpacity(0.1),
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundImage: AssetImage(
                            "assets/user-2.png",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text('John Mars ',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Mangas Read: 12',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Chapters Read : 23',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text('Hours Read : 35',
                            style: TextStyle(
                                color: kPrimaryWhiteColor, fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
            ])));
  }
}
