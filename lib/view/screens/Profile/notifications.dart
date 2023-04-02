import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.red,
      systemNavigationBarColor: Colors.white,
    ));
    return MaterialApp(
      title: 'Notificationsssssssssssss',
    );
  }
}
