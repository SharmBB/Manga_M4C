import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/views/Account/account.dart';
import 'package:mangakiku_app/views/Browser/browser.dart';
import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:mangakiku_app/views/LeaderBoard/leaderboard.dart';
import 'package:mangakiku_app/views/Library/library.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
    Icons.article_outlined,
    Icons.local_library_outlined,
    Icons.leaderboard,
    Icons.settings,
  ];

  int bottomPurple = 4;
  String? token;

  bool _isLoading = true;
  bool isSwitchOn = false;

  get https => null;

  @override
  void initState() {
    //initialize  id for chapterimage
    _getRead();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? selectevalue;

  void _getRead() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    setState(() {
      selectevalue = localStorage.getString("selectevalue");
    });
    //print('  selectevalue' + selectevalue.toString());
  }

  void _launchURL() async {
    if (!await launch("https://discord.gg/XwByXFde9s"))
      throw 'Could not launch $https://discord.gg/XwByXFde9s';
  }

  void _launchRateURL() async {
    if (!await launch(
        "https://play.google.com/store/apps/details?id=com.mfc.mangakiku_app"))
      throw 'Could not launch $https://play.google.com/store/apps/details?id=com.mfc.mangakiku_app';
  }

  //initialize list for add chapter image from API

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: kPrimaryWhiteColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        title: Text(
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
                  onTap: () {
                    _showSubcontent();
                  },
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
                  onTap: () {
                    _launchRateURL();
                  },
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
                  onTap: () {
                    Share.share(
                        'Do you Like Manga? Check out this awessome app: https://play.google.com/store/apps/details?id=com.mfc.mangakiku_app');
                  },
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
                  onTap: () {
                    _launchURL();
                  },
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
                  onTap: () {
                    _showReadcontent();
                    print(_selectedRead);
                  },
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
                            selectevalue.toString(),
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
                // SizedBox(
                //   height: 20,
                // ),
                // InkWell(
                //   highlightColor: kPrimaryPurpleColor,
                //   onTap: () {
                //     _showDarkcontent();
                //   },
                // child: Padding(
                //   padding: const EdgeInsets.only(
                //     left: 20,
                //     right: 20,
                //     bottom: 10,
                //     top: 10,
                //   ),
                //   child: Container(
                //     height: 45,
                //     width: screenWidth,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "Dark Mode",
                //           style: TextStyle(
                //             color: kPrimaryWhiteColor,
                //             fontSize: 18,
                //           ),
                //         ),
                //         SizedBox(
                //           height: 5,
                //         ),
                //         Text(
                //           _selectedDark,
                //           style: TextStyle(
                //             color: Colors.grey,
                //             fontSize: 14,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  highlightColor: kPrimaryPurpleColor,
                  onTap: () {
                    _showLanguagecontent();
                  },
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
                            _selectedLanguage,
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
                // InkWell(
                //   highlightColor: kPrimaryPurpleColor,
                //   onTap: () {
                //     _showSourcecontent();
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.only(
                //       left: 20,
                //       right: 20,
                //       bottom: 10,
                //       top: 10,
                //     ),
                //     child: Container(
                //       height: 45,
                //       width: screenWidth,
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             "Source",
                //             style: TextStyle(
                //               color: kPrimaryWhiteColor,
                //               fontSize: 18,
                //             ),
                //           ),
                //           SizedBox(
                //             height: 5,
                //           ),
                //           Text(
                //             "ComickFun",
                //             style: TextStyle(
                //               color: Colors.grey,
                //               fontSize: 14,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //     left: 20,
                //     right: 20,
                //     bottom: 10,
                //     top: 10,
                //   ),
                //   child: Container(
                //     height: 30,
                //     width: screenWidth,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           "Notification",
                //           style: TextStyle(
                //             color: kPrimaryWhiteColor,
                //             fontSize: 18,
                //           ),
                //         ),
                //         FlutterSwitch(
                //           width: 50.0,
                //           height: 25.0,
                //           activeColor: kPrimaryPurpleColor,
                //           valueFontSize: 12.0,
                //           toggleSize: 18.0,
                //           value: isSwitchOn,
                //           onToggle: (val) {
                //             setState(() {
                //               isSwitchOn = val;
                //             });
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
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
                      MaterialPageRoute(builder: (context) => Browser()),
                    );
                  } else if (currentIndex == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Library()),
                    );
                  } else if (currentIndex == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LeaderBoardScreen()),
                    );
                  } else if (currentIndex == 4) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),
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

  String _selectedSub = 'Lifetime Membership (LKR 3,050.00)';

  void _showSubcontent() {
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!

        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                backgroundColor: Colors.grey.shade900,
                contentPadding: EdgeInsets.only(
                  left: 5,
                  top: 10,
                  right: 10,
                ),
                content: Container(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: kPrimaryPurpleColor,
                            value: 'Lifetime Membership (LKR 3,050.00)',
                            groupValue: _selectedSub,
                            onChanged: (value) {
                              setState(() {
                                _selectedSub = value!;
                              });
                            },
                          ),
                          Text(
                            'Lifetime Membership (LKR 3,050.00)',
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: kPrimaryPurpleColor,
                            value: 'Monthly Subscription (LKR 225.00)',
                            groupValue: _selectedSub,
                            onChanged: (value) {
                              setState(() {
                                _selectedSub = value!;
                              });
                            },
                          ),
                          Text(
                            'Monthly Subscription (LKR 225.00)',
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: kPrimaryPurpleColor,
                            value: 'Yearly Subscription (LKR 195.00)',
                            groupValue: _selectedSub,
                            onChanged: (value) {
                              setState(() {
                                _selectedSub = value!;
                              });
                            },
                          ),
                          Text(
                            'Yearly Subscription (LKR 195.00)',
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: kPrimaryPurpleColor,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        });
  }

  String _selectedRead = 'Right to Left';

  void _showReadcontent() {
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!

        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                backgroundColor: Colors.grey.shade900,
                title: Text(
                  'Reading Mode',
                  style: TextStyle(
                    color: kPrimaryWhiteColor,
                    fontSize: 18,
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 10, top: 10),
                content: Container(
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: kPrimaryPurpleColor,
                            value: 'Left to Right',
                            groupValue: _selectedRead,
                            onChanged: (value) {
                              setState(() {
                                _selectedRead = value!;
                                selectevalue = value.toString();
                              });
                            },
                          ),
                          Text(
                            'Left to Right',
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: kPrimaryPurpleColor,
                            value: 'Right to Left',
                            groupValue: _selectedRead,
                            onChanged: (value) {
                              setState(() {
                                _selectedRead = value!;
                                selectevalue = value.toString();
                              });
                            },
                          ),
                          Text(
                            'Right to Left',
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: kPrimaryPurpleColor,
                            value: 'Vertical',
                            groupValue: _selectedRead,
                            onChanged: (value) {
                              setState(() {
                                _selectedRead = value!;
                                selectevalue = value.toString();
                              });
                            },
                          ),
                          Text(
                            'Vertical',
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: kPrimaryPurpleColor,
                            value: 'Vertical Reverse',
                            groupValue: _selectedRead,
                            onChanged: (value) {
                              setState(() {
                                _selectedRead = value!;
                                selectevalue = value.toString();
                              });
                            },
                          ),
                          Text(
                            'Vertical Reverse',
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: kPrimaryPurpleColor,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () async {
                      setState() {
                        selectevalue = _selectedRead;
                      }

                      addReadingMode();
                      // print(_selectedRead);
                      SharedPreferences localStorage =
                          await SharedPreferences.getInstance();

                      var value = _selectedRead;

                      // print(selectevalue);

                      localStorage.setString('selectevalue', value);
                      //print(selectevalue);

                      // localStorage.setInt('userId', userId);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        });
  }

  String _selectedDark = 'On';

  void _showDarkcontent() {
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!

        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                backgroundColor: Colors.grey.shade900,
                title: Text(
                  'Dark Mode',
                  style: TextStyle(
                    color: kPrimaryWhiteColor,
                    fontSize: 18,
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 10, top: 10),
                content: Container(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: kPrimaryPurpleColor,
                            value: 'On',
                            groupValue: _selectedDark,
                            onChanged: (value) {
                              setState(() {
                                _selectedDark = value!;
                              });
                            },
                          ),
                          Text(
                            'On',
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: kPrimaryPurpleColor,
                            value: 'Off',
                            groupValue: _selectedDark,
                            onChanged: (value) {
                              setState(() {
                                _selectedDark = value!;
                              });
                            },
                          ),
                          Text(
                            'Off',
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: kPrimaryPurpleColor,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        });
  }

  String _selectedLanguage = 'English';

  void _showLanguagecontent() {
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!

        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                backgroundColor: Colors.grey.shade900,
                title: Text(
                  'Language',
                  style: TextStyle(
                    color: kPrimaryWhiteColor,
                    fontSize: 18,
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 10, top: 10),
                content: Container(
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: kPrimaryPurpleColor,
                            value: 'English',
                            groupValue: _selectedLanguage,
                            onChanged: (value) {
                              setState(() {
                                _selectedLanguage = value!;
                              });
                            },
                          ),
                          Text(
                            'English',
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Radio<String>(
                      //       activeColor: kPrimaryPurpleColor,
                      //       value: 'Italiano',
                      //       groupValue: _selectedLanguage,
                      //       onChanged: (value) {
                      //         setState(() {
                      //           _selectedLanguage = value!;
                      //         });
                      //       },
                      //     ),
                      //     Text(
                      //       'Italiano',
                      //       style: TextStyle(
                      //         color: kPrimaryWhiteColor,
                      //         fontSize: 14,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: kPrimaryPurpleColor,
                            value: 'Francasis',
                            groupValue: _selectedLanguage,
                            onChanged: (value) {
                              setState(() {
                                _selectedLanguage = value!;
                              });
                            },
                          ),
                          Text(
                            'Francsis',
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Radio<String>(
                      //       activeColor: kPrimaryPurpleColor,
                      //       value: 'Deutsch',
                      //       groupValue: _selectedLanguage,
                      //       onChanged: (value) {
                      //         setState(() {
                      //           _selectedLanguage = value!;
                      //         });
                      //       },
                      //     ),
                      //     Text(
                      //       'Deutsch',
                      //       style: TextStyle(
                      //         color: kPrimaryWhiteColor,
                      //         fontSize: 14,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   children: [
                      //     Radio<String>(
                      //       activeColor: kPrimaryPurpleColor,
                      //       value: 'Portugues do Brasil',
                      //       groupValue: _selectedLanguage,
                      //       onChanged: (value) {
                      //         setState(() {
                      //           _selectedLanguage = value!;
                      //         });
                      //       },
                      //     ),
                      //     Text(
                      //       'Portugues do Brasil',
                      //       style: TextStyle(
                      //         color: kPrimaryWhiteColor,
                      //         fontSize: 14,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: kPrimaryPurpleColor,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () async {
                      SharedPreferences localStorage =
                          await SharedPreferences.getInstance();

                      var selectelanguage = _selectedLanguage;
                      // print(selectevalue);
                      localStorage.setString(
                          'selectelanguage', selectelanguage);
                      print(selectelanguage);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        });
  }

  String _selectedSource = 'ComickFun';

  void _showSourcecontent() {
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!

        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                backgroundColor: Colors.grey.shade900,
                title: Text(
                  'Source',
                  style: TextStyle(
                    color: kPrimaryWhiteColor,
                    fontSize: 18,
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 10, top: 10),
                content: Container(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: kPrimaryPurpleColor,
                            value: 'ComickFun',
                            groupValue: _selectedSource,
                            onChanged: (value) {
                              setState(() {
                                _selectedSource = value!;
                              });
                            },
                          ),
                          Text(
                            'ComickFun',
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: kPrimaryPurpleColor,
                            value: 'Mangakakalot',
                            groupValue: _selectedSource,
                            onChanged: (value) {
                              setState(() {
                                _selectedRead = value!;
                              });
                            },
                          ),
                          Text(
                            'Mangakakalot',
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: kPrimaryPurpleColor,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        });
  }

  void addReadingMode() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var data = {
        "readingMode": _selectedRead,
      };
      var res = await CallApi().postData(data, 'updateReadingMode');
      var body = json.decode(res.body);
      print(body);

      if (body['token'] != null) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var token = body['token'];
        localStorage.setString('token', token);

        print(body);
      } else {}
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
