// main.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';




class aq extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<aq> {
  final List data = [
    {
      "title": "Image 1",
      "url":
          "https://cdn.pixabay.com/photo/2020/11/08/09/41/deer-5723225_960_720.jpg"
    },
    {
      "title": "Image 2",
      "url":
          "https://cdn.pixabay.com/photo/2020/11/01/19/41/autumn-5704791_960_720.jpg"
    },
    {
      "title": "Image 3",
      "url":
          "https://cdn.pixabay.com/photo/2020/04/11/14/55/houses-5030731_960_720.jpg"
    },
    {
      "title": "Image 4",
      "url":
          "https://cdn.pixabay.com/photo/2020/11/16/16/05/hoverfly-5749361_960_720.jpg"
    },
    {
      "title": "Image 5",
      "url":
          "https://cdn.pixabay.com/photo/2020/04/19/12/26/thread-5063401_960_720.jpg"
    },
    {
      "title": "Image 6",
      "url":
          "https://cdn.pixabay.com/photo/2020/11/16/22/58/mountains-5750804_960_720.jpg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kindacode.com'),
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 400),
              height: 300,
            ),
            items: data.map((item) {
              return GridTile(
                child: Image.network(item["url"], fit: BoxFit.fitWidth),
                footer: Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.black54,
                child:    Positioned(
                  bottom: 40,
                    child: Text(
                      item["title"],
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.right,
                    )),
             
               ) );
            }).toList(),
          ),
          SizedBox(height: 30),
          Text(
            'Other Content',
            style: TextStyle(
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}