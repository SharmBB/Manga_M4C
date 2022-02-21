import 'dart:convert';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:floating_navbar/floating_navbar.dart';
import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';

import 'package:mangakiku_app/views/Account/account.dart';
import 'package:mangakiku_app/views/Browser/browser.dart';
import 'package:mangakiku_app/views/LeaderBoard/leaderboard.dart';
import 'package:mangakiku_app/views/Library/library.dart';
import 'package:mangakiku_app/views/Setting/setting.dart';
import 'package:mangakiku_app/views/chapter/chapter.dart';
import 'package:mangakiku_app/views/type/sliderType.dart';
import 'package:mangakiku_app/views/type/type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

var currentIndex = 0;
int selectedIndex = 0;

List<IconData> listOfIcons = [
  Icons.home_rounded,
  Icons.settings,
  Icons.account_box,
  Icons.library_add_rounded,
  Icons.leaderboard,
];

class _HomePageState extends State<HomePage> {
//list for api
  List manga = [];
  List Newmanga = [];
  List ViewManga = [];
  List RatingManga = [];
  List ApiSetting = [];
  List User = [];

  List dummy = [
    {
      "title": "Say Hello to Black Jack",
      "id": 1035,
      "slug": "say-hello-to-black-jack",
      "rating": "9.04",
      "rating_count": 50,
      "follow_count": 545,
      "demographic": 3,
      "md_titles": [
        {"title": "医界风云"},
        {"title": "杏林先锋"}
      ],
      "md_comics": {
        "id": 1035,
        "title": "say-hello-to-black-jack",
        "slug": "say-hello-to-black-jack",
        "md_covers": [
          {
            "url": "d3e1ec32-2b49-4c6c-9a42-7a517fdcb8fb.jpg",
            "vol": "1",
            "w": 680,
            "h": 962,
            "gpurl":
                "https://uploads.mangadex.org/covers/9fca3c19-ac41-4ebf-8735-f4e3becc2b3e/d3e1ec32-2b49-4c6c-9a42-7a517fdcb8fb.jpg",
            "b2key": "4bQbO.jpg"
          }
        ]
      },
      "md_covers": [
        {
          "url": "d3e1ec32-2b49-4c6c-9a42-7a517fdcb8fb.jpg",
          "vol": "1",
          "w": 680,
          "h": 962,
          "gpurl":
              "https://uploads.mangadex.org/covers/9fca3c19-ac41-4ebf-8735-f4e3becc2b3e/d3e1ec32-2b49-4c6c-9a42-7a517fdcb8fb.jpg",
          "b2key": "4bQbO.jpg"
        }
      ]
    },
    {
      "title": "Shin Black Jack ni Yoroshiku",
      "id": 62631,
      "slug": "shin-black-jack-ni-yoroshiku",
      "rating": "0",
      "rating_count": 0,
      "follow_count": 3,
      "demographic": 3,
      "md_titles": [
        {"title": "Say Hello to Black Jack"}
      ],
      "md_comics": {
        "id": 62631,
        "title": "shin-black-jack-ni-yoroshiku",
        "slug": "shin-black-jack-ni-yoroshiku",
        "md_covers": [
          {
            "url": "8cef962a-de24-4af6-8d80-b2343dcbe6bf.jpg",
            "vol": null,
            "w": 630,
            "h": 884,
            "gpurl":
                "https://uploads.mangadex.org/covers/60b7e197-5929-4307-8edb-780419b9ba05/8cef962a-de24-4af6-8d80-b2343dcbe6bf.jpg",
            "b2key": "QbxrY.jpg"
          }
        ]
      },
      "md_covers": [
        {
          "url": "8cef962a-de24-4af6-8d80-b2343dcbe6bf.jpg",
          "vol": null,
          "w": 630,
          "h": 884,
          "gpurl":
              "https://uploads.mangadex.org/covers/60b7e197-5929-4307-8edb-780419b9ba05/8cef962a-de24-4af6-8d80-b2343dcbe6bf.jpg",
          "b2key": "QbxrY.jpg"
        }
      ]
    },
    {
      "title": "Bukkira ni Yoroshiku!",
      "id": 23488,
      "slug": "bukkira-ni-yoroshiku",
      "rating": "4.5",
      "rating_count": 2,
      "follow_count": 46,
      "demographic": 1,
      "md_titles": [
        {"title": "Say Hello To Bookila!"},
        {"title": "ブッキラによろしく!"}
      ],
      "md_comics": {
        "id": 23488,
        "title": "bukkira-ni-yoroshiku",
        "slug": "bukkira-ni-yoroshiku",
        "md_covers": [
          {
            "url": "6454b42d-9eac-4bff-8427-2410e868a138.jpg",
            "vol": null,
            "w": 600,
            "h": 846,
            "gpurl":
                "https://uploads.mangadex.org/covers/56dcebfb-4483-4590-bb1d-a6772d4f2664/6454b42d-9eac-4bff-8427-2410e868a138.jpg",
            "b2key": "JZvvz.jpg"
          }
        ]
      },
      "md_covers": [
        {
          "url": "6454b42d-9eac-4bff-8427-2410e868a138.jpg",
          "vol": null,
          "w": 600,
          "h": 846,
          "gpurl":
              "https://uploads.mangadex.org/covers/56dcebfb-4483-4590-bb1d-a6772d4f2664/6454b42d-9eac-4bff-8427-2410e868a138.jpg",
          "b2key": "JZvvz.jpg"
        }
      ]
    }
  ];

