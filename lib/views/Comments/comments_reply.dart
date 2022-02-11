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
import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReplyComments extends StatefulWidget {
  final String hid;
  final String chapterid;
  final String image;

  const ReplyComments({
    Key? key,
    required this.hid,
    required this.chapterid,
    required this.image,
  }) : super(key: key);

  @override
  _ReplyCommentsState createState() => _ReplyCommentsState();
}

class _ReplyCommentsState extends State<ReplyComments> {
  late String hid;
  late String chapterid;
  late String image;
  TextEditingController _commentController = new TextEditingController();

  String? token;

  List User = [];

  String? __replyComment;
  int? _replyid;
  int? _replyReplyid;
  //listview index
  int? xyz;

  // List ReplyComments = [];

  List<TextEditingController> _controllers = <TextEditingController>[];

  //Success
  String? success;
  String? success1;

  @override
  void initState() {
    //initialize  id for chapterimage
    image = widget.image;
    print(image);
    hid = widget.hid;
    print(hid);
    chapterid = widget.chapterid;
    print(chapterid);

    getCommends();
    _getUserById();
    _replyComments();
    _UpVoteComments();
    _DownVoteComments();
    _reportComment();

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
  bool imageclick = false;

  late int counter = 0;
  late int counterlast = 0;

  void _ReplyDownVoteComments() async {
    // setState(() {
    //   _isLoading = true;
    // });
    try {
      print("ReplyReplyIDDownVote:" + _replyReplyid.toString());
      var data = {
        "id": _replyReplyid.toString(),
      };
      var res = await CallApi().postData(data, 'replyDownVote');
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
    // setState(() {
    //   _isLoading = false;
    //   _controllers.clear();
    // });
  }

  void _replyReportComment() async {
    // setState(() {
    //   _isLoading = true;
    // });
    try {
      print("ReplyReplyIDUpvote:" + _replyReplyid.toString());
      var data = {
        "commentId": _replyReplyid.toString(),
      };
      var res = await CallApi().postData(data, 'replyReportComment');
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
    // setState(() {
    //   _isLoading = false;
    //   _controllers.clear();
    // });
  }

  void _replyUpVoteComments() async {
    // setState(() {
    //   _isLoading = true;
    // });
    try {
      print("ReplyReplyIDUpvote:" + _replyReplyid.toString());
      var data = {
        "id": _replyReplyid.toString(),
      };
      var res = await CallApi().postData(data, 'replyUpVote');
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
    // setState(() {
    //   _isLoading = false;
    //   _controllers.clear();
    // });
  }

  void _reportComment() async {
    // setState(() {
    //   _isLoading = true;
    // });
    try {
      var data = {
        "commentId": _replyid.toString(),
      };
      var res = await CallApi().postData(data, 'reportComment');
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
    // setState(() {
    //   _isLoading = false;
    //   _controllers.clear();
    // });
  }

  void _DownVoteComments() async {
    // setState(() {
    //   _isLoading = true;
    // });
    try {
      print("ReplyIDDownVote:" + _replyid.toString());
      var data = {
        "id": _replyid.toString(),
      };
      var res = await CallApi().postData(data, 'downVote');
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
    // setState(() {
    //   _isLoading = false;
    //   _controllers.clear();
    // });
  }

  void _UpVoteComments() async {
    // setState(() {
    //   _isLoading = true;
    // });
    try {
      print("ReplyIDUpvote:" + _replyid.toString());
      var data = {
        "id": _replyid.toString(),
      };
      var res = await CallApi().postData(data, 'upVote');
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
    // setState(() {
    //   _isLoading = false;
    //   _controllers.clear();
    // });
  }

  void _replyComments() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var data = {
        "commentId": _replyid.toString(),
        "comments": __replyComment,
      };
      var res = await CallApi().postData(data, 'addReplyComment');
      var body = json.decode(res.body);
      print(body);
      success1 = body['message'];

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
      _controllers.clear();
    });
  }

  void addComments() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var data = {
        "chapterId": int.parse(chapterid),
        "comments": _commentController.text,
      };
      var res = await CallApi().postData(data, 'addComment');
      var body = json.decode(res.body);

      success = body['message'];
      print(body['message']);
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
      _commentController.clear();
    });
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

  // //get comments details from api
  // void getReplyCommends() async {
  //   setState(() {
  //     _isLoading2 = true;
  //   });
  //   try {
  //     _getReplyComments.clear();

  //     print("ReplyIDReply:" + _replyid.toString());

  //     var bodyRoutesReply;
  //     var res = await CallApi().getReplyComments(
  //         'getReplyCommentByCommentId/' + _replyid.toString());
  //     bodyRoutesReply = json.decode(res.body);

  //     _getReplyComments.add(bodyRoutesReply);
  //     print(_getReplyComments[0]);
  //     print('//////////////');
  //     print(_getReplyComments[0]['message']);

  //     print(_getReplyComments[0]['message'][1]['comments']);

  //     print('//////////////');
  //     print(_getReplyComments[0]['message'].length);
  //     // print(_getReplyComments[0].last['comments']);

  //   } catch (e) {
  //     print(e);
  //   }
  //   setState(() {
  //     _isLoading2 = false;
  //   });
  // }

  //get comments details from api
  void getCommends() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _getComments.clear();

      var bodyRoutes;
      var res = await CallApi().getComments('viewComment');
      bodyRoutes = json.decode(res.body);

      _getComments.add(bodyRoutes);
      print(_getComments);
      print(_getComments[0].last['comments']);

      _getReplyComments.clear();

      print("ReplyIDReply:" + _replyid.toString());

      var bodyRoutesReply;
      var resReply = await CallApi().getReplyComments(
          'getReplyCommentByCommentId/' + _replyid.toString());
      bodyRoutesReply = json.decode(resReply.body);

      _getReplyComments.add(bodyRoutesReply);
      print(_getReplyComments[0]);
      print('//////////////');
      print(_getReplyComments[0]['message']);

      print(_getReplyComments[0]['message'][1]['comments']);

      print('//////////////');
      print(_getReplyComments[0]['message'].length);
      // print(_getReplyComments[0].last['comments']);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    var image = "https://meo2.comick.pictures/file/comick/";
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: _isLoading
            ? Center(
                child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: CupertinoActivityIndicator(
                  radius: 15,
                ),
              ))
            : Stack(children: [
                CachedNetworkImage(
                    height: screenHeight * (18 / 20),
                    width: screenWidth,
                    imageUrl: image + widget.image.toString(),
                    imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                    errorWidget: (context, url, error) => Icon(Icons.error)),
                SafeArea(
                    child: Container(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                              width: 300,
                                              child: Center(
                                                  child: Text(
                                                "Chapter " + chapterid,
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
                                              _getComments[0]
                                                      .length
                                                      .toString() +
                                                  " Comments",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            // Container(
                                            //   width: 100,
                                            //   height: 20,
                                            //   child: Row(
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment.end,
                                            //     children: [
                                            //       Text(
                                            //         "Top",
                                            //         style: TextStyle(
                                            //             fontSize: 13,
                                            //             color: Colors.grey),
                                            //       ),
                                            //       VerticalDivider(
                                            //         thickness: 1,
                                            //         color: Colors.grey,
                                            //       ),
                                            //       Text(
                                            //         "New",
                                            //         style: TextStyle(
                                            //             fontSize: 13,
                                            //             color:
                                            //                 Colors.purple[900]),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
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
                                            child: _isLoading
                                                ? Center(
                                                    child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 30.0),
                                                    child:
                                                        CupertinoActivityIndicator(
                                                      radius: 15,
                                                    ),
                                                  ))
                                                : SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            20),
                                                                child:
                                                                    CircleAvatar(
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
                                                                        left:
                                                                            20.0,
                                                                        top:
                                                                            40),
                                                                child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        User[0][
                                                                            'name'],
                                                                        style: TextStyle(
                                                                            color:
                                                                                kPrimaryWhiteColor,
                                                                            fontSize:
                                                                                16.0,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      User[0]['batchId'].toString() ==
                                                                              null
                                                                          ? Padding(
                                                                              padding: const EdgeInsets.only(top: 5),
                                                                              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                                                                Container(
                                                                                  width: 150,
                                                                                  height: 30,
                                                                                  decoration: BoxDecoration(color: kPrimaryWhiteColor, borderRadius: BorderRadius.circular(15)),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Icon(
                                                                                        Icons.batch_prediction,
                                                                                        color: Colors.purple,
                                                                                      ),
                                                                                      Text(
                                                                                        User[0]['batchId'].toString(),
                                                                                        style: TextStyle(fontSize: 13, color: kPrimaryPurpleColor),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ]),
                                                                            )
                                                                          : SizedBox(
                                                                              height: 30,
                                                                            ),
                                                                    ]),
                                                              )
                                                            ]),
                                                        SingleChildScrollView(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 60,
                                                                    right: 5),
                                                            child: Container(
                                                              height: 400,
                                                              child: _isLoading
                                                                  ? Center(
                                                                      child:
                                                                          Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              30.0),
                                                                      child:
                                                                          CupertinoActivityIndicator(
                                                                        radius:
                                                                            15,
                                                                      ),
                                                                    ))
                                                                  : ListView
                                                                      .builder(
                                                                          itemCount: _getComments[0]
                                                                              .length,
                                                                          itemBuilder:
                                                                              (BuildContext context, int index) {
                                                                            return StatefulBuilder(builder:
                                                                                (BuildContext context, StateSetter setState) {
                                                                              // //list controller
                                                                              _controllers.add(new TextEditingController());
                                                                              return Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    _getComments[0][index]['comments'],
                                                                                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14),
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                                                      Padding(
                                                                                          padding: EdgeInsets.only(left: 5),
                                                                                          child: InkWell(
                                                                                              onTap: () => {
                                                                                                    _replyid = _getComments[0][index]['id'],
                                                                                                    if (_replyid == _getComments[0][index]['id'])
                                                                                                      {
                                                                                                        _UpVoteComments(),
                                                                                                      }
                                                                                                  },
                                                                                              child: Container(
                                                                                                height: 20,
                                                                                                width: 20,
                                                                                                child: Image.asset('assets/up-arrow (1).png'),
                                                                                              ))),
//SizedBox(width: 5.0),
                                                                                      // Text(
                                                                                      //   "233",
                                                                                      //   style: TextStyle(
                                                                                      //     color: Colors.white,
                                                                                      //     fontSize: 12,
                                                                                      //   ),
                                                                                      // ),

                                                                                      Padding(
                                                                                          padding: EdgeInsets.only(left: 5),
                                                                                          child: InkWell(
                                                                                              onTap: () => {
                                                                                                    _replyid = _getComments[0][index]['id'],
                                                                                                    if (_replyid == _getComments[0][index]['id'])
                                                                                                      {
                                                                                                        _DownVoteComments(),
                                                                                                      }
                                                                                                  },
                                                                                              child: Container(
                                                                                                height: 20,
                                                                                                width: 20,
                                                                                                child: Image.asset('assets/down-arrow (1).png'),
                                                                                              ))),

                                                                                      // Text(
                                                                                      //   "43",
                                                                                      //   style: TextStyle(
                                                                                      //     color: Colors.white,
                                                                                      //     fontSize: 12,
                                                                                      //   ),
                                                                                      // ),

                                                                                      IconButton(
                                                                                        icon: Icon(
                                                                                          Icons.comment,
                                                                                          size: 25.0,
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                        onPressed: () async {
                                                                                          setState(() {
                                                                                            xyz = index;
                                                                                            _replyid = _getComments[0][index]['id'];
                                                                                            print("ReplyID:" + _replyid.toString());

                                                                                            if (_replyid == _getComments[0][index]['id']) {
                                                                                              getCommends();
                                                                                            }
                                                                                          });
                                                                                        },
                                                                                      ),

                                                                                      // Text(
                                                                                      //   "22",
                                                                                      //   style: TextStyle(
                                                                                      //     color: Colors.white,
                                                                                      //     fontSize: 12,
                                                                                      //   ),
                                                                                      // ),
                                                                                      IconButton(
                                                                                        icon: Icon(Icons.report),
                                                                                        color: kPrimaryPurpleColor,
                                                                                        onPressed: () async {
                                                                                          _replyid = _getComments[0][index]['id'];
                                                                                          if (_replyid == _getComments[0][index]['id']) {
                                                                                            showAlert(context);
                                                                                          }
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  index == xyz
                                                                                      ? Padding(
                                                                                          padding: const EdgeInsets.only(
                                                                                            left: 30,
                                                                                          ),
                                                                                          child: Column(
                                                                                            children: [
                                                                                              Container(
                                                                                                height: 150,
                                                                                                alignment: Alignment.topLeft,
                                                                                                padding: const EdgeInsets.only(
                                                                                                  left: 10,
                                                                                                ),
                                                                                                decoration: BoxDecoration(
                                                                                                    color: Colors.grey,
                                                                                                    border: Border.all(color: Colors.grey, width: 4.0),
                                                                                                    borderRadius: BorderRadius.all(
                                                                                                      Radius.circular(8.0),
                                                                                                    )),
                                                                                                child: _isLoading
                                                                                                    ? Center(
                                                                                                        child: Padding(
                                                                                                        padding: const EdgeInsets.only(
                                                                                                          top: 10.0,
                                                                                                          left: 30,
                                                                                                        ),
                                                                                                        child: CupertinoActivityIndicator(
                                                                                                          radius: 15,
                                                                                                        ),
                                                                                                      ))
                                                                                                    : ListView.builder(
                                                                                                        itemCount: _getReplyComments[0]['message'].length,
                                                                                                        itemBuilder: (BuildContext context, int index) {
                                                                                                          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                                                                                            return Column(
                                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  _getReplyComments[0]['message'][index]['comments'],
                                                                                                                  style: TextStyle(color: kPrimaryWhiteColor, fontWeight: FontWeight.bold, fontSize: 14),
                                                                                                                ),
                                                                                                                Row(
                                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                                                                                    Padding(
                                                                                                                        padding: EdgeInsets.only(left: 5),
                                                                                                                        child: InkWell(
                                                                                                                            onTap: () => {
                                                                                                                                  _replyReplyid = _getReplyComments[0]['message'][index]['id'],
                                                                                                                                  if (_replyReplyid == _getReplyComments[0]['message'][index]['id'])
                                                                                                                                    {
                                                                                                                                      _replyUpVoteComments(),
                                                                                                                                    }
                                                                                                                                },
                                                                                                                            child: Container(
                                                                                                                              height: 20,
                                                                                                                              width: 20,
                                                                                                                              child: Image.asset('assets/up-arrow (1).png'),
                                                                                                                            ))),
//SizedBox(width: 5.0),
                                                                                                                    // Text(
                                                                                                                    //   "233",
                                                                                                                    //   style: TextStyle(
                                                                                                                    //     color: Colors.white,
                                                                                                                    //     fontSize: 12,
                                                                                                                    //   ),
                                                                                                                    // ),

                                                                                                                    Padding(
                                                                                                                        padding: EdgeInsets.only(left: 5),
                                                                                                                        child: InkWell(
                                                                                                                            onTap: () => {
                                                                                                                                  _replyReplyid = _getReplyComments[0]['message'][index]['id'],
                                                                                                                                  if (_replyReplyid == _getReplyComments[0]['message'][index]['id'])
                                                                                                                                    {
                                                                                                                                      _ReplyDownVoteComments(),
                                                                                                                                    }
                                                                                                                                },
                                                                                                                            child: Container(
                                                                                                                              height: 20,
                                                                                                                              width: 20,
                                                                                                                              child: Image.asset('assets/down-arrow (1).png'),
                                                                                                                            ))),

                                                                                                                    // Text(
                                                                                                                    //   "43",
                                                                                                                    //   style: TextStyle(
                                                                                                                    //     color: Colors.white,
                                                                                                                    //     fontSize: 12,
                                                                                                                    //   ),
                                                                                                                    // ),

                                                                                                                    // IconButton(
                                                                                                                    //   icon: Icon(
                                                                                                                    //     Icons.comment,
                                                                                                                    //     size: 25.0,
                                                                                                                    //     color: kPrimaryWhiteColor,
                                                                                                                    //   ),
                                                                                                                    //   onPressed: () {
                                                                                                                    //     setState(() {
                                                                                                                    //       _replyReplyid = _getReplyComments[0]['message'][index]['id'];
                                                                                                                    //       print("ReplyReplyID:" + _replyReplyid.toString());

                                                                                                                    //       if (_replyReplyid == _getReplyComments[0]['message'][index]['id']) {
                                                                                                                    //         _ge
                                                                                                                    //       }
                                                                                                                    //     });
                                                                                                                    //   },
                                                                                                                    // ),

                                                                                                                    // Text(
                                                                                                                    //   "22",
                                                                                                                    //   style: TextStyle(
                                                                                                                    //     color: Colors.white,
                                                                                                                    //     fontSize: 12,
                                                                                                                    //   ),
                                                                                                                    // ),
                                                                                                                    IconButton(
                                                                                                                      icon: Icon(Icons.report),
                                                                                                                      color: kPrimaryPurpleColor,
                                                                                                                      onPressed: () async {
                                                                                                                        _replyReplyid = _getReplyComments[0]['message'][index]['id'];
                                                                                                                        if (_replyReplyid == _getReplyComments[0]['message'][index]['id']) {
                                                                                                                          replyshowAlert(context);
                                                                                                                        }
                                                                                                                      },
                                                                                                                    ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                              ],
                                                                                                            );
                                                                                                          });
                                                                                                        }),
                                                                                              ),
                                                                                              Padding(
                                                                                                  padding: EdgeInsets.only(
                                                                                                    bottom: 10,
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        height: 30,
                                                                                                        width: screenWidth * 0.5,
                                                                                                        child: TextFormField(
                                                                                                          controller: _controllers[index],
                                                                                                          textAlign: TextAlign.left,
                                                                                                          decoration: InputDecoration(
                                                                                                            filled: true,
                                                                                                            fillColor: Colors.grey,
                                                                                                            enabledBorder: OutlineInputBorder(
                                                                                                              borderSide: const BorderSide(width: 3, color: Colors.grey),
                                                                                                              borderRadius: BorderRadius.circular(0),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      IconButton(
                                                                                                          icon: Icon(Icons.send),
                                                                                                          color: Colors.white,
                                                                                                          onPressed: () async {
                                                                                                            setState(() {
                                                                                                              //   _controllers[index].clear();
                                                                                                              // _replyid = _getComments[0][index]['id'];
                                                                                                              // print(_replyid.toString());

                                                                                                              __replyComment = _controllers[index].text;
                                                                                                              _replyComments();

                                                                                                              //_replyReplyid = _getReplyComments[0]['message'][index]['id'];
                                                                                                              if (_replyReplyid == _getReplyComments[0]['message'][index]['id']) {
                                                                                                                successReplyAlert(context);
                                                                                                              }
                                                                                                            });
                                                                                                          }),
                                                                                                    ],
                                                                                                  )),
                                                                                            ],
                                                                                          ))
                                                                                      : SizedBox()
                                                                                ],
                                                                              );
                                                                            });
                                                                          }),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 30,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  height: 40,
                                                                  width:
                                                                      screenWidth *
                                                                          (3.8 /
                                                                              5),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        _commentController,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          Colors
                                                                              .grey,
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            width:
                                                                                3,
                                                                            color:
                                                                                Colors.grey),
                                                                        borderRadius:
                                                                            BorderRadius.circular(0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                    icon: Icon(
                                                                        Icons
                                                                            .send),
                                                                    color: Colors
                                                                        .white,
                                                                    onPressed:
                                                                        () async {
                                                                      addComments();
                                                                      successAlert(
                                                                          context);
                                                                    }),
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                  ))),
                                  ]),
                            ),
                          ),
                        ))))
              ]));
  }

  //dailog box
  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.black,
            title: Center(
              child: Text("Report Comments ?",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            actions: <Widget>[
              FlatButton(
                child: Padding(
                  padding: const EdgeInsets.only(right: 68.0),
                  child: Text("Cancle",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                ),
                onPressed: () {
                  //Put your code here which you want to execute on Yes button click.
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Report",
                    style: TextStyle(color: Colors.purple[900], fontSize: 16)),
                onPressed: () {
                  //Put your code here which you want to execute on Cancel button click.
                  _reportComment();
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }

  //dailog box
  replyshowAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.black,
            title: Center(
              child: Text("Report Comments ?",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            actions: <Widget>[
              FlatButton(
                child: Padding(
                  padding: const EdgeInsets.only(right: 68.0),
                  child: Text("Cancle",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                ),
                onPressed: () {
                  //Put your code here which you want to execute on Yes button click.
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Report",
                    style: TextStyle(color: Colors.purple[900], fontSize: 16)),
                onPressed: () {
                  //Put your code here which you want to execute on Cancel button click.
                  _replyReportComment();
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }

  //success comments
  successReplyAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.black,
            title: Center(
              child: Text(success1.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK",
                    style: TextStyle(color: Colors.purple[900], fontSize: 16)),
                onPressed: () {
                  //Put your code here which you want to execute on Cancel button click.

                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }

  //success comments
  successAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.black,
            title: Center(
              child: Text(success.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK",
                    style: TextStyle(color: Colors.purple[900], fontSize: 16)),
                onPressed: () {
                  //Put your code here which you want to execute on Cancel button click.

                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }
}
