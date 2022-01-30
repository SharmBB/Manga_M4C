import 'package:floating_navbar/floating_navbar.dart';
import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:flutter/material.dart';

import 'package:mangakiku_app/views/Home/homePage.dart';

class MainPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: FloatingNavBar(
        color: Color(0xFF111111),
        borderRadius: 50,
        horizontalPadding: 20,
        selectedIconColor: Color(0xFFFD647B),
        unselectedIconColor: Colors.grey,
        hapticFeedback: false,
        items: [
          FloatingNavBarItem(
              iconData: Icons.home, page: HomePage(), title: 'Home'),
          FloatingNavBarItem(
              iconData: Icons.calendar_today, page: HomePage(), title: 'Home'),
          FloatingNavBarItem(
              iconData: Icons.add, page: HomePage(), title: 'Home'),
          FloatingNavBarItem(
              iconData: Icons.apps_outlined, page: HomePage(), title: 'Home')
        ],
      ),
    );
  }
}
