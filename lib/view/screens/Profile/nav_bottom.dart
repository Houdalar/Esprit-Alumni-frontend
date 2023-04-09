//import 'package:esprit_alumni_frontend/view/screens/OtherUserProfile/other_profile.dart';
import 'package:esprit_alumni_frontend/view/screens/Profile/profile.dart';
import 'package:flutter/material.dart';

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
  int _currentIndex = 0;
  List<Widget> _interfaces = const [];
  late AnimationController _controller;
  late Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _interfaces = [
      HomePage(widget.username, widget.profilePic, widget.id),
      Dashboard(),
      Notifications(),
      Profile(
        isCurrentUser: true,
      ),
      //OtherProfile(),
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

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _controller.reset();
      _controller.forward();
    });
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
                return Transform.scale(
                  scale: _currentIndex == index ? _animation!.value : 1,
                  child: IconButton(
                    icon: Icon(
                      _getIconData(index),
                      color: _currentIndex == index ? Colors.red : Colors.grey,
                    ),
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
