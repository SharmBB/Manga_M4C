// import 'dart:async';
// import 'dart:ui';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';


// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
//   print(message.data);
//   flutterLocalNotificationsPlugin.show(
//       message.data.hashCode,
//       message.data['title'],
//       message.data['body'],
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
          
//         ),
//       ));
// }

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//  // description
//   importance: Importance.high,
// );

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();


// class Demo1 extends StatefulWidget {

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<Demo1> {
//   final DatabaseReference _database = FirebaseDatabase().reference();
//   FirebaseMessaging? _fcm;
//   String? message;
//   String? token;

//   @override
//   void initState(){
//     super.initState();
//     var initialzationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettings =
//     InitializationSettings(android: initialzationSettingsAndroid);

//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
             
//                 icon: android.smallIcon,
//               ),
//             ));
//       }
//     });
//     getToken();



//   }
//   @override
//   Widget build(BuildContext context) {

//     return MaterialApp(
//         home: Scaffold(
//           appBar: AppBar(
//         title: Text('Notification'),
//       ),
//       body: Center(

//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'testing',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     ));
//   }
//   getToken() async {
//     token = (await FirebaseMessaging.instance.getToken())!;
//     setState(() {
//       token = token;
//     });
//     final DatabaseReference _database = FirebaseDatabase().reference();
//     _database.child('fcm-token/${token}').set({"token": token});
//   }

// }