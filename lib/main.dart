import 'package:flutter/material.dart';
import 'package:mangakiku_app/_helpers/constants.dart';
import 'package:mangakiku_app/views/Account/account.dart';
import 'package:mangakiku_app/views/Browser/browser.dart';

import 'package:mangakiku_app/views/Home/homePage.dart';
import 'package:mangakiku_app/views/LeaderBoard/leaderboard.dart';
import 'package:mangakiku_app/views/Library/demo.dart';
import 'package:mangakiku_app/views/Library/library.dart';
import 'package:mangakiku_app/views/SignIn/signin.dart';
import 'package:mangakiku_app/views/Signup/signup.dart';
import 'package:mangakiku_app/views/type/demo.dart';
import 'package:mangakiku_app/views/type/type.dart';

import 'views/ResetPassword/resetPassword.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Using "static" so that we can easily access it later
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Manga kiku',
              darkTheme: ThemeData.light(),
              themeMode: currentMode,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: HomePage());
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(body: Center(child: Text("Manga kiku"))),
    );
  }
}