  String token = "";
  String bio = "";
  String name = "";

  int? usernameId;

// loader
  bool _isLoading = true;

  //bottom navigation purple
  int bottomPurple = 0;

  @override
  initState() {
    _apiMangaDetails();
    //   _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var image_manga = "https://cdn.statically.io/img/meo.comick.pictures/";
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var userImage = "https://mangakiku-api.moodfor.codes";

    return _isLoading
        ? Center(
            child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: CupertinoActivityIndicator(),
          ))
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: ApiSetting[0]['value'] == 1
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Account()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                       userImage + User[0]['image'],
                          ),
                        ),
                      ))
                  : SizedBox(),
              actions: <Widget>[
                ApiSetting[0]['value'] == 1
                    ? IconButton(
                        icon: Icon(Icons.description_outlined,
                            color: kPrimaryWhiteColor),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Account()),
                          );
                        },
                      )
                    : SizedBox(),
                ApiSetting[0]['value'] == 1
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, right: 10, bottom: 10),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: kPrimaryPurpleColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: IconButton(
                            icon: Icon(Icons.search, color: kPrimaryWhiteColor),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Browser()),
                              );
                            },
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
            body: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  // ignore: deprecated_member_use
                  overscroll.disallowGlow();
                  return false;
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: ListView(
                    children: [
                      CarouselSlider(
                        items: [
                          //1st Image of Slider
                          Container(
                            child: InkWell(onTap: () {
                              _navigator(
                                  context, SlideDetailsScreen([dummy[0]]));
                            }),
                            width: MediaQuery.of(context).size.width * 0.7,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  dummy[0]['md_covers'][0]['gpurl'],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          //2nd Image of Slider
                          Container(
                            child: InkWell(onTap: () {
                              _navigator(
                                  context, SlideDetailsScreen([dummy[0]]));
                            }),
                            width: MediaQuery.of(context).size.width * 0.8,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  dummy[1]['md_covers'][0]['gpurl'],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          //3rd Image of Slider
                          Container(
                            child: InkWell(onTap: () {
                              _navigator(
                                  context, SlideDetailsScreen([dummy[0]]));
                            }),
                            width: MediaQuery.of(context).size.width * 0.7,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  dummy[2]['md_covers'][0]['gpurl'],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          //4th Image of Slider
                          // Container(
                          //   width: MediaQuery.of(context).size.width * 0.7,
                          //   margin: EdgeInsets.symmetric(horizontal: 5.0),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(8.0),
                          //     image: DecorationImage(
                          //       image: NetworkImage(
                          //         ViewManga[0][8]['md_covers'][0]['gpurl'],
                          //       ),
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),

                          //5th Image of Slider
                          // Container(
                          //   width: MediaQuery.of(context).size.width * 0.7,
                          //   margin: EdgeInsets.symmetric(horizontal: 5.0),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(8.0),
                          //     image: DecorationImage(
                          //       image: NetworkImage(
                          //         manga[0][10]['md_comics']['md_covers'][0]
                          //             ['gpurl'],
                          //       ),
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                        ],

                        //Slider Container properties
                        options: CarouselOptions(
                          height: 200.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 1000),
                          viewportFraction: 0.8,
                        ),
                      ),
                      ApiSetting[0]['value'] == 1
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Hot",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryWhiteColor),
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Browser(),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              // child: Text(
                                              //   " More >",
                                              //   style: TextStyle(
                                              //     color: kPrimaryGreyColor,
                                              //     fontSize: 12,
                                              //   ),
                                              // ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                //Seasonals mangas lists
                                _isLoading
                                    ? Center(
                                        child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 30.0),
                                        child: CupertinoActivityIndicator(
                                          radius: 20,
                                        ),
                                      ))
                                    : Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[],
                                            ),
                                          ),
                                          Container(
                                            height: 360.0,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: manga[0].length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  margin: EdgeInsets.all(10.0),
                                                  width: 180.0,
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    children: <Widget>[
                                                      Positioned(
                                                        bottom: 15.0,
                                                        child: Container(
                                                          height: 120.0,
                                                          width: 200.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey[850],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  manga[0][index]['md_comics']['title']
                                                                              .length <=
                                                                          20
                                                                      ? manga[0][index]['md_comics']
                                                                              [
                                                                              'title']
                                                                          .toString()
                                                                      : manga[0][index]['md_comics']
                                                                              [
                                                                              'title']
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              20),
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        kPrimaryWhiteColor,
                                                                    fontSize:
                                                                        16.0,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        20.0),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            'ch ' +
                                                                                manga[0][index]['chap'],
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              color: kPrimaryWhiteColor,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      //  SizedBox(width: 55),
                                                                      // Text(
                                                                      //   ".",
                                                                      //   style: TextStyle(
                                                                      //     fontSize: 13,
                                                                      //     color:
                                                                      //         kPrimaryWhiteColor,
                                                                      //   ),
                                                                      // ),
                                                                      SizedBox(
                                                                          width:
                                                                              25),
                                                                      Text(
                                                                        ". " +
                                                                            manga[0][index]['distanceTime'],
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
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black26,
                                                                blurRadius: 6.0,
                                                              ),
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        00.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                print(manga[0]
                                                                    [index]);
                                                                _navigator(
                                                                    context,
                                                                    DetailsScreen([
                                                                      manga[0][
                                                                          index]
                                                                    ]));
                                                              },
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          00.0),
                                                              child:
                                                                  CachedNetworkImage(
                                                                      height:
                                                                          250,
                                                                      width:
                                                                          180,
                                                                      imageUrl: manga[0][index]['md_comics']['md_covers']
                                                                              [
                                                                              0]
                                                                          [
                                                                          'gpurl'],
                                                                      imageBuilder:
                                                                          (context, imageProvider) =>
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                                                ),
                                                                              ),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          Icon(Icons
                                                                              .error)),
                                                            ),
                                                          ))
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "New",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryWhiteColor),
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Browser(),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              // child: Text(
                                              //   " More >",
                                              //   style: TextStyle(
                                              //     color: kPrimaryGreyColor,
                                              //     fontSize: 12,
                                              //   ),
                                              // ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

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
                                    Container(
                                      height: 360.0,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: Newmanga[0].length,
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
                                                      color: Colors.grey[850],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            Newmanga[0][index]['md_comics'][
                                                                            'title']
                                                                        .length <=
                                                                    20
                                                                ? Newmanga[0][index]
                                                                            ['md_comics'][
                                                                        'title']
                                                                    .toString()
                                                                : Newmanga[0][index]
                                                                            ['md_comics']
                                                                        [
                                                                        'title']
                                                                    .toString()
                                                                    .substring(
                                                                        0, 20),
                                                            style: TextStyle(
                                                              color:
                                                                  kPrimaryWhiteColor,
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 20.0),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'ch ' +
                                                                          Newmanga[0][index]
                                                                              [
                                                                              'chap'],
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

                                                                // Text(
                                                                //   ".",
                                                                //   style: TextStyle(
                                                                //     fontSize: 13,
                                                                //     color:
                                                                //         kPrimaryWhiteColor,
                                                                //   ),
                                                                // ),
                                                                SizedBox(
                                                                    width: 25),
                                                                Text(
                                                                  ". " +
                                                                      Newmanga[0]
                                                                              [
                                                                              index]
                                                                          [
                                                                          'distanceTime'],
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
                                                          print(Newmanga[0]
                                                              [index]);
                                                          _navigator(
                                                              context,
                                                              DetailsScreen([
                                                                Newmanga[0]
                                                                    [index]
                                                              ]));
                                                        },
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(00.0),
                                                        child:
                                                            CachedNetworkImage(
                                                                height: 250,
                                                                width: 180,
                                                                imageUrl: Newmanga[0][index]
                                                                            ['md_comics']
                                                                        ['md_covers']
                                                                    [
                                                                    0]['gpurl'],
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            image:
                                                                                DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                                          ),
                                                                        ),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error)),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Recently Added",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryWhiteColor),
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Browser(),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              // child: Text(
                                              //   " More >",
                                              //   style: TextStyle(
                                              //     color: kPrimaryGreyColor,
                                              //     fontSize: 12,
                                              //   ),
                                              // ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
                                    Container(
                                      height: 360.0,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: ViewManga[0].length,
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
                                                      color: Colors.grey[850],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            ViewManga[0][index][
                                                                            'title']
                                                                        .length <=
                                                                    20
                                                                ? ViewManga[0][
                                                                            index]
                                                                        [
                                                                        'title']
                                                                    .toString()
                                                                : ViewManga[0][
                                                                            index]
                                                                        [
                                                                        'title']
                                                                    .toString()
                                                                    .substring(
                                                                        0, 20),
                                                            style: TextStyle(
                                                              color:
                                                                  kPrimaryWhiteColor,
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 20.0),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'ch ' +
                                                                          ViewManga[0][index]
                                                                              [
                                                                              'last_chapter'],
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
                                                                Text(
                                                                  ". " +
                                                                      Newmanga[0]
                                                                              [
                                                                              index]
                                                                          [
                                                                          'distanceTime'],
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
                                                          print(ViewManga[0]
                                                              [index]);
                                                          _navigator(
                                                              context,
                                                              Chapter([
                                                                ViewManga[0]
                                                                    [index]
                                                              ]));
                                                        },
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(00.0),
                                                        child:
                                                            CachedNetworkImage(
                                                                height: 250,
                                                                width: 180,
                                                                imageUrl: ViewManga[0]
                                                                            [index]
                                                                        [
                                                                        'md_covers']
                                                                    [
                                                                    0]['gpurl'],
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            image:
                                                                                DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                                          ),
                                                                        ),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error)),
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
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Top MANGAS",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryWhiteColor),
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Browser(),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              // child: Text(
                                              //   " More >",
                                              //   style: TextStyle(
                                              //     color: kPrimaryGreyColor,
                                              //     fontSize: 12,
                                              //   ),
                                              // ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // MangakikuCard(),
                                _isLoading
                                    ? Center(
                                        child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 30.0),
                                        child: CupertinoActivityIndicator(
                                          radius: 20,
                                        ),
                                      ))
                                    : Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[],
                                            ),
                                          ),
                                          Container(
                                            height: 360.0,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 10,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  margin: EdgeInsets.all(10.0),
                                                  width: 180.0,
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    children: <Widget>[
                                                      Positioned(
                                                        bottom: 15.0,
                                                        child: Container(
                                                          height: 120.0,
                                                          width: 200.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey[850],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  RatingManga[0][index]['title']
                                                                              .length <=
                                                                          20
                                                                      ? RatingManga[0][index]
                                                                              [
                                                                              'title']
                                                                          .toString()
                                                                      : RatingManga[0][index]
                                                                              [
                                                                              'title']
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              20),
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        kPrimaryWhiteColor,
                                                                    fontSize:
                                                                        16.0,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        20.0),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          10.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            'ch ' +
                                                                                RatingManga[0][index]['last_chapter'],
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              color: kPrimaryWhiteColor,
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
                                                                      Text(
                                                                        ". " +
                                                                            Newmanga[0][index]['distanceTime'],
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
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      0.0),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black26,
                                                              blurRadius: 6.0,
                                                            ),
                                                          ],
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      00.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              _navigator(
                                                                  context,
                                                                  Chapter([
                                                                    RatingManga[
                                                                            0]
                                                                        [index]
                                                                  ]));
                                                            },
                                                            child:
                                                                CachedNetworkImage(
                                                                    height: 250,
                                                                    width: 180,
                                                                    imageUrl: RatingManga[0][index]
                                                                            [
                                                                            'md_covers'][0]
                                                                        [
                                                                        'gpurl'],
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
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                )),
            bottomNavigationBar: ApiSetting[0]['value'] == 1
                ? Container(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * .034),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          setState(
                            () {
                              currentIndex = index;
                              print(currentIndex);
                              if (currentIndex == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Setting()),
                                );
                              } else if (currentIndex == 2) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Account()),
                                );
                              } else if (currentIndex == 3) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Library()),
                                );
                              } else if (currentIndex == 4) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LeaderBoardScreen()),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
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
                  )
                : SizedBox(),
          );
  }

