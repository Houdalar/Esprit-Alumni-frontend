import 'package:esprit_alumni_frontend/bindings/app_bindings.dart';
import 'package:esprit_alumni_frontend/presentation/core/web_dashboard_app.dart';
import 'package:esprit_alumni_frontend/socketService.dart';
import 'package:esprit_alumni_frontend/view/screens/Profile/splash_screen.dart';
import 'package:esprit_alumni_frontend/view/screens/login.dart';
import 'package:esprit_alumni_frontend/view/screens/signup1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class WebController extends StatefulWidget {
  @override
  State<WebController> createState() => _WebControllerState();
}

class _WebControllerState extends State<WebController> {
  final socketService = SocketService();
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      //return WebMain();
      return WebDashboardApp1();
    } else {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        //home: LoginPage(socketService: socketService),
        home: const SplashScreen(),
        initialBinding: AppBindings(),
        getPages: [
          GetPage(
              name: '/login',
              page: () {
                return LoginPage(socketService: socketService);
              }),
          GetPage(
              name: '/signup1',
              page: () {
                return const SignupPage();
              }),
        ],
      );
    }
  }
}
