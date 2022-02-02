import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/component/browserdata.dart';
import 'package:mangakiku_app/component/browserlist.dart';
import 'dart:convert';
import 'package:mangakiku_app/component/mangaCard.dart';

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

// loader
  bool _isLoading = true;

  @override
  initState() {
    _apiMangaDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: kPrimaryWhiteColor),
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
              color: kPrimaryWhiteColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.tune_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 10),
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
                              SizedBox(width: 20),
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
             _isLoading
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: CupertinoActivityIndicator(
                        radius: 20,
                      ),
                    )):Expanded(
              child: ListView.builder(
                  itemCount: RatingManga[0].length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: Colors.black12,
                      ),
                      height: 140,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: 130,
                              height: 140,
                              margin: EdgeInsets.only(right: 15),
                              child: CachedNetworkImage(
                                  imageUrl: RatingManga[0][index]['md_covers'][0]
                                      ['gpurl'],
                                  imageBuilder: (context, imageProvider) =>
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
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    RatingManga[0][index]['title'].length <= 20
                                        ? RatingManga[0][index]['title']
                                            .toString()
                                        : RatingManga[0][index]['title']
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
                                        RatingManga[0][index]['desc'],
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
                                              details[index]['sub-description'],
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
                                ]),
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
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
