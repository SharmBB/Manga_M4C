
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';

class Add extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<Add> {
  List<String> images = ['images/img1.jpg','images/img2.jpg','images/img3.jpeg','images/img4.jpg','images/img5.jpg'];
  List<Object>? dataads;
  @override
  void initState() {
    super.initState();
    setState(() {
      dataads = List.from(images);
      for(int i = 0;i<2;i++){
        var min = 1;
        var rm = new Random();
        //generate a random number from 2 to 4 (+ 1)
        var rannumpos = min + rm.nextInt(4);
        //and add the banner ad to particular index of arraylist
        dataads?.insert(rannumpos, nativeAdWidget());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: dataads?.length,itemBuilder: (context,index){
                if(dataads![index] is String)
                  {
                    return  Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/profile-img.png")
                  );
                  }else{
                  return  Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: dataads![index] as nativeAdWidget
                  );
                }
          }),
        )
    );
  }
}
class nativeAdWidget extends StatelessWidget {
  final _controller = NativeAdmobController();
  @override
  Widget build(BuildContext context) {
    return NativeAdmob(
      adUnitID: "ca-app-pub-8404562337274385~8791933088",
      loading: Center(child: CircularProgressIndicator()),
      error: Text("Failed to load the ad"),
      controller: _controller,
      type: NativeAdmobType.full,
      options: NativeAdmobOptions(
        ratingColor: Colors.red,
        showMediaContent: true,
        callToActionStyle: NativeTextStyle(
            color: Colors.red,
            backgroundColor: Colors.black
        ),
        headlineTextStyle: NativeTextStyle(
          color: Colors.blue,
        ),
        // Others ...
      ),
    );
  }
}