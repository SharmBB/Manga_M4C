import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/component/accountCard.dart';
import 'package:mangakiku_app/component/bottomNavigationBar.dart';
import 'package:mangakiku_app/views/Browser/browser.dart';
import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:mangakiku_app/views/LeaderBoard/leaderboard.dart';
import 'package:mangakiku_app/views/Library/library.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String image = "";
  String bio = "";
  String name = "";
  int? usernameId;
  String? usernameDB;
  String? token;

    var currentIndex = 0;
  int selectedIndex = 0;

//bottom navigation bar icons
  List<IconData> listOfIcons = [
   Icons.home_rounded,
    Icons.description_outlined,
    Icons.account_box,
    Icons.library_add_rounded,
    Icons.leaderboard,
  ];

  //bottom navigation purpl

  List User = [];
  // loader
  bool _isLoading = true;

  int bottomPurple = 2;

  @override
  initState() {
    _getUserById();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var userImage = "http://mangakiku-api.moodfor.codes/images";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        leadingWidth: 70,
        centerTitle: true,
        title: const Text(
          'Account',
          style: TextStyle(
              color: kPrimaryWhiteColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: _isLoading
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: CupertinoActivityIndicator(),
            ))
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                         Padding(
                          padding: EdgeInsets.only(left: 40.0, top: 37),
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: NetworkImage(
                            userImage+User[0]['image'],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 38.0, top: 25),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  User[0]['name'],
                                  style: TextStyle(
                                      color: kPrimaryWhiteColor,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "User name - " + User[0]['name'],
                                          style: TextStyle(
                                              color: kPrimaryWhiteColor,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Bio - " + User[0]['bio'],
                                          style: TextStyle(
                                              color: kPrimaryWhiteColor,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                )
                              ]),
                        ),
                      ]),
                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: kPrimaryPurpleColor,
                                borderRadius: BorderRadius.circular(1)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "12",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white70),
                                  ),
                                  Text(
                                    "Hours Read",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white70),
                                  ),
                                ])),
                        SizedBox(width: 5),
                        Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: kPrimaryPurpleColor,
                                borderRadius: BorderRadius.circular(1)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "12",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white70),
                                  ),
                                  Text(
                                    "Mangas Read",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white70),
                                  ),
                                ])),
                        SizedBox(width: 5),
                        Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: kPrimaryPurpleColor,
                                borderRadius: BorderRadius.circular(1)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "12",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white70),
                                  ),
                                  Text(
                                    "Reputation",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white70),
                                  ),
                                ])),
                        SizedBox(width: 5),
                        Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: kPrimaryPurpleColor,
                                borderRadius: BorderRadius.circular(1)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "12",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white70),
                                  ),
                                  Text(
                                    "Chapter Read",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white70),
                                  ),
                                ])),
                      ],
                    ),
                  ),

                  //Tab bar
                  DefaultTabController(
                    length: 2, // length of tabs
                    initialIndex: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: TabBar(
                            labelColor: kPrimaryPurpleColor,
                            unselectedLabelColor: Colors.white,
                            tabs: [
                              Tab(
                                text: 'My Librarary',
                              ),
                              Tab(text: 'Favourites'),
                            ],
                          ),
                        ),
                        Container(
                          height: 400, //height of TabBarView
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.purple, width: 0.5),
                            ),
                          ),
                          child: TabBarView(
                            children: <Widget>[
                              MangakikuCard(),
                              MangakikuCard(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                      MaterialPageRoute(builder: (context) => Account()),
                    );
                  } else if (currentIndex == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  Library()),
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
                      MaterialPageRoute(builder: (context) =>  HomePage()),
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

  // void _getUserById() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   print("data from sample screen");
  //   token = localStorage.getString('token');

  //   var res = await CallApi().getUserById('getUserById');

  //   var body = json.decode(res.body);
  //   print(body);
  //   User.add(body);
  //   print(User);

  //   setState(() {
  //     // isAuth = true;
  //   });
  // }

  void _getUserById() async {
    setState(() {
      _isLoading = true;
    });
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      print("data from sample screen");
      token = localStorage.getString('token');

      var res = await CallApi().getUserById('getUserById');

      var body = json.decode(res.body);
      print(body);
      User.add(body);
      print(User);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  // void _getUserDetails() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   print("data from sample screen");
  //   usernameId = localStorage.getInt('userId');
  //   image = localStorage.getString("image")!;
  //   name = localStorage.getString("name")!;
  //   bio = localStorage.getString("bio")!;
  //   var data = {"id": usernameId, "pic": image, "bio": bio, "name": name};
  //   print(image);
  //   print(usernameId);
  //   print(name);
  //   print(bio);

  // }

}
