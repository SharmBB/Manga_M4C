import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/views/Comments/comments.dart';
import 'package:mangakiku_app/views/Home/homePage.dart';

class MangaComment2 extends StatefulWidget {
  final String hid;
  const MangaComment2({
    key,
    required this.hid,
  }) : super(key: key);

  @override
  _MangaComment2State createState() => _MangaComment2State();
}

class _MangaComment2State extends State<MangaComment2> {
  late String hid;

  @override
  void initState() {
    //initialize  id for chapterimage
    hid = widget.hid;
    print(hid);
    _apiChapterImages();

    super.initState();
  }

  //initialize list for add chapter image from API
  List _chapterImage = [];

  // loader
  bool _isLoading = true;

  late int counter = 0;
  late int counterlast = 0;

  @override
  Widget build(BuildContext context) {
    var image = "https://meo2.comick.pictures/file/comick/";
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(children: [
        SafeArea(
            child: ListView(children: [
          _isLoading
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: CupertinoActivityIndicator(
                    radius: 15,
                  ),
                ))
              : Column(
                  children: [
                    Container(
                      height: screenHeight * (18 / 20),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            _chapterImage[0]['chapter']['md_images'].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            width: screenWidth,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: kPrimaryWhiteColor,
                                    borderRadius: BorderRadius.circular(0.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor,
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(00.0),
                                    child: InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(00.0),
                                      child: CachedNetworkImage(
                                          height: screenHeight * (18 / 20),
                                          width: screenWidth,
                                          imageUrl: image +
                                              _chapterImage[0]['chapter']
                                                      ['md_images']
                                                  [index + counter]['b2key'],
                                          imageBuilder: (context,
                                                  imageProvider) =>
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ])),
        SafeArea(
            child: Container(
                height: 50,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                  ),
                  title: new Center(
                      child:
                          new Text("Chapter 2", textAlign: TextAlign.center)),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.keyboard_control_rounded),
                      //tooltip: 'Increase volume by 10',
                      onPressed: () {},
                    )
                  ],
                ))),
      ]),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              color: kPrimaryWhiteColor,
              onPressed: () {
                if (counter != 0) {
                  setState(() {
                    counter = counter - 1;
                  });
                }
              }),
          IconButton(
              icon: Icon(Icons.thumb_up_off_alt),
              color: kPrimaryWhiteColor,
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.comment_outlined),
              color: kPrimaryWhiteColor,
              onPressed: () {
                _displayDialog(context);
              }),
          IconButton(
              icon: Icon(Icons.favorite),
              color: kPrimaryWhiteColor,
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              color: kPrimaryWhiteColor,
              onPressed: () {
                if (counter <
                    _chapterImage[0]['chapter']['md_images'].length - 1) {
                  setState(() {
                    counter = counter + 1;
                  });
                }
              }),
        ],
      ),
    );
  }

//get chappterImages details from api
  void _apiChapterImages() async {
    try {
      _chapterImage.clear();
      var bodyRoutes;
      var res = await CallApi().getChapterImages(widget.hid);
      bodyRoutes = json.decode(res.body);

      // Add chapterimages to  List

      _chapterImage.add(bodyRoutes);
      print(_chapterImage[0]['chapter']['md_images'][0]['b2key'].length);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  //popUP
  _displayDialog(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 100),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.transparent,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 140, 0, 0),
                        child: Container(
                          width: screenWidth,
                          height: screenHeight,
                          color: Colors.grey.shade900,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            width: 300,
                                            child: Center(
                                                child: Text(
                                              'Chapter 2',
                                              style: TextStyle(
                                                color: kPrimaryWhiteColor,
                                                fontSize: 20,
                                              ),
                                            ))),
                                        GestureDetector(
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            }),
                                      ]),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "122 Comments",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            width: 100,
                                            height: 20,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Top",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey),
                                                ),
                                                VerticalDivider(
                                                  thickness: 1,
                                                  color: Colors.grey,
                                                ),
                                                Text(
                                                  "New",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          Colors.purple[900]),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      child: NotificationListener<
                                              OverscrollIndicatorNotification>(
                                          onNotification:
                                              (OverscrollIndicatorNotification
                                                  overscroll) {
                                            // ignore: deprecated_member_use
                                            overscroll.disallowGlow();
                                            return false;
                                          },
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20),
                                                        child: CircleAvatar(
                                                          radius: 20,
                                                          backgroundImage:
                                                              AssetImage(
                                                            "assets/profile-img.png",
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 20.0,
                                                                top: 40),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              const Text(
                                                                "Jake",
                                                                style: TextStyle(
                                                                    color:
                                                                        kPrimaryWhiteColor,
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 5),
                                                                child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        width:
                                                                            150,
                                                                        height:
                                                                            30,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                kPrimaryWhiteColor,
                                                                            borderRadius:
                                                                                BorderRadius.circular(15)),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.batch_prediction,
                                                                              color: Colors.purple,
                                                                            ),
                                                                            Text(
                                                                              "Top 100 Readers",
                                                                              style: TextStyle(fontSize: 13, color: kPrimaryPurpleColor),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ]),
                                                              ),
                                                            ]),
                                                      )
                                                    ]),
                                                SizedBox(height: 10),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0,
                                                          left: 60,
                                                          right: 5),
                                                  child: Text(
                                                    "The definition of a character is a unique symbol, letter or mark used in writing. Character is defined as a trait, quality or high moral code. An example of character is someone who is known for being funny. An example of character is a person who is trustworthy.One way to classify characters is by examining how they change (or don't change) over the course of a story. Grouped in this way by character development, character types include the dynamic character, the round character, the static character, the stock character, and the symbolic character.",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                SizedBox(width: 10),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 8.0,
                                                    left: 60,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text("21.12.2021",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          )),

                                                      //  SizedBox(width: 10.0),
                                                      Text("09.23 am",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          )),
                                                      //  SizedBox(width: 10.0),
                                                      Icon(
                                                        Icons.arrow_upward,
                                                        size: 25.0,
                                                        color:
                                                            Colors.purple[900],
                                                      ),
