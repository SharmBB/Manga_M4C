import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/views/Account/account.dart';
import 'package:mangakiku_app/views/Comments/comments.dart';
import 'package:mangakiku_app/views/Comments/comments_reply.dart';
import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:mangakiku_app/views/LeaderBoard/leaderboard.dart';
import 'package:mangakiku_app/views/Library/library.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({
    key,
  }) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var currentIndex = 0;
  int selectedIndex = 0;

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.settings,
    Icons.account_box,
    Icons.library_add_rounded,
    Icons.leaderboard,
  ];

  int bottomPurple = 1;
  String? token;

  bool _isLoading = true;

  bool isSwitchOn = false;

  @override
  void initState() {
    //initialize  id for chapterimage

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //initialize list for add chapter image from API

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text(
          'Management',
          style: TextStyle(
              color: kPrimaryWhiteColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          // ignore: deprecated_member_use
          overscroll.disallowGlow();
          return false;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  highlightColor: kPrimaryPurpleColor,
                  onTap: () => null,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                      top: 10,
                    ),
                    child: Container(
                      height: 30,
                      child: Row(
                        children: [
                          Icon(
                            Icons.subscriptions_rounded,
                            size: 22.0,
                            color: kPrimaryWhiteColor,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Subsciption",
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  highlightColor: kPrimaryPurpleColor,
                  onTap: () => null,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                      top: 10,
                    ),
                    child: Container(
                      height: 30,
                      child: Row(
                        children: [
                          Icon(
                            Icons.star_rate_sharp,
                            size: 24.0,
                            color: kPrimaryWhiteColor,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Rate Us",
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  highlightColor: kPrimaryPurpleColor,
                  onTap: () => null,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                      top: 10,
                    ),
                    child: Container(
                      height: 30,
                      child: Row(
                        children: [
                          Icon(
                            Icons.share_rounded,
                            size: 24.0,
                            color: kPrimaryWhiteColor,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Share",
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  highlightColor: kPrimaryPurpleColor,
                  onTap: () => null,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                      top: 10,
                    ),
                    child: Container(
                      height: 30,
                      child: Row(
                        children: [
                          Icon(
                            Icons.face_rounded,
                            size: 24.0,
                            color: kPrimaryWhiteColor,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Join Discord",
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  highlightColor: kPrimaryPurpleColor,
                  onTap: () => null,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                      top: 10,
                    ),
                    child: Container(
                      height: 45,
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reading Mode",
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Right to Left",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  highlightColor: kPrimaryPurpleColor,
                  onTap: () => null,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                      top: 10,
                    ),
                    child: Container(
                      height: 45,
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dark Mode",
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Follow System",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  highlightColor: kPrimaryPurpleColor,
                  onTap: () => null,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                      top: 10,
                    ),
                    child: Container(
                      height: 45,
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Language",
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "English",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  highlightColor: kPrimaryPurpleColor,
                  onTap: () => null,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                      top: 10,
                    ),
                    child: Container(
                      height: 45,
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Source",
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "ComickFun",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 10,
                    top: 10,
                  ),
                  child: Container(
                    height: 30,
                    width: screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Notification",
                          style: TextStyle(
                            color: kPrimaryWhiteColor,
                            fontSize: 18,
                          ),
                        ),
                        FlutterSwitch(
                          width: 50.0,
                          height: 25.0,
                          activeColor: kPrimaryPurpleColor,
                          valueFontSize: 12.0,
                          toggleSize: 18.0,
                          value: isSwitchOn,
                          onToggle: (val) {
                            setState(() {
                              isSwitchOn = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  highlightColor: kPrimaryPurpleColor,
                  onTap: () => null,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                      top: 10,
                    ),
                    child: Container(
                      height: 30,
                      child: Row(
                        children: [
                          Icon(
                            Icons.privacy_tip_rounded,
                            size: 24.0,
                            color: kPrimaryWhiteColor,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Privacy Policy",
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
                      MaterialPageRoute(builder: (context) => Setting()),
                    );
                  } else if (currentIndex == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Account()),
                    );
                  } else if (currentIndex == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Library()),
                    );
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
}
