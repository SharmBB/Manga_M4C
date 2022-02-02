import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/component/accountCard.dart';
import 'package:mangakiku_app/component/bottomNavigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String image = "";
  String bio = "";
  String name = "";
  int? usernameId;

  @override
  initState() {
    _getUserById();
    super.initState();
  }

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
                      Text(
                        name,
                        style: TextStyle(
                            color: kPrimaryWhiteColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  <Widget>[
                              Text(
                                "User name - "+name,
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
                            children:  <Widget>[
                              Text(
                                "Bio - "+bio,
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

            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: kPrimaryPurpleColor,
                          borderRadius: BorderRadius.circular(1)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "12",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white70),
                            ),
                            Text(
                              "Hours Read",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white70),
                            ),
                          ])),
                  SizedBox(width: 5),
                  Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: kPrimaryPurpleColor,
                          borderRadius: BorderRadius.circular(1)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "12",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white70),
                            ),
                            Text(
                              "Mangas Read",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white70),
                            ),
                          ])),
                  SizedBox(width: 5),
                  Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: kPrimaryPurpleColor,
                          borderRadius: BorderRadius.circular(1)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "12",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white70),
                            ),
                            Text(
                              "Reputation",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white70),
                            ),
                          ])),
                  SizedBox(width: 5),
                  Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: kPrimaryPurpleColor,
                          borderRadius: BorderRadius.circular(1)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "12",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white70),
                            ),
                            Text(
                              "Chapter Read",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white70),
                            ),
                          ])),
                ],
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

  void _getUserById() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    print("data from sample screen");
    usernameId = localStorage.getInt('userId');
    image = localStorage.getString("image")!;
    name = localStorage.getString("name")!;
    bio = localStorage.getString("bio")!;
    var data = {"id": usernameId, "pic": image, "bio": bio, "name": name};
    print(image);
    print(usernameId);
    print(name);
    print(bio);
    // var data = {
    //   "id": image,
    // };
    // print(data);
  }
}
