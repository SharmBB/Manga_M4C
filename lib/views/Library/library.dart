import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/component/libraryImage.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("My Library"),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          DefaultTabController(
              length: 3, // length of tabs
              initialIndex: 0,
              child: Column(children: <Widget>[
                Container(
                  child: TabBar(
                    labelColor: Colors.purple[900],
                    unselectedLabelColor: Colors.white,
                    tabs: [
                      Tab(
                        text: 'Library',
                      ),
                      Tab(text: 'History'),
                      Tab(text: 'Updates'),
                    ],
                  ),
                ),
                Container(
                  height: screenHeight, //height of TabBarView
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.purple, width: 0.5))),
                  child: TabBarView(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTabController(
                          length: 2, // length of tabs
                          initialIndex: 0,
                          child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                Container(
                                  height: 30,
                                  child: TabBar(
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0)),
                                        color: Colors.purple[900]),
                                   // labelColor: Colors.purple[900],
                                   
                                    unselectedLabelColor: Colors.grey,
                                    tabs: [
                                      Tab(
                                        text: 'My Library',
                                      ),
                                      Tab(text: 'Favourites'),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: screenHeight, //height of TabBarView
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Colors.purple, width: 0.5))),
                                  child: TabBarView(children: <Widget>[
                                    CharacterPage(),
                                    Center(
                                        child: Text(
                                      "Favourites",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    )),
                                  ]),
                                )
                              ]))),
                    ),
                    Center(
                        child: Text(
                      "History",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                    Center(
                        child: Text(
                      "Updates",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                  ]),
                )
              ]))
        ])));
  }
}

class CharacterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: const EdgeInsets.only(top: 10, right: 5, ),
          child: Column(children: [
            Padding(
                padding: EdgeInsets.only(left: 1),
                child: Container(
                    //  width: screenWidth,
                    height: screenHeight * (0.8 / 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: new BorderRadius.circular(2.0),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 5, right: 5, top: 5, bottom: 5),
                        child: TextFormField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search Title",
                              hintStyle:
                                  TextStyle(fontSize: 12.0, color: Colors.grey),
                            ))))),
            SizedBox(height: 20.0),
            LibraryImage(),
            // SizedBox(height: 20.0),
            // LibraryImage(),
            // SizedBox(height: 20.0),
            // LibraryImage(),
            // SizedBox(height: 20.0),
            // LibraryImage(),
            // SizedBox(height: 20.0),
            // LibraryImage(),
          ]))
    ]));
  }
}
