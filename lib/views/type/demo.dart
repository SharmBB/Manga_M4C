import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  // const MyStatefulWidget({required Key key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool selected = false;

  List<String> text = [];
  TextEditingController _controller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _controller,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (_controller.text.length > 0) {
                    text.add(_controller.text);

                    _controller.clear();
                    // text.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Text is empty"),
                    ));
                  }
                });
              },
              child: Text("add"),
            ),
            Text(text.isNotEmpty ? text.toString() : ""),
          ],
        ),
      ),
    );
  }
}
