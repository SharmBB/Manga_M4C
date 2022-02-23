import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';

import 'dart:convert';

import 'package:mangakiku_app/views/Account/account.dart';
import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:mangakiku_app/views/LeaderBoard/leaderboard.dart';
import 'package:mangakiku_app/views/Library/library.dart';
import 'package:mangakiku_app/views/Setting/setting.dart';
import 'package:mangakiku_app/views/chapter/chapter.dart';

class Browser extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Browser> {
  //list for api
  List manga = [];
  List Newmanga = [];
  List ViewManga = [];
  List RatingManga = [];

  List SelectedManga = [];

// loader
  bool _isLoading = true;

  //list Save
  List advanceSearch = [];

  List Advancesearch = [];

  String dropdownValue = 'Hot';
  @override
  initState() {
    _apiMangaDetails();
    _apiGenresDetails();
    _apiAdvanceSearch();

    SelectedManga = manga;
    super.initState();
  }

  List genres = [];

  // loader
  bool _isLoading1 = true;

  //bottom navigation purple
  int bottomPurple = 1;

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.document_scanner,
    Icons.local_library_outlined,
    Icons.leaderboard,
    Icons.settings,
  ];

  //get manga details from api
  void _apiGenresDetails() async {
    try {
      // genres.clear();
      var bodyRoutes;
      var res = await CallApi().getGenres('');
      bodyRoutes = json.decode(res.body);
      //print(bodyRoutes);
      // print(bodyRoutes.length);

      for (var i = 0; i < bodyRoutes.length; i++) {
        genres.add({
          "id": bodyRoutes[i]["id"],
          "name": bodyRoutes[i]["name"],
          "slug": bodyRoutes[i]["slug"],
          "isChecked": false
        });
      }
      print(genres[0]['name']);

      print("----------------------");

      setState(() {
        _isLoading1 = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: kPrimaryWhiteColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        leadingWidth: 70,
        centerTitle: true,
        title: const Text(
          'Browser',
          style: TextStyle(
              color: kPrimaryWhiteColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      backgroundColor: primaryColor,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          // ignore: deprecated_member_use
          overscroll.disallowGlow();
          return false;
        },
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 140,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(1)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.tune_rounded,
                                    color: kPrimaryGreyColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: 12),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.all(0),
                                      primary: Colors.white,
                                      textStyle: TextStyle(
                                          fontSize: 12,
                                          color: kPrimaryGreyColor),
                                    ),
                                    onPressed: () {
                                      _displayDialog(context);
                                    },
                                    child: Text("Advance Search",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: kPrimaryGreyColor)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 140,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(1)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: DropdownButton<String>(
                                underline: DropdownButtonHideUnderline(
                                    child: Container()),
                                value: dropdownValue,
                                dropdownColor: kPrimaryPurpleColor,
                                icon: Icon(Icons.keyboard_arrow_down),
                                elevation: 16,
                                style: TextStyle(color: kPrimaryWhiteColor),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;

                                    if (dropdownValue == 'New') {
                                      SelectedManga = Newmanga;
                                    } else if (dropdownValue ==
                                        'Recently Added') {
                                      SelectedManga = ViewManga;
                                    } else if (dropdownValue == 'Top Mangas') {
                                      SelectedManga = RatingManga;
                                    } else if (dropdownValue == 'Hot') {
                                      SelectedManga = manga;
                                    } else {
                                      SelectedManga = manga;
                                    }
                                  });
                                },
                                items: <String>[
                                  'Hot',
                                  'New',
                                  'Recently Added',
                                  'Top Mangas',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: TextStyle(
                                            color: kPrimaryGreyColor)),
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              _isLoading
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: CupertinoActivityIndicator(
                        radius: 20,
                      ),
                    ))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: SelectedManga[0].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Colors.black12,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    width: 130,
                                    height: 150,
                                    margin: EdgeInsets.only(right: 15, top: 10),
                                    child: InkWell(
                                      onTap: () {
                                        print("shar");
                                        _navigator(context,
                                            Chapter([SelectedManga[0][index]]));
                                      },
                                      child: CachedNetworkImage(
                                          imageUrl: SelectedManga[0][index]
                                              ['md_covers'][0]['gpurl'],
                                          imageBuilder: (context,
                                                  imageProvider) =>
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        SelectedManga[0][index]['title']
                                                    .length <=
                                                20
                                            ? SelectedManga[0][index]['title']
                                                .toString()
                                            : SelectedManga[0][index]['title']
                                                .toString()
                                                .substring(0, 20),
                                        style: TextStyle(
                                            color: kPrimaryWhiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            SelectedManga[0][index]['desc'],
                                            style: TextStyle(
                                                color: kPrimaryWhiteColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 12,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  SelectedManga[0][index]
                                                      ['bayesian_rating'],
                                                  style: TextStyle(
                                                      color: kPrimaryGreyColor,
                                                      fontSize: 13,
                                                      letterSpacing: .3)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(". Action",
                                                  style: TextStyle(
                                                      color: kPrimaryGreyColor,
                                                      fontSize: 13,
                                                      letterSpacing: .3)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(". ch",
                                                  style: TextStyle(
                                                      color: kPrimaryGreyColor,
                                                      fontSize: 13,
                                                      letterSpacing: .3)),
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
            ],
          ),
        ),
      ),
    );
  }

  void _navigator(BuildContext context, add) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => add));
  }

  //get manga details from api (Advance Search)
  void _apiAdvanceSearch() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String str = advanceSearch.join(',');
      print(str);
      var bodyRoutes;

      var res = await CallApi()
          .getAdvaceSearch(str.toLowerCase() + "&page=1&limit=50");
      bodyRoutes = json.decode(res.body);
      print(bodyRoutes);
      SelectedManga.clear();

      // Add subjects to _SubjectsFromDB List
      SelectedManga.add(bodyRoutes);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  //get manga details from api
  void _apiMangaDetails() async {
    try {
      //Hot Manga API
      manga.clear();
      var res = await CallApi().getBrowserhot('');
      var bodyRoutes = json.decode(res.body);
      manga.add(bodyRoutes);

      //new Manga API
      Newmanga.clear();
      var resNew = await CallApi().getBrowserNew('');
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
            return SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(20),
                color: Colors.transparent,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: Container(
                      width: screenWidth - 10,
                      height: screenHeight,
                      color: Colors.grey.shade900,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                }),
                            const Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                'Genres',
                                style: TextStyle(
                                  color: kPrimaryWhiteColor,
                                  fontSize: 20,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            Expanded(
                              child: NotificationListener<
                                  OverscrollIndicatorNotification>(
                                onNotification: (OverscrollIndicatorNotification
                                    overscroll) {
                                  // ignore: deprecated_member_use
                                  overscroll.disallowGlow();
                                  return false;
                                },
                                child: _isLoading1
                                    ? Center(
                                        child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: CupertinoActivityIndicator(),
                                      ))
                                    : GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200.0,
                                          mainAxisSpacing: 2.0,
                                          crossAxisSpacing: 2.0,
                                          childAspectRatio: 4.0,
                                        ),
                                        itemCount: genres.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Card(
                                            elevation: 0,
                                            color: Colors.grey.shade900,
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    value: genres[index]
                                                        ['isChecked'],
                                                    onChanged: (bool? val) {
                                                      setState(
                                                        () {
                                                          genres[index][
                                                                  'isChecked'] =
                                                              val;
                                                          if (genres[index][
                                                                  'isChecked'] ==
                                                              true) {
                                                            advanceSearch.add(
                                                                genres[index]
                                                                    ['name']);
                                                            //  print(advanceSearch);

                                                          } else if (genres[
                                                                      index][
                                                                  'isChecked'] ==
                                                              false) {
                                                            SelectedManga
                                                                .clear();
                                                            advanceSearch
                                                                .remove(genres[
                                                                        index]
                                                                    ['name']);

                                                            Advancesearch =
                                                                advanceSearch;
                                                          }
                                                          _apiAdvanceSearch();
                                                        },
                                                      );
                                                    },
                                                    activeColor:
                                                        kPrimaryPurpleColor,
                                                    checkColor:
                                                        kPrimaryWhiteColor,
                                                  ),
                                                  Text(
                                                    genres[index]['name']
                                                                .length <=
                                                            10
                                                        ? genres[index]['name']
                                                            .toString()
                                                        : genres[index]['name']
                                                            .toString()
                                                            .substring(0, 4),
                                                    style: const TextStyle(
                                                      color: kPrimaryWhiteColor,
                                                      decoration:
                                                          TextDecoration.none,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
