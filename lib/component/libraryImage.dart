import 'package:flutter/material.dart';

class LibraryImage extends StatelessWidget {
  const LibraryImage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    image: DecorationImage(
                        image: AssetImage("assets/Image-7.png"),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Container(
            
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Solo Leveling",
                              style: TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            SizedBox(width: 5,),
                                Icon(
                              Icons.star,
                              size: 15.0,
                              color: Colors.yellow,
                            ),
                               SizedBox(width: 5,),
                              Text(
                              "9/10",
                              style: TextStyle(fontSize: 13, color: Colors.white),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: Container(
                         width: 190,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey[800],
                              // gradient: LinearGradient(colors: [secondary, primary]),
                              borderRadius: BorderRadius.circular(1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Reading",
                                style: TextStyle(fontSize: 13, color: Colors.white),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      })),
    );
  }
}
