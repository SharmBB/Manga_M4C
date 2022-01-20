
import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/component/browserdata.dart';


Widget userList(BuildContext context, int index) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      color: Colors.black12,
    ),
    // width: double.infinity,
     height: 140,
   // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
   // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
              width: 130,
              height: 140,
              margin: EdgeInsets.only(right: 15),
              child: Image(image: AssetImage(details[index]['image']))),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                details[index]['name'],
                style: TextStyle(
                    color: kPrimaryWhiteColor, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 6,
              ),
             Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                details[index]['description'],
                style: TextStyle(
                    color: kPrimaryWhiteColor, fontWeight: FontWeight.bold, fontSize: 12),
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
                  Text(details[index]['sub-description'],
                      style: TextStyle(
                          color: kPrimaryGreyColor, fontSize: 13, letterSpacing: .3)),
                           SizedBox(
                    width: 5,
                  ),
                     Text(". Action",
                      style: TextStyle(
                          color: kPrimaryGreyColor, fontSize: 13, letterSpacing: .3)),
                                  SizedBox(
                    width: 5,
                  ),
                     Text(". ch",
                      style: TextStyle(
                          color: kPrimaryGreyColor, fontSize: 13, letterSpacing: .3)),
                ],
              ),
            ],
          ),
            ]),
        )],
    ),
  );
}