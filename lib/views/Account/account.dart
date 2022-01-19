import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/component/accountCard.dart';
import 'package:mangakiku_app/component/bottomNavigationBar.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        leadingWidth: 70,
        centerTitle: true,
        title: const Text(
          'Account',
          style: TextStyle(
              color: kPrimaryWhiteColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 40.0, top: 37),
                child: CircleAvatar(
                  radius: 65,
                  backgroundImage: AssetImage(
                    "assets/profile-img.png",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 38.0, top: 25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "John Mars 😀",
                        style: TextStyle(
                            color: kPrimaryWhiteColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const <Widget>[
                              Text(
                                "User name - John234",
                                style: TextStyle(
                                    color: kPrimaryWhiteColor,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const <Widget>[
                              Text(
                                "Date Joined - 21 May 2021",
                                style: TextStyle(
                                    color: kPrimaryWhiteColor,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      )
                    ]),
              ),
            ]),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              clipBehavior: Clip.antiAlias,
              color: Colors.purple[900],
              elevation: 5.0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 22.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "12",
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Manga Reads",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: kPrimaryWhiteColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "23",
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Chapter Reads",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: kPrimaryWhiteColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "33",
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Hours read",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: kPrimaryWhiteColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "13",
                            style: TextStyle(
                              color: kPrimaryWhiteColor,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Reputution",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: kPrimaryWhiteColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Tab bar
            DefaultTabController(
              length: 2, // length of tabs
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: TabBar(
                      labelColor: kPrimaryPurpleColor,
                      unselectedLabelColor: Colors.white,
                      tabs: [
                        Tab(
                          text: 'My Librarary',
                        ),
                        Tab(text: 'Favourites'),
                      ],
                    ),
                  ),
                  Container(
                    height: 400, //height of TabBarView
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.purple, width: 0.5),
                      ),
                    ),
                    child: TabBarView(
                      children: <Widget>[
                        MangakikuCard(),
                        MangakikuCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
