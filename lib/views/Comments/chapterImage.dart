import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart';
import 'package:mangakiku_app/Ads_Helpers/googleMobAds.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/views/Comments/comments.dart';
import 'package:mangakiku_app/views/Comments/comments_reply.dart';
import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:mangakiku_app/views/SignIn/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MangaComment2 extends StatefulWidget {
  final String hid;

  final String chapterid;
  final List chap;
  final int index;
  const MangaComment2({
    key,
    required this.hid,
    required this.chapterid,
    required this.chap,
    required this.index,
  }) : super(key: key);

  @override
  _MangaComment2State createState() => _MangaComment2State();
}

class _MangaComment2State extends State<MangaComment2> {
  late String hid;
  late String chapterid;
  TextEditingController _commentController = new TextEditingController();

  String? selectevalue;
  int chapterCount = 0;
  int? indexlast;
  String token = "";

  List User = [];
  int? index;

  String? __replyComment;
  int? _replyid;
  int? _replyReplyid;
  //listview index
  int? xyz;

  // List ReplyComments = [];

  List<TextEditingController> _controllers = <TextEditingController>[];

  //Success
  String? success;

  var read;
  var readReverse;

  @override
  void initState() {
    //initialize  id for chapterimage
    // AdHelper.myBanner.load();
    index = widget.index;
    hid = widget.hid;

    // print(hid);
    chapterid = widget.chapterid;
    // print(chapterid);
    _apiChapterImages();
    _getUserDetails();
    super.initState();
  }

  // final AdWidget adWidget = AdWidget(ad: AdHelper.myBanner);

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  //initialize list for add chapter image from API
  List _chapterImage = [];
  List _getComments = [];
  List _getReplyComments = [];

  // loader
  bool _isLoading = true;
  bool reply = true;

  bool imageclick = false;

  late int counter = 0;
  late int counterlast = 0;

  @override
  Widget build(BuildContext context) {
    var image = "https://meo2.comick.pictures/file/comick/";
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      body: _isLoading
          ? Center(
              child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: CupertinoActivityIndicator(
                radius: 15,
              ),
            ))
          : Stack(children: [
              SafeArea(
                child: ListView(children: [
                  Column(
                    children: [
                      Container(
                        height: screenHeight * (18 / 20),
                        child: ListView.builder(
                          scrollDirection: read,
                          physics: PageScrollPhysics(),
                          reverse: readReverse,
                          itemCount:
                              _chapterImage[0]['chapter']['md_images'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              // margin: EdgeInsets.only(
                              //   left: 10,
                              //   right: 10,
                              // ),
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
                                        onTap: () {
                                          setState(() {
                                            // print("fvfvfv");
                                            if (imageclick == false) {
                                              imageclick = true;
                                            } else if (imageclick == true) {
                                              imageclick = false;
                                            }
                                          });
                                        },
                                        borderRadius:
                                            BorderRadius.circular(00.0),
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
                                                        BorderRadius.circular(
                                                            5),
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
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
                ]),
              ),
              // SafeArea(
              //   child: Center(
              //     child: Container(
              //       width: screenWidth * 0.8,
              //       height: 50,
              //       color: Colors.green,
              //       child: adWidget,
              //     ),
              //   ),
              // ),
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
                            child: new Text("Chapter " + chapterid,
                                textAlign: TextAlign.center)),
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(Icons.keyboard_control_rounded),
                            //tooltip: 'Increase volume by 10',
                            onPressed: () {},
                          )
                        ],
                      ))),
            ]),
      bottomNavigationBar: imageclick == true
          ? SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_back_ios_new),
                    color: kPrimaryWhiteColor,
                    onPressed: () {
                      setState(() {
                        if (index != 0) {
                          _isLoading = true;
                          index = (index! - 1);
                          hid = widget.chap[index!]["hid"];
                          chapterid = widget.chap[index!]["chap"].toString();

                          _apiChapterImages();
                        }

                        //widget.chapterid =
                      });
                      // if (counter <
                      //     _chapterImage[0]['chapter']['md_images'].length - 1) {
                      //   setState(() {
                      //     counter = counter + 1;
                      //   });
                      // }
                    }),
                IconButton(
                    icon: Icon(Icons.book_online),
                    color: kPrimaryWhiteColor,
                    onPressed: () {
                      _showReadcontent();
                    }),
                IconButton(
                    icon: Icon(Icons.comment_outlined),
                    color: kPrimaryWhiteColor,
                    onPressed: () {
                      if (token != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReplyComments(
                                image: _chapterImage[0]['chapter']['md_images']
                                        [0]['b2key']
                                    .toString(),
                                chapterid: widget.chapterid.toString(),
                                hid: widget.hid.toString()),
                          ),
                        );
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Signin(),
                            ));
                      }

                      //  _displayDialog(context);
                    }),
                // IconButton(
                //     icon: Icon(Icons.favorite),
                //     color: kPrimaryWhiteColor,
                //     onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    color: kPrimaryWhiteColor,
                    onPressed: () {
                      setState(() {
                        // if (index! < indexlast!) {
                        _isLoading = true;

                        index = (index! + 1);
                        hid = widget.chap[index!]["hid"];
                        chapterid = widget.chap[index!]["chap"].toString();
                        //print(widget.chap[index!]);
                        _apiChapterImages();
                        //  }

                        //widget.chapterid =
                      });
                    }),
              ],
            ),
    );
  }

//store the userImage in local
  void _getUserDetails() async {
    read = Axis.horizontal;
    readReverse = true;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    selectevalue = localStorage.getString("selectevalue")!;
    print("homepagetoken" + selectevalue!);
    print("homepagetoken" + selectevalue!);
    print("homepagetoken" + selectevalue!);
    print("homepagetoken" + selectevalue!);
    // var data = {"pic": selectevalue};
    if (selectevalue == 'Left to Right') {
      read = Axis.horizontal;
      readReverse = false;
    } else if (selectevalue == 'Right to Left') {
      read = Axis.horizontal;
      readReverse = true;
    } else if (selectevalue == 'Vertical') {
      read = Axis.vertical;
      readReverse = false;
    } else if (selectevalue == 'Vertical Reverse') {
      read = Axis.vertical;
      readReverse = true;
    } else {
      read = Axis.horizontal;
      readReverse = true;
    }
  }

//get chappterImages details from api
  void _apiChapterImages() async {
    try {
      print("dddddddddd" + widget.chap.toString());
      print(chapterid);
      _chapterImage.clear();
      var bodyRoutes;
      var res = await CallApi().getChapterImages(hid);
      bodyRoutes = json.decode(res.body);

      // Add chapterimages to  List

      _chapterImage.add(bodyRoutes);
      //  print(_chapterImage[0]['chapter']['md_images'][0]['b2key'].length);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });

    // //store the userImage in local
    void _getUserDetails() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      token = localStorage.getString("token")!;
      print("homepagetoken" + token);
      var data = {"pic": token};
    }
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
                      // print(_selectedRead);
                      SharedPreferences localStorage =
                          await SharedPreferences.getInstance();

                      var selectevalue = _selectedRead;
                      // print(selectevalue);

                      localStorage.setString('selectevalue', selectevalue);
                      print(selectevalue);

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
}
