import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/views/Account/account.dart';
import 'package:mangakiku_app/views/Browser/browser.dart';
import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:mangakiku_app/views/LeaderBoard/leaderboard.dart';
import 'package:mangakiku_app/views/Setting/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Library extends StatefulWidget {
  Library();

  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<Library> {
  var currentIndex = 0;
  int selectedIndex = 0;

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.article_outlined,
    Icons.local_library_outlined,
    Icons.leaderboard,
    Icons.settings,
  ];

  List _getLibrary = [];
  List _getFavourite = [];
  List _getLibraryFiltered = [];
  List _getFavouriteFiltered = [];

  int bottomPurple = 2;

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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
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
          : NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                // ignore: deprecated_member_use
                overscroll.disallowGlow();
                return false;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    DefaultTabController(
                      length: 2,
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
                            height: screenHeight * 0.73,
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.purple, width: 0.5))),
                            child: TabBarView(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[],
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    _isLoading
                                        ? Center(
                                            child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 30.0),
                                            child: CupertinoActivityIndicator(
                                              radius: 15,
                                            ),
                                          ))
                                        : Expanded(
                                            child: ListView.builder(
                                              itemCount:
                                                  _getLibraryFiltered.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                    color: Colors.black12,
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Center(
                                                        child: Container(
                                                          width: 130,
                                                          height: 150,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 15,
                                                                  top: 10),
                                                          child: InkWell(
                                                            onTap: () {
                                                              print("shar");
                                                            },
                                                            child:
                                                                CachedNetworkImage(
                                                                    imageUrl: _getLibraryFiltered[index]
                                                                            [
                                                                            'image']
                                                                        .toString(),
                                                                    imageBuilder:
                                                                        (context,
                                                                                imageProvider) =>
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(5),
                                                                                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                                                                              ),
                                                                            ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(Icons
                                                                            .error)),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                      
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0,
                                                                          right: 20),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                   
                                                               Text(
                                                                _getLibraryFiltered[index]['title']
                                                                            .length <=
                                                                        20
                                                                    ? _getLibraryFiltered[index]
                                                                            [
                                                                            'title']
                                                                        .toString()
                                                                    : _getLibraryFiltered[index]
                                                                            [
                                                                            'title']
                                                                        .toString()
                                                                        .substring(
                                                                            0,
                                                                            20),
                                                                style: TextStyle(
                                                                    color:
                                                                        kPrimaryWhiteColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                                       IconButton(
                                                                icon: Icon(
                                                                  Icons.delete,color: Colors.red,size: 30),
                                                              onPressed: () {
                                                                //
                                                                //go through the loop and match content to delete from list
                                                                setState(() {
                                                                  //refresh UI after deleting element from list
                                                                });
                                                              },
                                                               ),
                                                             
                                                                 ],),
                                                            ),
                                                            SizedBox(
                                                              height: 6,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                // Text(
                                                                //   _getLibrary[index]
                                                                //           [
                                                                //           'rating']
                                                                //       .toString(),
                                                                //   style: TextStyle(
                                                                //       color:
                                                                //           kPrimaryWhiteColor,
                                                                //       fontWeight:
                                                                //           FontWeight
                                                                //               .bold,
                                                                //       fontSize:
                                                                //           12),
                                                                // ),
                                                                SizedBox(
                                                                  height: 6,
                                                                ),
                                                                Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .yellow,
                                                                      size: 12,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                        _getLibraryFiltered[index]['rating']
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                kPrimaryGreyColor,
                                                                            fontSize:
                                                                                13,
                                                                            letterSpacing:
                                                                                .3)),

                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    // Text(
                                                                    //     ". Action",
                                                                    //     style: TextStyle(
                                                                    //         color:
                                                                    //             kPrimaryGreyColor,
                                                                    //         fontSize:
                                                                    //             13,
                                                                    //         letterSpacing:
                                                                    //             .3)),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    // Text(". ch",
                                                                    //     style: TextStyle(
                                                                    //         color:
                                                                    //             kPrimaryGreyColor,
                                                                    //         fontSize:
                                                                    //             13,
                                                                    //         letterSpacing:
                                                                    //             .3)),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                       
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                    // Container(
                                    //   height: 360.0,
                                    //   child: ListView.builder(
                                    //     scrollDirection: Axis.horizontal,
                                    //     itemCount: _getLibrary.length,
                                    //     itemBuilder:
                                    //         (BuildContext context, int index) {
                                    //       return Container(
                                    //         margin: EdgeInsets.all(10.0),
                                    //         width: 180.0,
                                    //         child: Stack(
                                    //           alignment: Alignment.topCenter,
                                    //           children: <Widget>[
                                    //             Positioned(
                                    //               bottom: 15.0,
                                    //               child: Container(
                                    //                 height: 120.0,
                                    //                 width: 200.0,
                                    //                 decoration: BoxDecoration(
                                    //                   color: primaryColor,
                                    //                   borderRadius:
                                    //                       BorderRadius.circular(
                                    //                           0.0),
                                    //                 ),
                                    //                 child: Padding(
                                    //                   padding:
                                    //                       EdgeInsets.all(10.0),
                                    //                   child: Column(
                                    //                     mainAxisAlignment:
                                    //                         MainAxisAlignment.end,
                                    //                     crossAxisAlignment:
                                    //                         CrossAxisAlignment
                                    //                             .start,
                                    //                     children: <Widget>[
                                    //                       Text(
                                    // _getLibrary[index][
                                    //                 'title']
                                    //             .length <=
                                    //         20
                                    //     ? _getLibrary[
                                    //                 index]
                                    //             ['title']
                                    //         .toString()
                                    //     : _getLibrary[
                                    //                 index]
                                    //             ['title']
                                    //         .toString()
                                    //         .substring(
                                    //             0, 20),
                                    //                         style: TextStyle(
                                    //                           color:
                                    //                               kPrimaryWhiteColor,
                                    //                           fontSize: 16.0,
                                    //                         ),
                                    //                       ),
                                    //                       SizedBox(height: 5.0),
                                    //                       Padding(
                                    //                         padding:
                                    //                             const EdgeInsets
                                    //                                     .only(
                                    //                                 top: 10.0,
                                    //                                 left: 60),
                                    //                         child: Row(
                                    //                           children: [
                                    //                             Row(
                                    //                               children: [
                                    //                                 Icon(
                                    //                                   Icons.star,
                                    //                                   size: 15.0,
                                    //                                   color: Colors
                                    //                                       .yellow,
                                    //                                 ),
                                    //                                 SizedBox(
                                    //                                     width:
                                    //                                         10),
                                    //                                 Text(
                                    //                                   _getLibrary[index]
                                    //                                           [
                                    //                                           'rating']
                                    //                                       .toString(),
                                    //                                   style:
                                    //                                       TextStyle(
                                    //                                     fontSize:
                                    //                                         12,
                                    //                                     color:
                                    //                                         kPrimaryWhiteColor,
                                    //                                   ),
                                    //                                 ),
                                    //                               ],
                                    //                             ),
                                    //                           ],
                                    //                         ),
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //             Container(
                                    //               decoration: BoxDecoration(
                                    //                 color: Colors.white,
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(
                                    //                         0.0),
                                    //                 boxShadow: [
                                    //                   BoxShadow(
                                    //                     color: Colors.black26,
                                    //                     blurRadius: 6.0,
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //               child: ClipRRect(
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(
                                    //                         00.0),
                                    //                 child: InkWell(
                                    //                   onTap: () {},
                                    //                   borderRadius:
                                    //                       BorderRadius.circular(
                                    //                           00.0),
                                    //                   child: CachedNetworkImage(
                                    //                       height: 250,
                                    //                       width: 180,
                                    //                       imageUrl:
                                    //                           _getLibrary[index]
                                    //                                   ['image']
                                    //                               .toString(),
                                    //                       imageBuilder: (context,
                                    //                               imageProvider) =>
                                    //                           Container(
                                    //                             decoration:
                                    //                                 BoxDecoration(
                                    //                               borderRadius:
                                    //                                   BorderRadius
                                    //                                       .circular(
                                    //                                           5),
                                    //                               image: DecorationImage(
                                    //                                   image:
                                    //                                       imageProvider,
                                    //                                   fit: BoxFit
                                    //                                       .fill),
                                    //                             ),
                                    //                           ),
                                    //                       errorWidget: (context,
                                    //                               url, error) =>
                                    //                           Icon(Icons.error)),
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       );
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                ),
                                // Column(
                                //   children: <Widget>[
                                //     Padding(
                                //       padding:
                                //           EdgeInsets.symmetric(horizontal: 20.0),
                                //       child: Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: <Widget>[],
                                //       ),
                                //     ),
                                //     Container(
                                //       height: 360.0,
                                //       child: ListView.builder(
                                //         scrollDirection: Axis.horizontal,
                                //         itemCount: _getFavourite.length,
                                //         itemBuilder:
                                //             (BuildContext context, int index) {
                                //           return Container(
                                //             margin: EdgeInsets.all(10.0),
                                //             width: 180.0,
                                //             child: Stack(
                                //               alignment: Alignment.topCenter,
                                //               children: <Widget>[
                                //                 Positioned(
                                //                   bottom: 15.0,
                                //                   child: Container(
                                //                     height: 120.0,
                                //                     width: 200.0,
                                //                     decoration: BoxDecoration(
                                //                       color: primaryColor,
                                //                       borderRadius:
                                //                           BorderRadius.circular(
                                //                               0.0),
                                //                     ),
                                //                     child: Padding(
                                //                       padding:
                                //                           EdgeInsets.all(10.0),
                                //                       child: Column(
                                //                         mainAxisAlignment:
                                //                             MainAxisAlignment.end,
                                //                         crossAxisAlignment:
                                //                             CrossAxisAlignment
                                //                                 .center,
                                //                         children: <Widget>[
                                //                           Text(
                                //                             _getFavourite[index][
                                //                                             'title']
                                //                                         .length <=
                                //                                     20
                                //                                 ? _getFavourite[
                                //                                             index]
                                //                                         ['title']
                                //                                     .toString()
                                //                                 : _getFavourite[
                                //                                             index]
                                //                                         ['title']
                                //                                     .toString()
                                //                                     .substring(
                                //                                         0, 20),
                                //                             style: TextStyle(
                                //                               color:
                                //                                   kPrimaryWhiteColor,
                                //                               fontSize: 16.0,
                                //                             ),
                                //                           ),
                                //                           SizedBox(height: 5.0),
                                //                           Padding(
                                //                             padding:
                                //                                 const EdgeInsets
                                //                                         .only(
                                //                                     top: 10.0,
                                //                                     left: 60),
                                //                             child: Row(
                                //                               children: [
                                //                                 Row(
                                //                                   children: [
                                //                                     Icon(
                                //                                       Icons.star,
                                //                                       size: 15.0,
                                //                                       color: Colors
                                //                                           .yellow,
                                //                                     ),
                                //                                     SizedBox(
                                //                                         width:
                                //                                             10),
                                //                                     Text(
                                //                                       _getFavourite[index]
                                //                                               [
                                //                                               'rating']
                                //                                           .toString(),
                                //                                       style:
                                //                                           TextStyle(
                                //                                         fontSize:
                                //                                             12,
                                //                                         color:
                                //                                             kPrimaryWhiteColor,
                                //                                       ),
                                //                                     ),
                                //                                   ],
                                //                                 ),
                                //                               ],
                                //                             ),
                                //                           ),
                                //                         ],
                                //                       ),
                                //                     ),
                                //                   ),
                                //                 ),
                                //                 Container(
                                //                   decoration: BoxDecoration(
                                //                     color: Colors.white,
                                //                     borderRadius:
                                //                         BorderRadius.circular(
                                //                             0.0),
                                //                     boxShadow: [
                                //                       BoxShadow(
                                //                         color: Colors.black26,
                                //                         blurRadius: 6.0,
                                //                       ),
                                //                     ],
                                //                   ),
                                //                   child: ClipRRect(
                                //                     borderRadius:
                                //                         BorderRadius.circular(
                                //                             00.0),
                                //                     child: InkWell(
                                //                       onTap: () {},
                                //                       borderRadius:
                                //                           BorderRadius.circular(
                                //                               00.0),
                                //                       child: CachedNetworkImage(
                                //                           height: 250,
                                //                           width: 180,
                                //                           imageUrl:
                                //                               _getFavourite[index]
                                //                                       ['image']
                                //                                   .toString(),
                                //                           imageBuilder: (context,
                                //                                   imageProvider) =>
                                //                               Container(
                                //                                 decoration:
                                //                                     BoxDecoration(
                                //                                   borderRadius:
                                //                                       BorderRadius
                                //                                           .circular(
                                //                                               5),
                                //                                   image: DecorationImage(
                                //                                       image:
                                //                                           imageProvider,
                                //                                       fit: BoxFit
                                //                                           .fill),
                                //                                 ),
                                //                               ),
                                //                           errorWidget: (context,
                                //                                   url, error) =>
                                //                               Icon(Icons.error)),
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //           );
                                //         },
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[],
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    _isLoading
                                        ? Center(
                                            child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 30.0),
                                            child: CupertinoActivityIndicator(
                                              radius: 15,
                                            ),
                                          ))
                                        : Expanded(
                                            child: ListView.builder(
                                              itemCount:
                                                  _getFavouriteFiltered.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                    color: Colors.black12,
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Center(
                                                        child: Container(
                                                          width: 130,
                                                          height: 150,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 15,
                                                                  top: 10),
                                                          child: InkWell(
                                                            onTap: () {
                                                              print("shar");
                                                              // _navigator(30
                                                              //     context,
                                                              //     Chapter([
                                                              //       SelectedManga[
                                                              //           0][index]
                                                              //     ]));
                                                            },
                                                            child:
                                                                CachedNetworkImage(
                                                                    imageUrl: _getFavouriteFiltered[index]
                                                                            [
                                                                            'image']
                                                                        .toString(),
                                                                    imageBuilder:
                                                                        (context,
                                                                                imageProvider) =>
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(5),
                                                                                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                                                                              ),
                                                                            ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(Icons
                                                                            .error)),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                              child: Text(
                                                                _getFavouriteFiltered[index]['title']
                                                                            .length <=
                                                                        20
                                                                    ? _getFavouriteFiltered[index]
                                                                            [
                                                                            'title']
                                                                        .toString()
                                                                    : _getFavouriteFiltered[index]
                                                                            [
                                                                            'title']
                                                                        .toString()
                                                                        .substring(
                                                                            0,
                                                                            20),
                                                                style: TextStyle(
                                                                    color:
                                                                        kPrimaryWhiteColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 6,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                // Text(
                                                                //   _getLibrary[index]
                                                                //           [
                                                                //           'rating']
                                                                //       .toString(),
                                                                //   style: TextStyle(
                                                                //       color:
                                                                //           kPrimaryWhiteColor,
                                                                //       fontWeight:
                                                                //           FontWeight
                                                                //               .bold,
                                                                //       fontSize:
                                                                //           12),
                                                                // ),
                                                                SizedBox(
                                                                  height: 6,
                                                                ),
                                                                Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .yellow,
                                                                      size: 12,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                        _getFavouriteFiltered[index]['rating']
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                kPrimaryGreyColor,
                                                                            fontSize:
                                                                                13,
                                                                            letterSpacing:
                                                                                .3)),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    // Text(
                                                                    //     ". Action",
                                                                    //     style: TextStyle(
                                                                    //         color:
                                                                    //             kPrimaryGreyColor,
                                                                    //         fontSize:
                                                                    //             13,
                                                                    //         letterSpacing:
                                                                    //             .3)),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    // Text(". ch",
                                                                    //     style: TextStyle(
                                                                    //         color:
                                                                    //             kPrimaryGreyColor,
                                                                    //         fontSize:
                                                                    //             13,
                                                                    //         letterSpacing:
                                                                    //             .3)),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                    // Container(
                                    //   height: 360.0,
                                    //   child: ListView.builder(
                                    //     scrollDirection: Axis.horizontal,
                                    //     itemCount: _getLibrary.length,
                                    //     itemBuilder:
                                    //         (BuildContext context, int index) {
                                    //       return Container(
                                    //         margin: EdgeInsets.all(10.0),
                                    //         width: 180.0,
                                    //         child: Stack(
                                    //           alignment: Alignment.topCenter,
                                    //           children: <Widget>[
                                    //             Positioned(
                                    //               bottom: 15.0,
                                    //               child: Container(
                                    //                 height: 120.0,
                                    //                 width: 200.0,
                                    //                 decoration: BoxDecoration(
                                    //                   color: primaryColor,
                                    //                   borderRadius:
                                    //                       BorderRadius.circular(
                                    //                           0.0),
                                    //                 ),
                                    //                 child: Padding(
                                    //                   padding:
                                    //                       EdgeInsets.all(10.0),
                                    //                   child: Column(
                                    //                     mainAxisAlignment:
                                    //                         MainAxisAlignment.end,
                                    //                     crossAxisAlignment:
                                    //                         CrossAxisAlignment
                                    //                             .start,
                                    //                     children: <Widget>[
                                    //                       Text(
                                    // _getLibrary[index][
                                    //                 'title']
                                    //             .length <=
                                    //         20
                                    //     ? _getLibrary[
                                    //                 index]
                                    //             ['title']
                                    //         .toString()
                                    //     : _getLibrary[
                                    //                 index]
                                    //             ['title']
                                    //         .toString()
                                    //         .substring(
                                    //             0, 20),
                                    //                         style: TextStyle(
                                    //                           color:
                                    //                               kPrimaryWhiteColor,
                                    //                           fontSize: 16.0,
                                    //                         ),
                                    //                       ),
                                    //                       SizedBox(height: 5.0),
                                    //                       Padding(
                                    //                         padding:
                                    //                             const EdgeInsets
                                    //                                     .only(
                                    //                                 top: 10.0,
                                    //                                 left: 60),
                                    //                         child: Row(
                                    //                           children: [
                                    //                             Row(
                                    //                               children: [
                                    //                                 Icon(
                                    //                                   Icons.star,
                                    //                                   size: 15.0,
                                    //                                   color: Colors
                                    //                                       .yellow,
                                    //                                 ),
                                    //                                 SizedBox(
                                    //                                     width:
                                    //                                         10),
                                    //                                 Text(
                                    //                                   _getLibrary[index]
                                    //                                           [
                                    //                                           'rating']
                                    //                                       .toString(),
                                    //                                   style:
                                    //                                       TextStyle(
                                    //                                     fontSize:
                                    //                                         12,
                                    //                                     color:
                                    //                                         kPrimaryWhiteColor,
                                    //                                   ),
                                    //                                 ),
                                    //                               ],
                                    //                             ),
                                    //                           ],
                                    //                         ),
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //             Container(
                                    //               decoration: BoxDecoration(
                                    //                 color: Colors.white,
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(
                                    //                         0.0),
                                    //                 boxShadow: [
                                    //                   BoxShadow(
                                    //                     color: Colors.black26,
                                    //                     blurRadius: 6.0,
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //               child: ClipRRect(
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(
                                    //                         00.0),
                                    //                 child: InkWell(
                                    //                   onTap: () {},
                                    //                   borderRadius:
                                    //                       BorderRadius.circular(
                                    //                           00.0),
                                    //                   child: CachedNetworkImage(
                                    //                       height: 250,
                                    //                       width: 180,
                                    //                       imageUrl:
                                    //                           _getLibrary[index]
                                    //                                   ['image']
                                    //                               .toString(),
                                    //                       imageBuilder: (context,
                                    //                               imageProvider) =>
                                    //                           Container(
                                    //                             decoration:
                                    //                                 BoxDecoration(
                                    //                               borderRadius:
                                    //                                   BorderRadius
                                    //                                       .circular(
                                    //                                           5),
                                    //                               image: DecorationImage(
                                    //                                   image:
                                    //                                       imageProvider,
                                    //                                   fit: BoxFit
                                    //                                       .fill),
                                    //                             ),
                                    //                           ),
                                    //                       errorWidget: (context,
                                    //                               url, error) =>
                                    //                           Icon(Icons.error)),
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       );
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
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

  //get UserLibrary details from api
  void getUserLibrary() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString("token")!;
    setState(() {
      _isLoading = true;
    });
    try {
      //library
      _getLibrary.clear();
      var bodyRoutes;
      var res = await CallApi().getUserLibrary('getUserLibrary');
      bodyRoutes = json.decode(res.body);

      _getLibrary = bodyRoutes;

      var seen = Set<String>();

      _getLibraryFiltered =
          _getLibrary.where((manga) => seen.add(manga["title"])).toList();

      // _getLibraryFiltered=_getLibrary.u

      print(_getLibrary.length);

      //output list: John Cena, Jack Sparrow, Harry Potter

      //_getLibraryFiltered = _getLibrary[0].toSet().toList();

      print("rfff" + _getLibraryFiltered.length.toString());
      print("length" + _getLibrary.length.toString());
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
      var seen = Set<String>();

      _getFavouriteFiltered =
          _getFavourite.where((manga) => seen.add(manga["title"])).toList();

      print(_getFavourite);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
