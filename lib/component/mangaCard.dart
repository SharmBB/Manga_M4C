import 'package:flutter/material.dart';
import 'package:mangakiku_app/views/Library/library.dart';

class CustomProductCard extends StatelessWidget {
  final int valueKey;
  final String title;
  final String subtitle;

  CustomProductCard(
      {Key? key,
      required this.valueKey,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.black,
        child: ListTile(
          onTap: (){
            // Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Library()),
            //     );
          },
          leading: Image.asset(
            "assets/banner-image.png",
            fit: BoxFit.cover,
            width: 100,
      
            alignment: Alignment.center,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          key: ValueKey(valueKey),
          title: Text(title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
          subtitle: Text(subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              )),
              
        ));
  }
}