//store the userImage in local
  void _getUserDetails() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString("token")!;
    print("homepagetoken" + token);
    var data = {"pic": token};
  }

//get manga details from api
  void _apiMangaDetails() async {
    try {
      //Setting API
      ApiSetting.clear();
      var resSetting = await CallApi().getApiSetting('getApiSetting');
      var bodyRoutesSetting = json.decode(resSetting.body);
      ApiSetting.add(bodyRoutesSetting);
      //  ApiSetting[0]['value'] = 0;
      print(ApiSetting[0]['value']);

      //get user details
      User.clear();
      var resUser = await CallApi().getUserById('getUserById');
      var bodyUser = json.decode(resUser.body);
      print(bodyUser);
      User.add(bodyUser);

      //Hot Manga API
      manga.clear();
      var res = await CallApi().getMangas('');
      var bodyRoutes = json.decode(res.body);
      manga.add(bodyRoutes);

      //new Manga API
      Newmanga.clear();
      var resNew = await CallApi().getNewMangas('');
      var bodyRoutesNew = json.decode(resNew.body);
      Newmanga.add(bodyRoutesNew);

      //View Manga API
      ViewManga.clear();
      var resView = await CallApi().getViewMangas('');
      var bodyRoutesView = json.decode(resView.body);
      ViewManga.add(bodyRoutesView);

      //Rating Manga API
      RatingManga.clear();
      var resRating = await CallApi().getRatingMangas('');
      var bodyRoutesRating = json.decode(resRating.body);
      RatingManga.add(bodyRoutesRating);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }
}

void _navigator(BuildContext context, add) async {
  final result = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => add));
}
