import 'package:esprit_alumni_frontend/socketService.dart';
import 'package:esprit_alumni_frontend/view/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:esprit_alumni_frontend/view/screens/signup1.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize the SocketService
  final socketService = SocketService();
  socketService.initSocket('your_user_token');

  runApp(MyApp(socketService: socketService));
}

class MyApp extends StatelessWidget {
  final SocketService socketService;

  const MyApp({Key? key, required this.socketService}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(socketService: socketService),
      routes: {
        '/login': (context) => LoginPage(socketService: socketService),
        '/signup1': (context) => const SignupPage(),
      },
    );
  }
}
