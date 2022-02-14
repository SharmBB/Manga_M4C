import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/component/libraryImage.dart';
import 'package:mangakiku_app/views/Account/account.dart';
import 'package:mangakiku_app/views/Browser/browser.dart';
import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:mangakiku_app/views/LeaderBoard/leaderboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Library extends StatefulWidget {
  Library();

  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<Library> {
  // _LeaderBoardScreenState();
  var currentIndex = 0;
  int selectedIndex = 0;

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.settings,
    Icons.account_box,
    Icons.library_add_rounded,
    Icons.leaderboard,
  ];

  List _getLibrary = [];
  List _getFavourite = [];
  // List chapterUsingID = [];
  // List chaptersFromDB = [];
  // List chapterLanguage = [];

  int bottomPurple = 3;

// loader
  bool _isLoading = true;

  String dropdownValue = 'English';
  String token = "";

  @override
  void initState() {
    getUserLibrary();
    getUserFavourite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: kPrimaryWhiteColor),
          onPressed: () {
            //    _sendDataBack(context);
            Navigator.pop(
              context,
            );
          },
        ),
        leadingWidth: 70,
        centerTitle: true,
        title: const Text(
          'Library',
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
              padding: const EdgeInsets.only(top: 30.0),
              child: CupertinoActivityIndicator(
                radius: 15,
              ),
            ))
          // : SingleChildScrollView(
          //     child: Column(children: <Widget>[
          //     DefaultTabController(
          //         length: 2, // length of tabs
          //         initialIndex: 0,
          //         child: Column(children: <Widget>[
          //           Container(
          //             child: TabBar(
          //               labelColor: Colors.purple[900],
          //               unselectedLabelColor: Colors.white,
          //               tabs: [
          //                 Tab(
          //                   text: 'Library',
          //                 ),
          //                 Tab(text: 'History'),

          //               ],
          //             ),
          //           ),
          //           Container(
          //             height: screenHeight, //height of TabBarView
          //             decoration: BoxDecoration(
          //                 border: Border(
          //                     top: BorderSide(
          //                         color: Colors.purple, width: 0.5))),
          //             child: TabBarView(children: <Widget>[
          //               Padding(
          //                 padding: const EdgeInsets.all(8.0),
          : SingleChildScrollView(
              child: Column(children: <Widget>[
                DefaultTabController(
                    length: 2, // length of tabs
                    initialIndex: 0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            height: 30,
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0)),
                                  color: Colors.purple[900]),
                              // labelColor: Colors.purple[900],

                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                Tab(
                                  text: 'My Library',
                                ),
                                Tab(text: 'Favourites'),
                              ],
                            ),
                          ),
                          Container(
                            height: 400, //height of TabBarView
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.purple, width: 0.5))),
                            child: TabBarView(children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[],
                                    ),
                                  ),
                                  Container(
                                    height: 360.0,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _getLibrary.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          margin: EdgeInsets.all(10.0),
                                          width: 180.0,
                                          child: Stack(
                                            alignment: Alignment.topCenter,
                                            children: <Widget>[
                                              Positioned(
                                                bottom: 15.0,
                                                child: Container(
                                                  height: 120.0,
                                                  width: 200.0,
                                                  decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          _getLibrary[index][
                                                                          'title']
                                                                      .length <=
                                                                  20
                                                              ? _getLibrary[
                                                                          index]
                                                                      ['title']
                                                                  .toString()
                                                              : _getLibrary[
                                                                          index]
                                                                      ['title']
                                                                  .toString()
                                                                  .substring(
                                                                      0, 20),
                                                          style: TextStyle(
                                                            color:
                                                                kPrimaryWhiteColor,
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5.0),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10.0,
                                                                  left: 60),
                                                          child: Row(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.star,
                                                                    size: 15.0,
                                                                    color: Colors
                                                                        .yellow,
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                    _getLibrary[index]
                                                                            [
                                                                            'rating']
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          kPrimaryWhiteColor,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              // SizedBox(width: 45),
                                                              // Text(
                                                              //   ".",
                                                              //   style: TextStyle(
                                                              //     fontSize: 13,
                                                              //     color:
                                                              //         kPrimaryWhiteColor,
                                                              //   ),
                                                              // ),
                                                              // SizedBox(width: 25),
                                                              // Text(
                                                              //   _manga[0]
                                                              //       ['title'],
                                                              //   style: TextStyle(
                                                              //     fontSize: 12,
                                                              //     color:
                                                              //         kPrimaryWhiteColor,
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 6.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            00.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        // print(ViewManga[0][index]);
                                                        // _navigator(
                                                        //     context,
                                                        //     Chapter(
                                                        //         [ViewManga[0][index]]));
                                                      },
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              00.0),
                                                      child: CachedNetworkImage(
                                                          height: 250,
                                                          width: 180,
                                                          imageUrl:
                                                              _getLibrary[index]
                                                                      ['image']
                                                                  .toString(),
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  image: DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .fill),
                                                                ),
                                                              ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(
                                                                  Icons.error)),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              //   CharacterPage(),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[],
                                    ),
                                  ),
                                  Container(
                                    height: 360.0,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _getFavourite.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          margin: EdgeInsets.all(10.0),
                                          width: 180.0,
                                          child: Stack(
                                            alignment: Alignment.topCenter,
                                            children: <Widget>[
                                              Positioned(
                                                bottom: 15.0,
                                                child: Container(
                                                  height: 120.0,
                                                  width: 200.0,
                                                  decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          _getFavourite[index][
                                                                          'title']
                                                                      .length <=
                                                                  20
                                                              ? _getFavourite[
                                                                          index]
                                                                      ['title']
                                                                  .toString()
                                                              : _getFavourite[
                                                                          index]
                                                                      ['title']
                                                                  .toString()
                                                                  .substring(
                                                                      0, 20),
                                                          style: TextStyle(
                                                            color:
                                                                kPrimaryWhiteColor,
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5.0),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10.0,
                                                                  left: 60),
                                                          child: Row(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.star,
                                                                    size: 15.0,
                                                                    color: Colors
                                                                        .yellow,
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                    _getFavourite[index]
                                                                            [
                                                                            'rating']
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          kPrimaryWhiteColor,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              // SizedBox(width: 45),
                                                              // Text(
                                                              //   ".",
                                                              //   style: TextStyle(
                                                              //     fontSize: 13,
                                                              //     color:
                                                              //         kPrimaryWhiteColor,
                                                              //   ),
                                                              // ),
                                                              // SizedBox(width: 25),
                                                              // Text(
                                                              //   _manga[0]
                                                              //       ['title'],
                                                              //   style: TextStyle(
                                                              //     fontSize: 12,
                                                              //     color:
                                                              //         kPrimaryWhiteColor,
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 6.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            00.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        // print(ViewManga[0][index]);
                                                        // _navigator(
                                                        //     context,
                                                        //     Chapter(
                                                        //         [ViewManga[0][index]]));
                                                      },
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              00.0),
                                                      child: CachedNetworkImage(
                                                          height: 250,
                                                          width: 180,
                                                          imageUrl:
                                                              _getFavourite[
                                                                          index]
                                                                      ['image']
                                                                  .toString(),
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  image: DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .fill),
                                                                ),
                                                              ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(
                                                                  Icons.error)),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          )
                        ])),
                // ),
                // Center(
                //     child: Text(
                //   "History",
                //   style: TextStyle(fontSize: 20, color: Colors.white),
                // )),
                // Center(
                //     child: Text(
                //   "Updates",
                //   style: TextStyle(fontSize: 20, color: Colors.white),
                // )),
              ]),
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

  //get UserLibrary details from api
  void getUserLibrary() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _getLibrary.clear();

      var bodyRoutes;

      var res = await CallApi().getUserLibrary('getUserLibrary');
      bodyRoutes = json.decode(res.body);

      _getLibrary = bodyRoutes;
      // print(_getLibrary);
      //  print(_getComments[0].last['comments']);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  //get UserLibrary details from api
  void getUserFavourite() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _getFavourite.clear();

      var bodyRoutes;
      var res = await CallApi().getUserFavourite('getUserFavourite');
      bodyRoutes = json.decode(res.body);

      _getFavourite = bodyRoutes;
      print(_getFavourite);
      //  print(_getComments[0].last['comments']);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
