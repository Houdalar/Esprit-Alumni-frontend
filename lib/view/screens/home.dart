// statefull widget for the home page
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

// the home page state
class _HomePageState extends State<HomePage> {
  // the home page state
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Ythis is the home page',
            )
          ],
        ),
      ),
    );
  }
}
