import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/api/api.dart';
import 'package:mangakiku_app/views/chapter/chapter.dart';
import 'package:mangakiku_app/views/type/searchType.dart';
import 'package:mangakiku_app/views/type/sliderType.dart';

class Manga_List extends StatefulWidget {
  Manga_List({
    Key? key,
  }) : super(key: key);

  @override
  _ViewRoutesState createState() => _ViewRoutesState();
}

class _ViewRoutesState extends State<Manga_List> {
// loader
  bool _isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List search = [];

  var title;
  var color;

  @override
  initState() {
    _apiSearchDetailss();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        //  backgroundColor: Colors.grey[200],
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, color: kPrimaryWhiteColor),
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
          ),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              // ignore: deprecated_member_use
              overscroll.disallowGlow();
              return false;
            },
            child: Stack(children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, right: 30, left: 30),
                    child: Form(
                      key: _formKey,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          suffixIcon: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: kPrimaryPurpleColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0))),
                              child: IconButton(
                                onPressed: () async {
                                  _apiSearchDetailss();
                                  _controller.clear();
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: kPrimaryWhiteColor,
                                  size: 30,
                                ),
                              )),
                          border: InputBorder.none,
                          fillColor: kPrimaryWhiteColor,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              color: kPrimaryPurpleColor,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                            borderSide: BorderSide(
                              color: kPrimaryPurpleColor,
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(15.0),
                          filled: true,
                        //  hintText: "Search ........",
                          hintStyle: TextStyle(
                              fontSize: 16.0, color: kPrimaryPurpleColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  _isLoading
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: CupertinoActivityIndicator(
                            radius: 20,
                          ),
                        ))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: search[0].length,
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
                                        margin:
                                            EdgeInsets.only(right: 15, top: 10,left:15),
                                        child: InkWell(
                                          onTap: () {
                                            print("shar");
                                            _navigator(
                                                context,
                                                SearchDetailsScreen(
                                                    [search[0][index]]
                                                    ));
                                          },
                                          child: CachedNetworkImage(
                                              imageUrl: search[0][index]
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
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0),
                                            child: Text(
                                              search[0][index]['title']
                                                          .length <=
                                                      20
                                                  ? search[0][index]['title']
                                                      .toString()
                                                  : search[0][index]['title']
                                                      .toString()
                                                      .substring(0, 20),
                                              style: TextStyle(
                                                  color: kPrimaryWhiteColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          //     SizedBox(
                                          //       height: 6,
                                          //     ),
                                          //     Column(
                                          //       crossAxisAlignment:
                                          //           CrossAxisAlignment.start,
                                          //       children: <Widget>[
                                          //         Text(
                                          //            search[0][index]['title'],
                                          //           style: TextStyle(
                                          //               color: kPrimaryWhiteColor,
                                          //               fontWeight: FontWeight.bold,
                                          //               fontSize: 12),
                                          //         ),
                                          //         SizedBox(
                                          //           height: 6,
                                          //         ),
                                          //         Row(
                                          //           children: <Widget>[
                                          //             Icon(
                                          //               Icons.star,
                                          //               color: Colors.yellow,
                                          //               size: 12,
                                          //             ),
                                          //             SizedBox(
                                          //               width: 5,
                                          //             ),
                                          //             Text("cac",
                                          //                 //  search[0][index]
                                          //                 //      ['rating'],
                                          //                 style: TextStyle(
                                          //                     color:
                                          //                         kPrimaryGreyColor,
                                          //                     fontSize: 13,
                                          //                     letterSpacing: .3)),
                                          //             // SizedBox(
                                          //             //   width: 5,
                                          //             // ),
                                          //             // Text(". Action",
                                          //             //     style: TextStyle(
                                          //             //         color:
                                          //             //             kPrimaryGreyColor,
                                          //             //         fontSize: 13,
                                          //             //         letterSpacing: .3)),
                                          //             // SizedBox(
                                          //             //   width: 5,
                                          //             // ),
                                          //             // Text(". ch",
                                          //             //     style: TextStyle(
                                          //             //         color:
                                          //             //             kPrimaryGreyColor,
                                          //             //         fontSize: 13,
                                          //             //         letterSpacing: .3)),
                                          //           ],
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ],
                                          // ),
                                        ]))
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ])));
  }

  //get manga details from api
  void _apiSearchDetailss() async {
    try {
      //Hot Manga API
      search.clear();
      var res = await CallApi().getSearch(_controller.text);
      print(_controller);
      var bodyRoutes = json.decode(res.body);
      search.add(bodyRoutes);
      print(search);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void _navigator(BuildContext context, add) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => add));
  }
}
