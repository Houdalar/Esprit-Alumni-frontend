import 'dart:async';

import 'package:esprit_alumni_frontend/socketService.dart';
import 'package:esprit_alumni_frontend/view/screens/Profile/nav_bottom.dart';
import 'package:esprit_alumni_frontend/view/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<bool> sessionFetched;
  late String route;

  Future<bool> fetchSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("userId")) {
      route = "home";
    } else {
      route = "signin";
    }

    return true;
  }

  @override
  void initState() {
    sessionFetched = fetchSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "media/logo.png",
                width: 283,
                height: 172,
              ),
              SvgPicture.asset(
                "assets/images/Triangles.svg",
                width: 292.26,
                height: 104.2,
              )
            ],
          ),
        ));
  }

  @override
  void didChangeDependencies() async {
    SocketService? socketService;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    super.didChangeDependencies();

    sessionFetched.then((value) {
      Timer(const Duration(seconds: 2), () {
        if (route == "home") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => NavigationBottom(
                    prefs.getString("username"),
                    prefs.getString("profile_image"),
                    prefs.getString("userId"))),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginPage(socketService: socketService ?? SocketService())),
          );
          //}
        }
      });
    });
  }
}
