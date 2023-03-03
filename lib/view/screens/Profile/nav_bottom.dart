import 'package:flutter/material.dart';

import 'profile.dart';
import 'dashboard.dart';
import 'home.dart';
import 'notifications.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({Key? key}) : super(key: key);

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  int _currentIndex = 0;
  final List<Widget> _interfaces = const [Home(), Dashboard(), Notifications(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _interfaces[_currentIndex],
      ///////// BottomNavigationBar  /////////////
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.red),
              label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics, color: Colors.red),
              label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.red),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.red),
            label: "Profile",
          )
        ],
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });    // clic kif tabbar normalement
        },
      ),
    );
  }
}