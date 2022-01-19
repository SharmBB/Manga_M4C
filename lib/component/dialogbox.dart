import 'package:flutter/material.dart';


class ReminderAlertBox extends StatelessWidget {
  const ReminderAlertBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
        backgroundColor: Colors.black,
        title: Center(
          child: Text("Report Comments ?",
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      
      actions:
      <Widget>[
        FlatButton(
          child: Padding(
            padding: const EdgeInsets.only(right:68.0),
            child: Text("Cancle",
                style: TextStyle(color: Colors.grey, fontSize: 16)),
          ),
          onPressed: () {
            //Put your code here which you want to execute on Yes button click.
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Report",
              style: TextStyle(color: Colors.purple[900], fontSize: 16)),
          onPressed: () {
            //Put your code here which you want to execute on Cancel button click.
            Navigator.of(context).pop();
          },
        ),
      ]);
  }
}