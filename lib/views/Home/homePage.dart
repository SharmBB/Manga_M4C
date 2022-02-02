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
import 'package:mangakiku_app/component/accountCard.dart';
import 'package:mangakiku_app/component/bottomNavigationBar.dart';
import 'package:mangakiku_app/views/Account/account.dart';
import 'package:mangakiku_app/views/Browser/browser.dart';
import 'package:mangakiku_app/views/LeaderBoard/leaderboard.dart';
import 'package:mangakiku_app/views/Library/library.dart';
import 'package:mangakiku_app/views/chapter/chapter.dart';
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
  Icons.description_outlined,
  Icons.settings_rounded,
  Icons.notification_important_outlined,
  Icons.collections_bookmark_outlined,
];

class _HomePageState extends State<HomePage> {
//list for api
  List manga = [];
  List Newmanga = [];
  List ViewManga = [];
  List RatingManga = [];

  String image = "";
  String bio = "";
  String name = "";

  int? usernameId;

// loader
  bool _isLoading = true;

  @override
  initState() {
    _apiMangaDetails();
    _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var image_manga = "https://cdn.statically.io/img/meo.comick.pictures/";
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(
              "assets/profile-img.png",
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.description_outlined, color: kPrimaryWhiteColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Account()),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10, bottom: 10),
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
                    MaterialPageRoute(builder: (context) => Browser()),
                  );
                },
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 12.0),
        child: _isLoading
            ? Center(
                child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: CupertinoActivityIndicator(),
              ))
            : ListView(
                children: [
                  CarouselSlider(
                    items: [
                      //1st Image of Slider
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              manga[0][9]['md_comics']['md_covers'][0]['gpurl'],
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      //2nd Image of Slider
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              manga[0][4]['md_comics']['md_covers'][0]['gpurl'],
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      //3rd Image of Slider
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              Newmanga[0][12]['md_comics']['md_covers'][0]
                                  ['gpurl'],
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      //4th Image of Slider
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              ViewManga[0][8]['md_covers'][0]['gpurl'],
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      //5th Image of Slider
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              manga[0][10]['md_comics']['md_covers'][0]
                                  ['gpurl'],
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],

                    //Slider Container properties
                    options: CarouselOptions(
                      height: 180.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 1000),
                      viewportFraction: 0.8,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    builder: (context) => Browser(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  " More >",
                                  style: TextStyle(
                                    color: kPrimaryGreyColor,
                                    fontSize: 12,
                                  ),
                                ),
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
                          padding: const EdgeInsets.only(top: 30.0),
                          child: CupertinoActivityIndicator(
                            radius: 20,
                          ),
                        ))
                      : Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[],
                              ),
                            ),
                            Container(
                              height: 300.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: manga[0].length,
                                itemBuilder: (BuildContext context, int index) {
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
                                                  BorderRadius.circular(0.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    manga[0][index]['md_comics']
                                                                    ['title']
                                                                .length <=
                                                            20
                                                        ? manga[0][index][
                                                                    'md_comics']
                                                                ['title']
                                                            .toString()
                                                        : manga[0][index][
                                                                    'md_comics']
                                                                ['title']
                                                            .toString()
                                                            .substring(0, 20),
                                                    style: TextStyle(
                                                      color: kPrimaryWhiteColor,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  SizedBox(height: 20.0),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                              'ch' +
                                                                  manga[0][
                                                                          index]
                                                                      ['chap'],
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    kPrimaryWhiteColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(width: 55),
                                                        Text(
                                                          ".",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                kPrimaryWhiteColor,
                                                          ),
                                                        ),
                                                        SizedBox(width: 25),
                                                        Text(
                                                          manga[0][index]
                                                              ['distanceTime'],
                                                          style: TextStyle(
                                                            fontSize: 12,
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
                                                  BorderRadius.circular(0.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 6.0,
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(00.0),
                                              child: InkWell(
                                                onTap: () {
                                                  print(manga[0][index]);
                                                  _navigator(
                                                      context,
                                                      DetailsScreen(
                                                          [manga[0][index]]));
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(00.0),
                                                child: CachedNetworkImage(
                                                    height: 170,
                                                    width: 180,
                                                    imageUrl: manga[0][index]
                                                                ['md_comics']
                                                            ['md_covers'][0]
                                                        ['gpurl'],
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
                          ],
                        ),

                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    builder: (context) => Browser(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  " More >",
                                  style: TextStyle(
                                    color: kPrimaryGreyColor,
                                    fontSize: 12,
                                  ),
                                ),
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
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[],
                        ),
                      ),
                      Container(
                        height: 300.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Newmanga[0].length,
                          itemBuilder: (BuildContext context, int index) {
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
                                            BorderRadius.circular(0.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              Newmanga[0][index]['md_comics']
                                                              ['title']
                                                          .length <=
                                                      20
                                                  ? Newmanga[0][index]
                                                          ['md_comics']['title']
                                                      .toString()
                                                  : Newmanga[0][index]
                                                          ['md_comics']['title']
                                                      .toString()
                                                      .substring(0, 20),
                                              style: TextStyle(
                                                color: kPrimaryWhiteColor,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            SizedBox(height: 20.0),
                                            Padding(
                                              padding: const EdgeInsets.only(
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
                                                        'ch' +
                                                            Newmanga[0][index]
                                                                ['chap'],
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              kPrimaryWhiteColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 50),
                                                  Text(
                                                    ".",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: kPrimaryWhiteColor,
                                                    ),
                                                  ),
                                                  SizedBox(width: 25),
                                                  Text(
                                                    Newmanga[0][index]
                                                        ['distanceTime'],
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: kPrimaryWhiteColor,
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
                                            BorderRadius.circular(0.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(00.0),
                                        child: InkWell(
                                          onTap: () {
                                            print(Newmanga[0][index]);
                                            _navigator(
                                                context,
                                                DetailsScreen(
                                                    [Newmanga[0][index]]));
                                          },
                                          borderRadius:
                                              BorderRadius.circular(00.0),
                                          child: CachedNetworkImage(
                                              height: 170,
                                              width: 180,
                                              imageUrl: Newmanga[0][index]
                                                      ['md_comics']['md_covers']
                                                  [0]['gpurl'],
                                              imageBuilder: (context,
                                                      imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill),
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
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    builder: (context) => Browser(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  " More >",
                                  style: TextStyle(
                                    color: kPrimaryGreyColor,
                                    fontSize: 12,
                                  ),
                                ),
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
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[],
                        ),
                      ),
                      Container(
                        height: 300.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ViewManga[0].length,
                          itemBuilder: (BuildContext context, int index) {
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
                                            BorderRadius.circular(0.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              ViewManga[0][index]['title']
                                                          .length <=
                                                      20
                                                  ? ViewManga[0][index]['title']
                                                      .toString()
                                                  : ViewManga[0][index]['title']
                                                      .toString()
                                                      .substring(0, 20),
                                              style: TextStyle(
                                                color: kPrimaryWhiteColor,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            SizedBox(height: 20.0),
                                            Padding(
                                              padding: const EdgeInsets.only(
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
                                                        'ch' +
                                                            ViewManga[0][index][
                                                                'last_chapter'],
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              kPrimaryWhiteColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 45),
                                                  Text(
                                                    ".",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: kPrimaryWhiteColor,
                                                    ),
                                                  ),
                                                  SizedBox(width: 25),
                                                  Text(
                                                    Newmanga[0][index]
                                                        ['distanceTime'],
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: kPrimaryWhiteColor,
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
                                            BorderRadius.circular(0.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(00.0),
                                        child: InkWell(
                                          onTap: () {
                                            print(ViewManga[0][index]);
                                            _navigator(context,
                                                Chapter([ViewManga[0][index]]));
                                          },
                                          borderRadius:
                                              BorderRadius.circular(00.0),
                                          child: CachedNetworkImage(
                                              height: 170,
                                              width: 180,
                                              imageUrl: ViewManga[0][index]
                                                  ['md_covers'][0]['gpurl'],
                                              imageBuilder: (context,
                                                      imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill),
                                                    ),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error)),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    builder: (context) => Browser(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  " More >",
                                  style: TextStyle(
                                    color: kPrimaryGreyColor,
                                    fontSize: 12,
                                  ),
                                ),
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
                          padding: const EdgeInsets.only(top: 30.0),
                          child: CupertinoActivityIndicator(
                            radius: 20,
                          ),
                        ))
                      : Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[],
                              ),
                            ),
                            Container(
                              height: 300.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
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
                                                  BorderRadius.circular(0.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    RatingManga[0][index]
                                                                    ['title']
                                                                .length <=
                                                            20
                                                        ? RatingManga[0][index]
                                                                ['title']
                                                            .toString()
                                                        : RatingManga[0][index]
                                                                ['title']
                                                            .toString()
                                                            .substring(0, 20),
                                                    style: TextStyle(
                                                      color: kPrimaryWhiteColor,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  SizedBox(height: 20.0),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                              'ch' +
                                                                  RatingManga[0]
                                                                          [
                                                                          index]
                                                                      [
                                                                      'last_chapter'],
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    kPrimaryWhiteColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(width: 45),
                                                        Text(
                                                          ".",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                kPrimaryWhiteColor,
                                                          ),
                                                        ),
                                                        SizedBox(width: 25),
                                                        Text(
                                                          Newmanga[0][index]
                                                              ['distanceTime'],
                                                          style: TextStyle(
                                                            fontSize: 12,
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
                                                BorderRadius.circular(0.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 6.0,
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(00.0),
                                            child: InkWell(
                                              onTap: () {
                                                _navigator(
                                                    context,
                                                    Chapter([
                                                      RatingManga[0][index]
                                                    ]));
                                              },
                                              child: CachedNetworkImage(
                                                  height: 170,
                                                  width: 180,
                                                  imageUrl: RatingManga[0]
                                                          [index]['md_covers']
                                                      [0]['gpurl'],
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          image: DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.fill),
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
                ],
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
                      MaterialPageRoute(builder: (context) => Account()),
                    );
                  } else if (currentIndex == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Library()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LeaderBoardScreen()),
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
                    color: index == currentIndex
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

//store the userImage in local
  void _getUserDetails() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    image = localStorage.getString("image")!;
    var data = {"pic": image};
  }

//get manga details from api
  void _apiMangaDetails() async {
    try {
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
