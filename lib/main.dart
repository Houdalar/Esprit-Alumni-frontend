import 'package:esprit_alumni_frontend/view/screens/home.dart';
import 'package:esprit_alumni_frontend/view/screens/login.dart';
//import 'package:esprit_alumni_frontend/view/screens/rsetpassword1.dart';
//import 'package:esprit_alumni_frontend/view/screens/rsetpassword2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//import 'package:esprit_alumni_frontend/view/screens/login.dart';
import 'package:esprit_alumni_frontend/view/screens/signup1.dart';
//import 'package:esprit_alumni_frontend/view/screens/getstarted.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        //  '/signup2': (context) => Signup2Page(),
        '/signup1': (context) => const SignupPage(),
        //'/getstarted': (context) => GetStarted(),
        //'/rsetpassword1': (context) => Rsetpassword1(),
        //'/rsetpassword2': (context) => Rsetpassword2(),
      },
    );
  }
}
