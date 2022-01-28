import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/views/Comments/comments.dart';
import 'package:mangakiku_app/views/Comments/comments2.dart';
import 'package:mangakiku_app/views/Home/homePage.dart';

class Chapter extends StatefulWidget {
  late final List _manga;

  Chapter(this._manga);

  @override
  _CartState createState() => _CartState(this._manga);
}

class _CartState extends State<Chapter> {
  _CartState(this._manga);

  List _manga;

  //list for api
  List chapterUsingName = [];
  List chapterUsingID = [];

  List chapter = [];

// loader
  bool _isLoading = true;

  @override
  void initState() {
    _ChapterDetailsUsingName();
    _apiChapterUsingID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
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
                  imageUrl: (_manga[0]['md_covers'][0]['gpurl']),
                  width: 800,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
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
                      _manga[0]['title'],
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
                          Text(_manga[0]['rating'].toString(),
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
                                  builder: (context) => MangaComment2(),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MangaComments(),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.add,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Container(
                            height: 30,
                            width: 30,
                            child: FloatingActionButton.small(
                              backgroundColor: Colors.grey[300],
                              onPressed: () {},
                              child: Icon(
                                Icons.favorite,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
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
                          Tab(text: 'Characters'),
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
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    _manga[0]['desc'],
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Text(
                                      "Organization :",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    SizedBox(width: 3.0),
                                    Text(
                                      "Manhwa",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      "Published :",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    SizedBox(width: 3.0),
                                    Text(
                                      _manga[0]["mu_comics"]['year'].toString(),
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      "Demographic :",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    SizedBox(width: 3.0),
                                    Text(
                                      "Shounen",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      "Status :",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    SizedBox(width: 3.0),
                                    Text(
                                      "Ongoing",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Text(
                                      "Artists :",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    SizedBox(width: 3.0),
                                    Text(
                                      "Akira Toriyama(Redic Studio)",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.blue),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      "Author",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    SizedBox(width: 3.0),
                                    Text(
                                      " Bird Studio/Shueisha",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.blue),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                      "Geners :",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    SizedBox(width: 3.0),
                                    Text(
                                      " television series, Adventure , Fantasy",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.blue),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Container(
                                  height: 80,

                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(1)),

                                  // ),
                                )
                              ],
                            ),
                          ),
                        ),
                        CharacterPage(),
                      ]),

                      // Center( child: Text("Three",style: TextStyle(fontSize: 50),))
                    )
                  ]))
        ])));
  }

  //get chapter details using name from api
  void _ChapterDetailsUsingName() async {
    try {
      chapterUsingName.clear();
      var bodyRoutes;
      var res = await CallApi().getChapterUsingName(_manga[0]['slug']);
      bodyRoutes = json.decode(res.body);
      chapterUsingName.add(bodyRoutes);
      print("----------------------");
      print(bodyRoutes);
      print(chapterUsingName[0]['comic']['id']);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  //get chapter details using ID from api
  void _apiChapterUsingID() async {
    try {
      chapterUsingID.clear();
      var bodyRoutes;
      var res = await CallApi()
          .getChapterUsingID(chapterUsingName[0]['comic']['id'] + '/chapter');
      bodyRoutes = json.decode(res.body);
      chapterUsingID.add(bodyRoutes);
      print(bodyRoutes);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }
}

//get all the chapter details using loop
//   addItems() {
//     for (var i = 0; i < chapterUsingName.length; i++) {
//       chapter.add({
//         "Chapter Details": chapterUsingName[i]["chap"],
//       });
//     }
//     print(chapter);
//   }
// }

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
