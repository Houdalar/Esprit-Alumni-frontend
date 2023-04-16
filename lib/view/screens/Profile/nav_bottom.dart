//import 'package:esprit_alumni_frontend/view/screens/OtherUserProfile/other_profile.dart';
import 'package:esprit_alumni_frontend/view/screens/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'profile.dart';
//import 'dashboard.dart';
import 'dashboard.dart';
import 'home.dart';
//import 'package:esprit_alumni_frontend/model/profile.dart';
import 'package:esprit_alumni_frontend/viewmodel/profileViewModel.dart';

import 'notifications.dart';

//import 'notifications.dart';

class NavigationBottom extends StatefulWidget {
  final String? username;
  final String? profilePic;
  final String? id;
  const NavigationBottom(this.username, this.profilePic, this.id, {Key? key})
      : super(key: key);

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom>
    with SingleTickerProviderStateMixin {
  int _notificationCount = 0;
  int _currentIndex = 0;
  List<Widget> _interfaces = const [];
  late AnimationController _controller;
  late Animation<double>? _animation;
  String? token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0M2FhZWZkY2E0MzU5Yjc5ZjFhNWY4YyIsImlhdCI6MTY4MTU3NDg0NH0.AaxH0ur-AsMBYT4fEVjslgdYxn8QLpqFKanaGTTPQUI";
  late SharedPreferences _prefs;

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      token = _prefs.getString('userId') ??
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0M2FhZWZkY2E0MzU5Yjc5ZjFhNWY4YyIsImlhdCI6MTY4MTU3NDg0NH0.AaxH0ur-AsMBYT4fEVjslgdYxn8QLpqFKanaGTTPQUI";
    });
  }

  @override
  void initState() {
    super.initState();
    _initializePrefs();
    _getNonReadNotificationsCount();
    /* ProfileViewModel.getNotification(token!, context).then((value) {
      setState(() {
        _notificationCount = value.length;
      });
    });*/
    print("toekn is $token");

    _interfaces = [
      HomePage(widget.username, widget.profilePic, widget.id),
      Dashboard(),
      Notifications(token: token!, updateCount: _getNonReadNotificationsCount),
      Profile(
        isCurrentUser: true,
      ),
    ];

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _getNonReadNotificationsCount() async {
    int count = await ProfileViewModel.getNonReadNotificationsCount(token!);
    setState(() {
      _notificationCount = count;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _controller.reset();
      _controller.forward();
    });
  }

  Widget _buildIconWithBadge(IconData iconData, int count) {
    if (count > 0) {
      return Stack(
        children: [
          Icon(iconData),
          Positioned(
            right: 0,
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 15,
                minHeight: 15,
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    } else {
      return Icon(iconData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _interfaces[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AnimatedBuilder(
            animation: _animation!,
            builder: (context, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) {
                IconData iconData = _getIconData(index);
                return Transform.scale(
                  scale: _currentIndex == index ? _animation!.value : 1,
                  child: IconButton(
                    icon: _buildIconWithBadge(
                        iconData, index == 2 ? _notificationCount : 0),
                    color: _currentIndex == index ? Colors.red : Colors.grey,
                    onPressed: () => _onItemTapped(index),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconData(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.analytics;
      case 2:
        return Icons.notifications;
      case 3:
        return Icons.person;
      default:
        return Icons.home;
    }
  }
}
