import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    //initialize subject id for grades
    hid = widget.hid;
    print(hid);
    _apiChapterImages();

    super.initState();
  }

  //initialize list for add grades from API
  List _chapterImage = [];

  // loader
  bool _isLoading = false;

   int slideIndex = 0;

  @override
  Widget build(BuildContext context) {
    var image = "https://meo2.comick.pictures/file/comick/";
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: ListView(children: [
              Stack(
                children: <Widget>[
                  Container(
                            height: screenHeight * (18 / 20),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _chapterImage[0]['chapter']['md_images']
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(10.0),
                          width: screenWidth,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              // Positioned(
                              //   bottom: 15.0,
                              //   child: Container(
                              //     height: 120.0,
                              //     width: 200.0,
                              //     decoration: BoxDecoration(
                              //       color: Colors.grey[850],
                              //       borderRadius: BorderRadius.circular(0.0),
                              //     ),
                              //     child: Padding(
                              //       padding: EdgeInsets.all(10.0),
                              //       child: Column(
                              //         mainAxisAlignment: MainAxisAlignment.end,
                              //         crossAxisAlignment: CrossAxisAlignment.start,
                              //         children: <Widget>[
                              //           Text(
                              //             "Dragon Ball",
                              //             style: TextStyle(
                              //               color: kPrimaryWhiteColor,
                              //               fontSize: 16.0,
                              //             ),
                              //           ),
                              //           SizedBox(height: 20.0),
                              //           Padding(
                              //             padding: const EdgeInsets.only(top: 10.0),
                              //             child: Row(
                              //               mainAxisAlignment: MainAxisAlignment.start,
                              //               children: [
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.start,
                              //                   children: [
                              //                     Text(
                              //                       "ch3",
                              //                       style: TextStyle(
                              //                         fontSize: 12,
                              //                         color: kPrimaryWhiteColor,
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 SizedBox(width: 60),
                              //                 Text(
                              //                   _chapterImage[0]['chapter']['md_images'][index]['h'].toString(),
                              //                   style: TextStyle(
                              //                     fontSize: 13,
                              //                     color: kPrimaryWhiteColor,
                              //                   ),
                              //                 ),
                              //                 SizedBox(width: 30),
                              //                 Text(
                              //                   "line 23",
                              //                   style: TextStyle(
                              //                     fontSize: 12,
                              //                     color: kPrimaryWhiteColor,
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(0.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(00.0),
                                    child: InkWell(
                                      onTap: () {
                                        // print(ViewManga[0][index]);
                                        // _navigator(context,
                                        //     Chapter([ViewManga[0][index]]));
                                      },
                                      borderRadius: BorderRadius.circular(00.0),
                                      child: CachedNetworkImage(
                                            height: screenHeight * (18 / 20),
                                          width: screenWidth,
                                          imageUrl:image+ _chapterImage[0]['chapter']
                                              ['md_images'][index]['b2key'],
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
                                  )
                                  // child: ClipRRect(
                                  //   borderRadius: BorderRadius.circular(00.0),
                                  //   child: CachedNetworkImage(
                                  //                         height: 160,
                                  //                         width: 200,
                                  //                         imageUrl: _chapterImage[0]['chapter']['md_images'][index]['b2key'],
                                  //                         imageBuilder: (context,
                                  //                                 imageProvider) =>
                                  //                             Container(
                                  //                               decoration: BoxDecoration(
                                  //                                 borderRadius:
                                  //                                     BorderRadius.circular(
                                  //                                         5),
                                  //                                 image: DecorationImage(
                                  //                                     image: imageProvider,
                                  //                                     fit: BoxFit.cover),
                                  //                               ),
                                  //                             ),
                                  //                         errorWidget:
                                  //                             (context, url, error) =>
                                  //                                 Icon(Icons.error)),
                                  // ),
                                  )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              // Stack(
              //   children: <Widget>[
              //     Container(
              //       height: screenHeight * (18 / 20),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(0.0),
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.black26,
              //             offset: Offset(0.0, 2.0),
              //             blurRadius: 6.0,
              //           ),
              //         ],
              //       ),
              //       child: Image(
              //         image: AssetImage("assets/image-4.png"),
              //         width: screenWidth,
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //     Padding(
              //         padding: EdgeInsets.symmetric(
              //             horizontal: 145.0, vertical: 50.0),
              //         child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: <Widget>[
              //               Text('Chapter 2 ',
              //                   style: TextStyle(
              //                     color: Colors.white,
              //                     fontSize: 20,
              //                   ),
              //                   textAlign: TextAlign.center),
              //             ])),
              //     Container(
              //       margin: EdgeInsets.only(top: 40),
              //       child: Align(
              //         alignment: Alignment.topCenter,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             IconButton(
              //                 icon: Icon(
              //                   Icons.arrow_back_ios,
              //                   color: Colors.white,
              //                 ),
              //                 onPressed: () {
              //                   Navigator.pop(
              //                     context,
              //                     // MaterialPageRoute(
              //                     //   builder: (context) => HomePage(),
              //                     // ),
              //                   );
              //                 }),
              //             IconButton(
              //                 icon: Icon(
              //                   Icons.keyboard_control_rounded,
              //                   color: Colors.white,
              //                 ),
              //                 onPressed: () {})
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      color: Colors.white,
                      onPressed: () {}),

                  // SizedBox(width: screenWidth * (1 / 10)),
                  IconButton(
                      icon: Icon(Icons.thumb_up_off_alt),
                      color: Colors.white,
                      onPressed: () {}),
                  //  SizedBox(width: screenWidth * (1 / 10)),
                  IconButton(
                      icon: Icon(Icons.comment_outlined),
                      color: Colors.white,
                      onPressed: () {}),
                  //  SizedBox(width: screenWidth * (1 / 10)),
                  IconButton(
                      icon: Icon(Icons.favorite),
                      color: Colors.white,
                      onPressed: () {}),
                  //   SizedBox(width: screenWidth * (1 / 10)),
                  IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      color: Colors.white,
                      onPressed: () {
                        
                        
                      }),
                ],
              ),
            ])));
  }

//get subjects details from api
  void _apiChapterImages() async {
    try {
      _chapterImage.clear();
      var bodyRoutes;
      var res = await CallApi().getChapterImages(widget.hid);
      bodyRoutes = json.decode(res.body);

      // Add subjects to _SubjectsFromDB List

      _chapterImage.add(bodyRoutes);
      print(_chapterImage[0]['chapter']['md_images'][0]['b2key'].length);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}

final List<Map<String, dynamic>> _allUsers = [
  {"image": "assets/image-1.png", "title": "Dragonball"},
  {"image": "assets/image-2.png", "title": "Dragonball"},
  {"image": "assets/image-6.png", "title": "Dragonball"},
  {"image": "assets/image-4.png", "title": "Dragonball"},
  {"image": "assets/image-5.png", "title": "Dragonball"},
];
