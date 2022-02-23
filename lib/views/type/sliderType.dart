import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';

import 'package:mangakiku_app/views/Comments/chapterImage.dart';
import 'package:mangakiku_app/views/Comments/comments.dart';
import 'package:mangakiku_app/views/Comments/sliderChapterImage.dart';

import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlideDetailsScreen extends StatefulWidget {
  late final List _manga;

  SlideDetailsScreen(this._manga);

  @override
  _CartState createState() => _CartState(this._manga);
}

class _CartState extends State<SlideDetailsScreen> {
  _CartState(this._manga);

  List _manga;

  String dropdownValue = 'English';

  //list for api
  List chapterUsingName = [];
  List chapterUsingID = [];
  List chaptersFromDB = [];

  @override
  void initState() {
    _ChapterDetailsUsingName();
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
        body: _isLoading
            ? Center(
                child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: CupertinoActivityIndicator(
                  radius: 20,
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
                        imageUrl: (_manga[0]['md_comics']['md_covers'][0]
                            ['gpurl']),
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
                            _manga[0]['md_comics']['title'].length <= 40
                                ? _manga[0]['md_comics']['title'].toString()
                                : _manga[0]['md_comics']['title']
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SlideMangaComment2(
                                          hid: chaptersFromDB[0]['hid']
                                              .toString(),
                                          chapterid: chaptersFromDB[0]["chap"]
                                              .toString(),
                                        ),
                                      ),
                                    );
                                    print("dsvdsv");
                                  },
                                ),
                                SizedBox(width: 10.0),
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: FloatingActionButton.small(
                                    backgroundColor: Colors.grey[300],
                                    onPressed: () {
                                      addLibrary();
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => MangaComments(),
                                      //   ),
                                      // );
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
                                    onPressed: () {
                                      addFavourite();
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
                                      padding: const EdgeInsets.only(top: 30.0),
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
                                                      color: Colors.blue),
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
                                                      color: Colors.blue),
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
                                                      color: Colors.blue),
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
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Padding(
                                    //     padding: const EdgeInsets.only(
                                    //         top: 10.0, left: 10),
                                    //     child: Container(
                                    //         width: 100,
                                    //         height: 25,
                                    //         decoration: BoxDecoration(
                                    //             color: Colors.grey[900],
                                    //             borderRadius:
                                    //                 BorderRadius.circular(1)),
                                    //         child: Padding(
                                    //           padding:
                                    //               const EdgeInsets.fromLTRB(
                                    //                   10, 0, 0, 0),
                                    //           child: DropdownButton<String>(
                                    //             underline:
                                    //                 DropdownButtonHideUnderline(
                                    //                     child: Container()),
                                    //             value: dropdownValue,
                                    //             dropdownColor:
                                    //                 kPrimaryPurpleColor,
                                    //             icon: Icon(
                                    //                 Icons.keyboard_arrow_down),
                                    //             elevation: 16,
                                    //             style: TextStyle(
                                    //                 color: kPrimaryWhiteColor),
                                    //             onChanged: (String? newValue) {
                                    //               setState(() {
                                    //                 dropdownValue = newValue!;
                                    //               });
                                    //             },
                                    //             items: <String>[
                                    //               'English',
                                    //               'French  ',
                                    //             ].map<DropdownMenuItem<String>>(
                                    //                 (String value) {
                                    //               return DropdownMenuItem<
                                    //                   String>(
                                    //                 value: value,
                                    //                 child: Text(value,
                                    //                     style: TextStyle(
                                    //                         color:
                                    //                             kPrimaryGreyColor)),
                                    //               );
                                    //             }).toList(),
                                    //           ),
                                    //         ))),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 60, right: 80),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                    Expanded(
                                      child: Container(
                                        child: ListView.builder(
                                          itemCount: chaptersFromDB.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              child: ListTile(
                                                  //return new ListTile(
                                                  onTap: null,
                                                  subtitle: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 60.0,
                                                            left: 60),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          InkWell(
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          SlideMangaComment2(
                                                                    hid: chaptersFromDB[index]
                                                                            [
                                                                            'hid']
                                                                        .toString(),
                                                                    chapterid: chaptersFromDB[index]
                                                                            [
                                                                            "chap"]
                                                                        .toString(),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8),
                                                              child: Text(
                                                                chaptersFromDB[
                                                                            index]
                                                                        ["chap"]
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          // Text(
                                                          //   chaptersFromDB[index]["chap"]
                                                          //       .toString(),
                                                          //   style: TextStyle(
                                                          //       fontSize: 13,
                                                          //       color: Colors.white),
                                                          // ),
                                                          // InkWell(
                                                          //   onTap: () {
                                                          //     Navigator.push(
                                                          //       context,
                                                          //       MaterialPageRoute(
                                                          //         builder:
                                                          //             (context) =>
                                                          //                 SlideMangaComment2(
                                                          //           hid: chaptersFromDB[index]
                                                          //                   [
                                                          //                   'hid']
                                                          //               .toString(),
                                                          //           chapterid: chaptersFromDB[index]
                                                          //                   [
                                                          //                   "chap"]
                                                          //               .toString(),
                                                          //         ),
                                                          //       ),
                                                          //     );
                                                          //   },
                                                          //   child: Text(
                                                          //     chaptersFromDB[index]
                                                          //                 [
                                                          //                 "up_count"]
                                                          //             .toString() +
                                                          //         "days",
                                                          //     style: TextStyle(
                                                          //         fontSize: 13,
                                                          //         color: Colors
                                                          //             .white),
                                                          //   ),
                                                          //   // Text(
                                                          //   //   chaptersFromDB[
                                                          //   //               index]
                                                          //   //           ["lang"]
                                                          //   //       .toString(),
                                                          //   //   style: TextStyle(
                                                          //   //       fontSize: 13,
                                                          //   //       color: Colors
                                                          //   //           .white),
                                                          //   // ),
                                                          // )
                                                        ]),
                                                  )),
                                            );
                                          }, //itemBuilder
                                        ),
                                      ),
                                    ),
                                  ])
                            ]),

                            // Center( child: Text("Three",style: TextStyle(fontSize: 50),))
                          )
                        ]))
              ])));
  }

  //get chapter details using name from api
  // ignore: non_constant_identifier_names
  void _ChapterDetailsUsingName() async {
    try {
      chapterUsingName.clear();
      var bodyRoutes;
      var res =
          await CallApi().getChapterUsingName(_manga[0]['md_comics']['slug']);
      bodyRoutes = json.decode(res.body);
      chapterUsingName.add(bodyRoutes);
      print(chapterUsingName[0]['comic']);
      int id = chapterUsingName[0]['comic']['id'];
      print(id);
      print(chapterUsingName);

      chapterUsingID.clear();
      var bodyRoutesChap;
      var resCHap = await CallApi().getChapterUsingID('$id/chapter');
      bodyRoutesChap = json.decode(resCHap.body);

      chaptersFromDB = bodyRoutesChap['chapters'];

      print("---------chapters-------------");

      print(chaptersFromDB);

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
        "title": _manga[0]['md_comics']['title'].toString(),
        "image": _manga[0]['md_comics']['md_covers'][0]['gpurl'].toString(),
        "rating": "9.45",
      };
      var res = await CallApi().postData(data, 'addLibrary');
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
        "title": _manga[0]['md_comics']['title'].toString(),
        "image": _manga[0]['md_comics']['md_covers'][0]['gpurl'].toString(),
        "rating": "9.45",
      };
      var res = await CallApi().postData(data, 'addFavourite');
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
    setState(() {
      _isLoading = false;
    });
  }
}

class CharacterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 140,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        // gradient: LinearGradient(colors: [secondary, primary]),
                        borderRadius: BorderRadius.circular(1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Select Language",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      DataTable(
        border: TableBorder(
          horizontalInside: BorderSide(color: Colors.white),
        ),
        columns: [
          DataColumn(
            label: Container(
              width: 120,
              height: 25,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  // gradient: LinearGradient(colors: [secondary, primary]),
                  borderRadius: BorderRadius.circular(1)),
              child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 5),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Select Chapter",
                        hintStyle:
                            TextStyle(fontSize: 12.0, color: Colors.white),
                        border: InputBorder.none,
                        fillColor: Colors.grey,
                        focusColor: Colors.grey),
                  )),
            ),
          ),
          DataColumn(
              label: Text(
            'Date',
            style: TextStyle(fontSize: 14, color: Colors.white),
          )),
          DataColumn(
              label: Text(
            'Language',
            style: TextStyle(fontSize: 14, color: Colors.white),
          )),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text(
              'CH 12',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Text(
              '2 days ',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Icon(
              Icons.flag_rounded,
              color: Colors.red,
            )),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'CH 12',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Text(
              '2 days ',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Icon(
              Icons.flag_rounded,
              color: Colors.red,
            )),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'CH 12',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Text(
              '2 days ',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Icon(
              Icons.flag_rounded,
              color: Colors.red,
            )),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'CH 12',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Text(
              '2 days ',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Icon(
              Icons.flag_rounded,
              color: Colors.red,
            )),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'CH 12',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Text(
              '2 days ',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Icon(
              Icons.flag_rounded,
              color: Colors.red,
            )),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'CH 12',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Text(
              '2 days ',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Icon(
              Icons.flag_rounded,
              color: Colors.red,
            )),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'CH 12',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Text(
              '2 days ',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Icon(
              Icons.flag_rounded,
              color: Colors.red,
            )),
          ]),
          DataRow(cells: [
            DataCell(Text(
              'CH 12',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Text(
              '2 days ',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            DataCell(Icon(
              Icons.flag_rounded,
              color: Colors.red,
            )),
          ]),
        ],
      ),
    ]));
  }
}
