import 'package:esprit_alumni_frontend/view/screens/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../socketService.dart';
import 'dashboard.dart';
import 'home.dart';
import 'package:esprit_alumni_frontend/viewmodel/profileViewModel.dart';
import 'notifications.dart';

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
  final SocketService socketService = SocketService();

  final GlobalKey<NotificationsState> notificationsKey =
      GlobalKey<NotificationsState>();

  int _notificationCount = 0;
  int _currentIndex = 0;
  List<Widget> _interfaces = const [];
  late AnimationController _controller;
  late Animation<double>? _animation;
  String? token;
  late SharedPreferences _prefs;
  bool _isInitialized = false;

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      token = _prefs.getString('userId') ?? "";
    });
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    socketService.initSocket(decodedToken["id"].toString());
    socketService.connect(decodedToken["id"].toString());

    // Set the _interfaces list
    _interfaces = [
      HomePage(widget.username, widget.profilePic, widget.id),
      const Dashboard(),
      Notifications(
        token: token!,
        updateCount: _getNonReadNotificationsCount,
        onNewNotification: (notification) {
          notificationsKey.currentState?.newNotification(notification);
        },
        key: notificationsKey,
      ),
      const Profile(
        isCurrentUser: true,
      ),
    ];
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializePrefs().then((_) {
      _getNonReadNotificationsCount();

      _controller = AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      );
      _animation = Tween<double>(begin: 1, end: 1.3).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );

      socketService.listenForNotifications(
        onNewNotification: (notification) {
          notificationsKey.currentState?.newNotification(notification);
          if (mounted) {
            setState(() {
              _notificationCount += 1;
            });
          }
        },
        updateCount: _getNonReadNotificationsCount,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    socketService.disconnect();
    super.dispose();
  }

  void _getNonReadNotificationsCount() async {
    int count = await ProfileViewModel.getNonReadNotificationsCount(token!);
    if (mounted) {
      setState(() {
        _notificationCount = count;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _controller.reset();
      _controller.forward();
    });
  }

  Widget _buildIconWithBadge(IconData iconData, int count) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        if (count > 0) {
          return Stack(
            children: [
              Icon(iconData),
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isInitialized
          ? _interfaces[_currentIndex]
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: _isInitialized
          ? BottomAppBar(
              shape: const CircularNotchedRectangle(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          color:
                              _currentIndex == index ? Colors.red : Colors.grey,
                          onPressed: () => _onItemTapped(index),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            )
          : null,
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
