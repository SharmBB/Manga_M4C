import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/views/Comments/comments.dart';
import 'package:mangakiku_app/views/Comments/comments_reply.dart';
import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlideMangaComment2 extends StatefulWidget {
  final String hid;
  final String chapterid;
  final List chap;
  final int index;
  const SlideMangaComment2({
    key,
    required this.hid,
    required this.chapterid,
    required this.chap,
    required this.index,
  }) : super(key: key);

  @override
  _MangaComment2State createState() => _MangaComment2State();
}

class _MangaComment2State extends State<SlideMangaComment2> {
  late String hid;
  late String chapterid;
  TextEditingController _commentController = new TextEditingController();

  String? token;
  String? selectevalue;
  int chapterCount = 0;

  List User = [];

  String? __replyComment;
  int? _replyid;
  int? _replyReplyid;
  //listview index
  int? xyz;
  int? index;

  // List ReplyComments = [];

  List<TextEditingController> _controllers = <TextEditingController>[];

  //Success
  String? success;

  var read;
  var readReverse;

   double _scale = 0.5;
  double _previousScale = 1.0;

  final transController = TransformationController();

  @override
  void initState() {
    //initialize  id for chapterimage
    index = widget.index;
    hid = widget.hid;
    print(hid);
    chapterid = widget.chapterid;
    print(chapterid);
    _apiChapterImages();
    _getUserDetails();
    super.initState();
  }

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
    var image =
        "https://uploads.mangadex.org/data/d68557010488f20728b2be1ccfc209d7/";
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
                          scrollDirection: Axis.horizontal,
                          physics: PageScrollPhysics(),
                          reverse: true,
                          itemCount:
                              _chapterImage[0]['chapter']['md_images'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              // margin: EdgeInsets.only(
                              //   left: 10,
                              //   right: 10,
                              // ),
                              height: screenHeight * (18 / 20),
                              width: screenWidth,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                     color: primaryColor,
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
                                            print("fvfvfv");
                                            if (imageclick == false) {
                                              imageclick = true;
                                            } else if (imageclick == true) {
                                              imageclick = false;
                                            }
                                          });
                                        },
                                        borderRadius:
                                            BorderRadius.circular(00.0),
                                      child: InteractiveViewer(
                                             transformationController:
                                                transController,

                                            // On: (ScaleStartDetails details) {
                                            //   print(details);
                                            //   _previousScale = 1.0;
                                            //   setState(() {});
                                            // },
                                            // onScaleUpdate:
                                            //     (ScaleUpdateDetails details) {
                                            //   print(details);
                                            //   _scale = _previousScale *
                                            //       details.scale;
                                            //   setState(() {});
                                            // },
                                            onInteractionUpdate:
                                                (ScaleUpdateDetails details) {
                                              // get the scale from the ScaleUpdateDetails callback
                                              print(details);
                                              _scale = _previousScale *
                                                  details.scale;
                                              setState(
                                                  () {}); // print the scale here
                                            },
                                            panEnabled:
                                                false, // Set it to false
                                            boundaryMargin: EdgeInsets.all(100),
                                            minScale: 0.5,

                                            maxScale: 2,
                                            scaleEnabled: true,
                                            // hideStatusBarWhileZooming: true,
                                            // constrained: false,

                                            onInteractionStart: (details) {
                                              print(details);
                                              _previousScale = 1.0;
                                              setState(() {});
                                            },


                                            child: CachedNetworkImage(
                                            height: screenHeight * (18 / 20),
                                            width: screenWidth,
                                            imageUrl: image +
                                                _chapterImage[0]['chapter']
                                                        ['md_images']
                                                    [index + counter]['name'],
                                            imageBuilder: (context,
                                                    imageProvider) =>
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.contain),
                                                  ),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error)),
                                      ),
                                    ),
                                  )
                                  )],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
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
                        _isLoading = true;
                        index = (index! - 1);
                        hid = widget.chap[index!]["hid"];
                        chapterid = widget.chap[index!]["chap"].toString();

                        _apiChapterImages();

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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReplyComments(
                              image: _chapterImage[0]['chapter']['md_images'][0]
                                      ['name']
                                  .toString(),
                              chapterid: widget.chapterid.toString(),
                              hid: widget.hid.toString()),
                        ),
                      );
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
                        _isLoading = true;
                        index = (index! + 1);
                        hid = widget.chap[index!]["hid"];
                        chapterid = widget.chap[index!]["chap"].toString();

                        _apiChapterImages();

                        //widget.chapterid =
                      });
                    }),
              ],
            ),
    );
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

  //get chappterImages details from api
  void _apiChapterImages() async {
    try {
      _chapterImage.clear();
      var bodyRoutes;
      var res = await CallApi().getChapterImages(hid);
      bodyRoutes = json.decode(res.body);

      // Add chapterimages to  List

      _chapterImage.add(bodyRoutes);
      print(_chapterImage[0]['chapter']['md_images']);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
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
}
