import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MangaComment2 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MangaComment2> {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/notification_icon');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android: android, iOS: iOS);

    // flutterLocalNotificationsPlugin!.initialize(initSetttings,
    //     onSelectNotification: onSelectNotification);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin?.initialize(initSetttings);
  }

  // Future onSelectNotification(String payload) {
  //   debugPrint("payload : $payload");
  //   showDialog(
  //     context: context,
  //     builder: (_) => new AlertDialog(
  //       title: new Text('Notification'),
  //       content: new Text('$payload'),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new FloatingActionButton(
          onPressed: showNotification,
          // child: new Text(
          //   'Tap To Get a Notification',
          //   style: Theme.of(context).textTheme.headline1,
          // ),
        ),
      ),
    );
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
      'channel id',
      'channel NAME',
      priority: Priority.high,
      importance: Importance.max,
      playSound: true,
     // timeoutAfter: 5000,
      enableLights: true,
      color: const Color.fromARGB(255, 255, 255, 0),
      ledColor: const Color.fromARGB(255, 255, 255, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin?.show(
        0, 'Mangakiku', 'Local Push Notification', platform,
        payload: 'AndroidCoding.in');
  }
}
