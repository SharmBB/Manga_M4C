import 'package:flutter/material.dart';

class Shar extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Shar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
          actions: [
            IconButton(icon: Icon(Icons.add_circle), onPressed: () {}),
          ],
        ),
        //body:
        body: Column(children: [
          Row(children: [
           
            Expanded(
                child: Text('First Name',
                    style: TextStyle(
                      height: 3.0,
                      fontSize: 15.2,
                      fontWeight: FontWeight.bold,
                    ))),
            Expanded(
                child: Text('Last Name',
                    style: TextStyle(
                      height: 3.0,
                      fontSize: 15.2,
                      fontWeight: FontWeight.bold,
                    ))),
            Expanded(
                child: Text('City',
                    style: TextStyle(
                      height: 3.0,
                      fontSize: 15.2,
                      fontWeight: FontWeight.bold,
                    ))),
      
          
          ]),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => APIDetailView(data[index])),
                    //   );
                    // },

                    child: ListTile(
                        //return new ListTile(
                        onTap: null,
                        // leading: CircleAvatar(
                        //   backgroundColor: Colors.blue,
                        //   child: Text("FirstName"),
                        // ),
                        title: Row(children: <Widget>[
                          Expanded(child: Text("FirstName")),
                          Expanded(child: Text("FirstName")),
                          Expanded(child: Text("FirstName")),
                       
                        ])),
                  );
                }, //itemBuilder
              ),
            ),
          ),
        ]));
  }
}
