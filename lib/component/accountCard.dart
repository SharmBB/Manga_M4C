import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';

class MangakikuCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            itemCount: _allUsers.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10.0),
                width: 200.0,
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
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Dragon Ball",
                                style: TextStyle(
                                  color: kPrimaryWhiteColor,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "ch3",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: kPrimaryWhiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 60),
                                    Text(
                                      ".",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: kPrimaryWhiteColor,
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                    Text(
                                      "line 23",
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
                        child: Image(
                          height: 180.0,
                          width: 200.0,
                          image: AssetImage(_allUsers[index]["image"]),
                          fit: BoxFit.cover,
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
    );
  }
}

final List<Map<String, dynamic>> _allUsers = [
  {"image": "assets/image-1.png", "title": "Dragonball"},
  {"image": "assets/image-2.png", "title": "Dragonball"},
  {"image": "assets/image-6.png", "title": "Dragonball"},
  {"image": "assets/image-4.png", "title": "Dragonball"},
  {"image": "assets/image-5.png", "title": "Dragonball"},
];
