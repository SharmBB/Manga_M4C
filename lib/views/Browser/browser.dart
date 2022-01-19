import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'dart:convert';
import 'package:mangakiku_app/component/mangaCard.dart';

class Browser extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Browser> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color:kPrimaryWhiteColor),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        leadingWidth: 70,
        centerTitle: true,
        title: const Text(
          'Browser',
          style: TextStyle(
              color: kPrimaryWhiteColor, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 140,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.tune_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width:10),
                              Text(
                                "Advance Search",
                                style: TextStyle(
                                    fontSize: 12, color: kPrimaryGreyColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "High Rating",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white70),
                              ),
                              SizedBox(width:20),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              //list
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                
                    color: Colors.black,
                    child: CustomProductCard(
                      title: "Dragon Ball",
                      subtitle:
                          "Dragon Ball is a Japanese media franchise created by Akira Toriyama in 1984. ",
                      valueKey: 2,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
