import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/views/Account/account.dart';
import 'package:mangakiku_app/views/Browser/browser.dart';
import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:mangakiku_app/views/Library/library.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  List _getLeaderBoard = [];

  late DateTime today;

  String? token;

  @override
  void initState() {
    getLeaderBoard();
    today = DateTime.now();

    super.initState();
  }

  List User = [];
  List _getLeaderBoardDetails = [];

  // loader
  bool _isLoading = true;

  var currentIndex = 0;
  int selectedIndex = 0;

//bottom navigation bar icons
  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.description_outlined,
    Icons.settings_rounded,
    Icons.notification_important_outlined,
    Icons.collections_bookmark_outlined,
  ];

  //bottom navigation purple
  int bottomPurple = 4;

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
      backgroundColor: primaryColor,
      body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            // ignore: deprecated_member_use
            overscroll.disallowGlow();
            return false;
          },
          child:_isLoading
            ? Center(
                child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: CupertinoActivityIndicator(),
              ))
            :  Container(
              color: primaryColor,
              child: ListView(padding: EdgeInsets.only(top: 40), children: <
                  Widget>[
                Center(
                  child: Text(
                    "${DateFormat("dd MMMM yyyy").format(today)}",
                    style: TextStyle(fontSize: 14, color: kPrimaryWhiteColor),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 25),
                          height: MediaQuery.of(context).size.height,
                          width: double.infinity,
                          child: ListView.builder(
                              itemCount: _getLeaderBoardDetails.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0,
                                      left: 15,
                                      bottom: 5,
                                      right: 15),
                                  child: Container(
                                      //  color: kPrimaryWhiteColor.withOpacity(0.1),
                                      child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: CircleAvatar(
                                          radius: 25.0,
                                          backgroundImage: AssetImage(
                                            "assets/profile-img.png",
                                          ),
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: CircleAvatar(
                                      //     radius: 10.0,
                                      //     backgroundImage: AssetImage(
                                      //       "assets/batch.jpg",
                                      //     ),
                                      //   ),
                                      // ),
                                      Expanded(
                                        child: Text(
                                            _getLeaderBoardDetails[index]
                                                ['name'],
                                            style: TextStyle(
                                                color: kPrimaryWhiteColor,
                                                fontSize: 10),
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
                                                color: kPrimaryWhiteColor,
                                                fontSize: 10),
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
                                                color: kPrimaryWhiteColor,
                                                fontSize: 10),
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
                                                color: kPrimaryWhiteColor,
                                                fontSize: 10),
                                            textAlign: TextAlign.left),
                                      ),
                                    ],
                                  )),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ]))),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        height: screenWidth * .155,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .034),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(
                () {
                  currentIndex = index;
                  print(currentIndex);
                  if (currentIndex == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Browser()),
                    );
                  } else if (currentIndex == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Account()),
                    );
                  } else if (currentIndex == 3) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const Library()),
                    // );
                  } else if (currentIndex == 4) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LeaderBoardScreen()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  }
                },
              );
            },
            child: Stack(
              children: [
                Container(
                  width: screenWidth * .1700,
                  alignment: Alignment.center,
                  child: Icon(
                    listOfIcons[index],
                    size: screenWidth * .076,
                    color: index == bottomPurple
                        ? kPrimaryPurpleColor
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //get LeaderBoard details from api
  void getLeaderBoard() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _getLeaderBoardDetails.clear();

      var bodyRoutes;
      var res = await CallApi().getLeaderBoard('getLeaderBoard');
      bodyRoutes = json.decode(res.body);

      _getLeaderBoardDetails = bodyRoutes;
      print(_getLeaderBoardDetails.length);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