//SizedBox(width: 5.0),
                                                      Text("233",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          )),
                                                      //     SizedBox(width: 10.0),
                                                      Icon(
                                                        Icons.arrow_downward,
                                                        size: 25.0,
                                                        color: Colors.grey,
                                                      ),
                                                      //     SizedBox(width: 5.0),
                                                      Text("43",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          )),
                                                      //  SizedBox(width: 10.0),
                                                      Icon(
                                                        Icons.comment,
                                                        size: 25.0,
                                                        color: Colors.grey,
                                                      ),
                                                      // SizedBox(width: 5.0),
                                                      Text("22",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          )),
                                                      IconButton(
                                                          icon: Icon(
                                                              Icons.report),
                                                          color:
                                                              kPrimaryPurpleColor,
                                                          onPressed: () {
                                                            showAlert(context);
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 8.0,
                                                    left: 60,
                                                  ),
                                                  child: Container(
                                                    height: 150,
                                                    child: IntrinsicHeight(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          VerticalDivider(
                                                            color: Colors.grey,
                                                            thickness: 2,
                                                          ),
                                                          Container(
                                                            //  width: screenWidth*3/4,
                                                            alignment: Alignment
                                                                .topLeft,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.grey,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 4.0),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8.0))),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text("Peter:",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                    )),

                                                                // Text(
                                                                //     'The definition of a character is a unique symbol, letter or mark used in writing. Character is defined as a trait, quality or high moral code.',
                                                                //     style: TextStyle(
                                                                //       color: Colors.white,
                                                                //       fontSize: 12,
                                                                //     )),
                                                                SizedBox(
                                                                    height: 15),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                        "21.12.2021",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              12,
                                                                        )),
                                                                    Text(
                                                                        "09.23 am",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              12,
                                                                        )),
                                                                    Icon(
                                                                      Icons
                                                                          .arrow_upward,
                                                                      size:
                                                                          25.0,
                                                                      color: Colors
                                                                              .purple[
                                                                          900],
                                                                    ),
                                                                    Text("233",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              12,
                                                                        )),
                                                                    SizedBox(
                                                                        width:
                                                                            5.0),
                                                                    Icon(
                                                                      Icons
                                                                          .arrow_downward,
                                                                      size:
                                                                          25.0,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    Text("43",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              12,
                                                                        )),
                                                                    Icon(
                                                                      Icons
                                                                          .comment,
                                                                      size:
                                                                          25.0,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    Text("22",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              12,
                                                                        )),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height: 15),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        "Total 23 Replies",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              12,
                                                                        )),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 30,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: screenWidth *
                                                              (3.8 / 5),
                                                          child: TextFormField(
                                                            textAlign:
                                                                TextAlign.left,
                                                            decoration:
                                                                InputDecoration(
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.grey,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                        width:
                                                                            3,
                                                                        color: Colors
                                                                            .grey),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                            icon: Icon(
                                                                Icons.send),
                                                            color: Colors.white,
                                                            onPressed: () {}),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ))),
                                ]),
                          ),
                        ),
                      ))));
            },
          );
        });
  }
}
