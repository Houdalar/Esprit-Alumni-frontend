import 'dart:convert';

import 'package:esprit_alumni_frontend/bindings/app_bindings.dart';
import 'package:esprit_alumni_frontend/socketService.dart';
import 'package:esprit_alumni_frontend/view/screens/Profile/splash_screen.dart';
import 'package:esprit_alumni_frontend/view/screens/login.dart';
import 'package:esprit_alumni_frontend/view/screens/signup1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // Initialiser la configuration des notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
    final payload = response.payload;
    if (payload != null) {
      final data = json.decode(payload);
      final message = data["message"];
      final sourceId = data["sourceId"];
      final targetId = data["targetId"];
    }
  });
  final socketService = SocketService();
  //socketService.initSocket('your_user_token');

  runApp(MyApp(socketService: socketService));
}

class MyApp extends StatelessWidget {
  final SocketService socketService;

  const MyApp({Key? key, required this.socketService}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
