import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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

  @override
  Widget build(BuildContext context) {
    var image = "https://meo2.comick.pictures/file/comick/";
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
            padding: EdgeInsets.only(top: 0.0),
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
                                margin: EdgeInsets.all(10.0),
                                width: screenWidth,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: <Widget>[
                                    Container(
                                        decoration: BoxDecoration(
                                          color: kPrimaryWhiteColor,
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: primaryColor,
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(00.0),
                                          child: InkWell(
                                            onTap: () {},
                                            borderRadius:
                                                BorderRadius.circular(00.0),
                                            child: CachedNetworkImage(
                                                height:
                                                    screenHeight * (18 / 20),
                                                width: screenWidth,
                                                imageUrl: image +
                                                    _chapterImage[0]['chapter']
                                                            ['md_images'][index]
                                                        ['b2key'],
                                                imageBuilder: (context,
                                                        imageProvider) =>
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error)),
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.arrow_back_ios_new),
                                color: kPrimaryWhiteColor,
                                onPressed: () {}),
                            IconButton(
                                icon: Icon(Icons.thumb_up_off_alt),
                                color: kPrimaryWhiteColor,
                                onPressed: () {}),
                            IconButton(
                                icon: Icon(Icons.comment_outlined),
                                color: kPrimaryWhiteColor,
                                onPressed: () {}),
                            IconButton(
                                icon: Icon(Icons.favorite),
                                color: kPrimaryWhiteColor,
                                onPressed: () {}),
                            IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                color: kPrimaryWhiteColor,
                                onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
            ])));
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
}
