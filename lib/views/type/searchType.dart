import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';

import 'package:mangakiku_app/views/Comments/chapterImage.dart';
import 'package:mangakiku_app/views/Comments/comments.dart';
import 'package:mangakiku_app/views/Comments/searchChapterImage.dart';
import 'package:mangakiku_app/views/Comments/sliderChapterImage.dart';

import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:mangakiku_app/views/Signup/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchDetailsScreen extends StatefulWidget {
  late final List _manga;

  SearchDetailsScreen(this._manga);

  @override
  _CartState createState() => _CartState(this._manga);
}

class _CartState extends State<SearchDetailsScreen> {
  _CartState(this._manga);

  List _manga;
  String? bodyError;
  String? bodyErrorFav;

  String dropdownValue = 'Descending';
  bool reverseArray = true;

  //list for api
  List chapterUsingName = [];
  List chapterUsingID = [];
  List chaptersFromDB = [];
  List chaptersFromDBFr = [];
  List enChapter = [];
  List frChapter = [];
  List chapterLanguage = [];
  List chapterLanguagefr = [];
  List chapterLanguageEn = [];
  List chapterLanguagefrList = [];
  String? selectelanguage = "";
  List ReverseEn = [];
  List Reversefr = [];

   String token = "";

  @override
  void initState() {
    _ChapterDetailsUsingName();
    _getLocalLanguage();
    _getUserDetails();
    // addLibrary();
    // addFavourite();
    super.initState();
  }

// loader
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              // ignore: deprecated_member_use
              overscroll.disallowGlow();
              return false;
            },
            child: _isLoading
                ? Center(
                    child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: CupertinoActivityIndicator(
                      radius: 15,
                    ),
                  ))
                : SingleChildScrollView(
                    child: Column(children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width,
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
                          child: CachedNetworkImage(
                            imageUrl: (_manga[0]['md_covers'][0]['gpurl']),
                            width: 800,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  iconSize: 30.0,
                                  color: Colors.white,
                                  onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                      )),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 20.0,
                          top: 150.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _manga[0]['title'].length <= 40
                                    ? _manga[0]['title'].toString()
                                    : _manga[0]['title']
                                        .toString()
                                        .substring(0, 40),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      size: 15.0,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(width: 5.0),
                                    Text("9/10",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                    SizedBox(width: 5.0),
                                    Text(".",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                    SizedBox(width: 5.0),
                                    Text("Action",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                    SizedBox(width: 5.0),
                                    Text(".",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                    SizedBox(width: 5.0),
                                    Text("30 min",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                    SizedBox(width: 5.0),
                                    Text(".",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                    SizedBox(width: 5.0),
                                    Text("ch 10/12",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 5.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    FlatButton(
                                      height: 28,
                                      child: Text(
                                        'Read Now',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                      color: kPrimaryPurpleColor,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        if (selectelanguage == "Francasis") {
                                          if (enChapter[0] != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MangaComment2(
                                                  chapterid: frChapter[0]
                                                          ["chap"]
                                                      .toString(),
                                                  hid: frChapter[0]['hid']
                                                      .toString(),
                                                  chap: frChapter,
                                                  index: 0,
                                                ),
                                              ),
                                            );
                                          }
                                        } else {
                                          if (enChapter[0] != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MangaComment2(
                                                  chapterid: enChapter[0]
                                                          ["chap"]
                                                      .toString(),
                                                  hid: enChapter[0]['hid']
                                                      .toString(),
                                                  chap: enChapter,
                                                  index: 0,
                                                ),
                                              ),
                                            );
                                          }
                                        }

                                        print("dsvdsv");
                                      },
                                    ),
                                    SizedBox(width: 10.0),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      child: FloatingActionButton.small(
                                        backgroundColor: Colors.grey[300],
                                        onPressed: () async {
                                          if (token == "") {
                                            print("ddsv");

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Signup(),
                                                ));
                                          } else {
                                            print("ddsvvdsvdfv");
                                            addLibrary();
                                          }
                                        },
                                        child: Icon(
                                          Icons.add,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0))),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      child: FloatingActionButton.small(
                                        backgroundColor: Colors.grey[300],
                                        onPressed: () async {
                                          if (token == "") {
                                            print("ddsv");

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Signup(),
                                                ));
                                          } else {
                                            print("ddsvvdsvdfv");
                                            addFavourite();
                                          }
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ],
                    ),
                    DefaultTabController(
                        length: 2, // length of tabs
                        initialIndex: 0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                child: TabBar(
                                  labelColor: Colors.purple[900],
                                  unselectedLabelColor: Colors.white,
                                  tabs: [
                                    Tab(
                                      text: 'Description',
                                    ),
                                    Tab(text: 'Chapter'),
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
                                  _isLoading
                                      ? Center(
                                          child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 30.0),
                                          child: CupertinoActivityIndicator(
                                            radius: 15,
                                          ),
                                        ))
                                      : SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    chapterUsingName[0]['comic']
                                                        ['desc'],
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Organization :",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(width: 3.0),
                                                    Text(
                                                      "Manhwa",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.0),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Published :",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(width: 3.0),
                                                    Text(
                                                      "2018",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.0),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Demographic :",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(width: 3.0),
                                                    Text(
                                                      "Shounen",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.0),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Status :",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(width: 3.0),
                                                    Text(
                                                      "Ongoing",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 15.0),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "More Info ",
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10.0),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Artists :",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(width: 3.0),
                                                    Text(
                                                      "Akira Toriyama(Redic Studio)",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: kPrimaryPurpleColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.0),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Authors :",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(width: 3.0),
                                                    Text(
                                                      " Bird Studio/Shueisha",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: kPrimaryPurpleColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.0),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Geners :",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(width: 3.0),
                                                    Text(
                                                      " television series, Adventure , Fantasy",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: kPrimaryPurpleColor),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                // Container(
                                                //   height: 80,

                                                //   decoration: BoxDecoration(
                                                //       color: Colors.grey,
                                                //       borderRadius:
                                                //           BorderRadius.circular(1)),

                                                //   // ),
                                                // )
                                              ],
                                            ),
                                          ),
                                        ),
                                  _isLoading
                                      ? Center(
                                          child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 30.0),
                                          child: CupertinoActivityIndicator(
                                            radius: 15,
                                          ),
                                        ))
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0, left: 10),
                                                  child: Container(
                                                      width: 120,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[900],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(1)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 0, 0, 0),
                                                        child: DropdownButton<
                                                            String>(
                                                          underline:
                                                              DropdownButtonHideUnderline(
                                                                  child:
                                                                      Container()),
                                                          value: dropdownValue,
                                                          dropdownColor:
                                                              kPrimaryPurpleColor,
                                                          icon: Icon(Icons
                                                              .keyboard_arrow_down),
                                                          elevation: 16,
                                                          style: TextStyle(
                                                              color:
                                                                  kPrimaryWhiteColor),
                                                          onChanged: (String?
                                                              newValue) {
                                                            setState(() {
                                                              dropdownValue =
                                                                  newValue!;

                                                              _arrayReverced();
                                                            });
                                                          },
                                                          items: <String>[
                                                            'Descending',
                                                            'Ascending',
                                                          ].map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(value,
                                                                  style: TextStyle(
                                                                      color:
                                                                          kPrimaryGreyColor)),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ))),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10,
                                                    left: 60,
                                                    right: 80),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      // Container(
                                                      //   width: 100,
                                                      //   height: 22,
                                                      //   decoration: BoxDecoration(
                                                      //       color: Colors.grey,
                                                      //       // gradient: LinearGradient(colors: [secondary, primary]),
                                                      //       borderRadius:
                                                      //           BorderRadius.circular(1)),
                                                      //   child: Padding(
                                                      //       padding:
                                                      //           const EdgeInsets.only(
                                                      //               top: 10.0, left: 5),
                                                      //       child: TextField(
                                                      //         decoration: InputDecoration(
                                                      //           hintText:
                                                      //               "Select Chapter",
                                                      //           hintStyle: TextStyle(
                                                      //               fontSize: 12.0,
                                                      //               color: Colors.white),
                                                      //           border: InputBorder.none,
                                                      //           fillColor:
                                                      //               Colors.grey[900],
                                                      //         ),
                                                      //       )),
                                                      // ),
                                                      Text('Chapters',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      // Text('Date',
                                                      //     style: TextStyle(
                                                      //         fontSize: 18,
                                                      //         color: Colors.white,
                                                      //         fontWeight:
                                                      //             FontWeight.bold)),
                                                      // Text(
                                                      //   'Date',
                                                      //   style: TextStyle(
                                                      //       fontSize: 18,
                                                      //       color: Colors.white,
                                                      //       fontWeight: FontWeight.bold),
                                                      // )
                                                    ]),
                                              ),
                                              selectelanguage == "Francasis"
                                                  ? Expanded(
                                                      child: Container(
                                                        child: ListView.builder(
                                                          itemCount:
                                                              Reversefr.length,

                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return InkWell(
                                                              child: ListTile(
                                                                  //return new ListTile(
                                                                  onTap: null,
                                                                  subtitle:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            60.0,
                                                                        left:
                                                                            60),
                                                                    child:InkWell(
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () {
                                                                              print("jhuvuyvuy" + chaptersFromDB[index]["chap"]);
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => SearchMangaComment2(
                                                                                    chapterid: frChapter[index]["chap"].toString(),
                                                                                    hid: frChapter[index]['hid'].toString(),
                                                                                    chap: frChapter,
                                                                                    index: index,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                            child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                        children: <
                                                                            Widget>[
                                                                          
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 8),
                                                                              child: Text(
                                                                                Reversefr[index].toString(),
                                                                                style: TextStyle(fontSize: 13, color: Colors.white),
                                                                              ),
                                                                            ),
                                                                          
                                                                          // InkWell(
                                                                          //   onTap: () {
                                                                          //     print("jhuvuyvuy" +
                                                                          //         chaptersFromDB[index]
                                                                          //             [
                                                                          //             "chap"]);
                                                                          //     Navigator
                                                                          //         .push(
                                                                          //       context,
                                                                          //       MaterialPageRoute(
                                                                          //         builder: (context) => MangaComment2(
                                                                          //             chapterid:
                                                                          //                 chaptersFromDB[index]["chap"].toString(),
                                                                          //             hid: chaptersFromDB[index]['hid'].toString()),
                                                                          //       ),
                                                                          //     );
                                                                          //   },
                                                                          //   child: Text(
                                                                          //     chaptersFromDB[index]["up_count"]
                                                                          //             .toString() +
                                                                          //         "days",
                                                                          //     style: TextStyle(
                                                                          //         fontSize:
                                                                          //             13,
                                                                          //         color: Colors
                                                                          //             .white),
                                                                          //   ),
                                                                          //   // Text(
                                                                          //   //   chaptersFromDB[
                                                                          //   //               index]
                                                                          //   //           [
                                                                          //   //           "lang"]
                                                                          //   //       .toString(),
                                                                          //   //   style: TextStyle(
                                                                          //   //       fontSize:
                                                                          //   //           13,
                                                                          //   //       color: Colors
                                                                          //   //           .white),
                                                                          //   // ),
                                                                          // )
                                                                        ])),
                                                                  )),
                                                            );
                                                          }, //itemBuilder
                                                        ),
                                                      ),
                                                    )
                                                  : Expanded(
                                                      child: Container(
                                                        child: ListView.builder(
                                                          itemCount:
                                                              ReverseEn.length,

                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return InkWell(
                                                              child: ListTile(
                                                                  //return new ListTile(
                                                                  onTap: null,
                                                                  subtitle:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            60.0,
                                                                        left:
                                                                            60),
                                                                    child: InkWell(
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () {
                                                                              print("jhuvuyvuy" + chapterLanguage[index]["chap"]);
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => SearchMangaComment2(
                                                                                    chapterid: enChapter[index]["chap"].toString(),
                                                                                    hid: enChapter[index]['hid'].toString(),
                                                                                    chap: enChapter,
                                                                                    index: index,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                        children: <
                                                                            Widget>[
                                                                          
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 8),
                                                                              child: Text(
                                                                                ReverseEn[index].toString(),
                                                                                style: TextStyle(fontSize: 13, color: Colors.white),
                                                                              ),
                                                                            ),
                                                                          
                                                                          // InkWell(
                                                                          //   onTap: () {
                                                                          //     print("jhuvuyvuy" +
                                                                          //         chaptersFromDB[index]
                                                                          //             [
                                                                          //             "chap"]);
                                                                          //     Navigator
                                                                          //         .push(
                                                                          //       context,
                                                                          //       MaterialPageRoute(
                                                                          //         builder: (context) => MangaComment2(
                                                                          //             chapterid:
                                                                          //                 chaptersFromDB[index]["chap"].toString(),
                                                                          //             hid: chaptersFromDB[index]['hid'].toString()),
                                                                          //       ),
                                                                          //     );
                                                                          //   },
                                                                          //   child: Text(
                                                                          //     chaptersFromDB[index]["up_count"]
                                                                          //             .toString() +
                                                                          //         "days",
                                                                          //     style: TextStyle(
                                                                          //         fontSize:
                                                                          //             13,
                                                                          //         color: Colors
                                                                          //             .white),
                                                                          //   ),
                                                                          //   // Text(
                                                                          //   //   chaptersFromDB[
                                                                          //   //               index]
                                                                          //   //           [
                                                                          //   //           "lang"]
                                                                          //   //       .toString(),
                                                                          //   //   style: TextStyle(
                                                                          //   //       fontSize:
                                                                          //   //           13,
                                                                          //   //       color: Colors
                                                                          //   //           .white),
                                                                          //   // ),
                                                                          // )
                                                                        ])),
                                                                  )),
                                                            );
                                                          }, //itemBuilder
                                                        ),
                                                      ),
                                                    ),
                                            ])
                                ]),
                              )
                            ]))
                  ]))));
  }

  //store the userImage in local
  void _getUserDetails() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString("token")!;
    print("homepagetoken" + token);
    var data = {"pic": token};
  }

  void _arrayReverced() async {
    if (dropdownValue == 'Ascending') {
      ReverseEn = chapterLanguageEn.reversed.toList();
      Reversefr = chapterLanguagefrList.reversed.toList();
      frChapter = frChapter.reversed.toList();
      enChapter = enChapter.reversed.toList();
      print('enASC---' + ReverseEn.toString());
      print('frASC---' + Reversefr.toString());
    } else {
      ReverseEn = chapterLanguageEn.toList();
      Reversefr = chapterLanguagefrList.toList();
      frChapter = frChapter.reversed.toList();
      enChapter = enChapter.reversed.toList();
      print('en---' + ReverseEn.toString());
      print('fr---' + Reversefr.toString());
    }
  }

  //get language details from  local storage
  void _getLocalLanguage() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    selectelanguage = localStorage.getString("selectelanguage")!;
    print("Language: " + selectelanguage!);
  }

  //get chapter details using name from api
  // ignore: non_constant_identifier_names
  void _ChapterDetailsUsingName() async {
    try {
      chapterUsingName.clear();
      var bodyRoutes;
      var res = await CallApi().getChapterUsingName(_manga[0]['slug']);
      bodyRoutes = json.decode(res.body);
      chapterUsingName.add(bodyRoutes);
      print(chapterUsingName[0]['comic']);
      int id = chapterUsingName[0]['comic']['id'];
      print(id);
      print(chapterUsingName);

      chapterUsingID.clear();

      //1 st list for api
      var bodyRoutesChap;
      var bodyRoutesFr;
      var resCHap =
          await CallApi().getChapterUsingID('$id/chapter?&limit=10000&lang=en');
      var resCHapFr =
          await CallApi().getChapterUsingID('$id/chapter?&limit=10000&lang=fr');
      bodyRoutesFr = json.decode(resCHapFr.body);
      bodyRoutesChap = json.decode(resCHap.body);

      // //2 nd list for api
      // var bodyRoutesChap1;
      // var resCHap1 = await CallApi().getChapterUsingID('$id/chapter?&limit=1500');
      // bodyRoutesChap1 = json.decode(resCHap1.body);

      // //3 st list for api
      // var bodyRoutesChap2;
      // var resCHap2 = await CallApi().getChapterUsingID('$id/chapter?&limit=1500');
      // bodyRoutesChap2 = json.decode(resCHap2.body);

      // Combining lists
      chaptersFromDB = bodyRoutesChap['chapters'];
      chaptersFromDBFr = bodyRoutesFr['chapters'];
      var seen = Set<String>();
      enChapter =
          chaptersFromDB.where((manga) => seen.add(manga["chap"])).toList();
      frChapter =
          chaptersFromDBFr.where((manga) => seen.add(manga["chap"])).toList();
      // ..addAll(bodyRoutesChap1['chapters'])
      // ..addAll(bodyRoutesChap2['chapters']);

      print(
          "---------chapters-------------" + chaptersFromDB.length.toString());
      print("---------chapters-------------" + chaptersFromDB.toString());

      chapterLanguage = enChapter;
      chapterLanguageEn =
          chapterLanguage.map((o) => o["chap"]).toSet().toList();
      chapterLanguagefr = frChapter;
      chapterLanguagefrList =
          chapterLanguagefr.map((o) => o["chap"]).toSet().toList();

      // for (var i = 0; i < chaptersFromDB.length; i++) {
      //   if (chaptersFromDB[i]["lang"] == 'en') {
      //     // chapterLanguage = chaptersFromDB;
      //     chapterLanguage =
      //         chaptersFromDB.where((o) => o['lang'] == 'en').toList();
      //     chapterLanguageEn =
      //         chapterLanguage.map((o) => o["chap"]).toSet().toList();
      //     // chapterLanguageEn.add(chapterLanguage.map((o) => o["chap"]).toSet());
      //     print(chapterLanguageEn[1]);
      //   } else if (chaptersFromDB[i]["lang"] == "fr") {
      //     chapterLanguagefr =
      //         chaptersFromDB.where((o) => o['lang'] == 'fr').toList();
      //     chapterLanguagefrList =
      //         chapterLanguagefr.map((o) => o["chap"]).toSet().toList();
      //     print(chapterLanguagefrList);
      //   }
      // }
      //   chapterLanguage = Set.of(chapterLanguage).toList();
      print("------------++++----------");
      print("EN" + chapterLanguage.toString());
      print("FR" + chapterLanguagefr.toString());
      print("----------------------------------------------------");
      print(chapterLanguage[0]['id']);

      ReverseEn = chapterLanguageEn;
      Reversefr = chapterLanguagefrList;

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void addLibrary() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var data = {
        "bookId": chapterUsingName[0]['comic']['id'],
        "title": _manga[0]['title'].toString(),
        "image": _manga[0]['md_covers'][0]['gpurl'].toString(),
        "rating": "9.45",
      };
      var res = await CallApi().postData(data, 'addLibrary');
      var body = json.decode(res.body);
      print(body);
      bodyError = body['message'];

      if (body['errorMessage'] == false) {
        replyshowAlert(context);

        if (body['token'] != null) {
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          var token = body['token'];
          localStorage.setString('token', token);

          print(body);
        }
      } else {}
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void addFavourite() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var data = {
        "bookId": chapterUsingName[0]['comic']['id'],
        "title": _manga[0]['title'].toString(),
        "image": _manga[0]['md_covers'][0]['gpurl'].toString(),
        "rating": "9.45",
      };
      var res = await CallApi().postData(data, 'addFavourite');
      var body = json.decode(res.body);
      print(body);

      bodyErrorFav = body['message'];
      if (body['errorMessage'] == false) {
        replyshowAlertFavourite(context);

        if (body['token'] != null) {
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          var token = body['token'];
          localStorage.setString('token', token);

          print(body);
        }
      } else {}
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

//dailog box
  replyshowAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.black,
            title: Center(
              child: Text(bodyError.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK",
                    style: TextStyle(color: Colors.purple[900], fontSize: 16)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }

  //dailog box
  replyshowAlertFavourite(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.black,
            title: Center(
              child: Text(bodyErrorFav.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK",
                    style: TextStyle(color: Colors.purple[900], fontSize: 16)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }
}
