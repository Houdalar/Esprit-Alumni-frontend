import 'package:flutter/material.dart';

import 'profile.dart';
import 'dashboard.dart';
import 'home.dart';
import 'package:esprit_alumni_frontend/model/profile.dart';
import 'package:esprit_alumni_frontend/viewmodel/profileViewModel.dart';

import 'notifications.dart';

final token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MDVlMjE4OWI3MTgzODNiYTZlMWJiZiIsImlhdCI6MTY3ODEwNzIyMn0._PZVkfoErOlRj8G5RqSe3nAkh1YkJBHev8drD_8aI5A";

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({Key? key}) : super(key: key);

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  int _currentIndex = 0;
  List<Widget> _interfaces = const [];

  @override
  void initState() {
    super.initState();
    _interfaces = [
      Home(),
      Dashboard(),
      Notifications(),
      Profile(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _interfaces[_currentIndex],
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
          });
        },
      ),
    );
  }
}
