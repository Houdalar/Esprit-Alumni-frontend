import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  //const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        /*decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 247, 109, 107)!,
              Color.fromARGB(255, 60, 5, 5)!
            ],
          ),
        ),*/
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;
            bool isSmallScreen = screenWidth < 580;

            return Column(
              children: [
                Container(
                  height:
                      isSmallScreen ? screenHeight * 0.4 : screenHeight * 0.6,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 20.0 : 40.0,
                      vertical: isSmallScreen ? 7.0 : 14.0,
                    ),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Esprit Alumni App: Connect, Collaborate, and Elevate Your Career',
                          style: TextStyle(
                            color: Color.fromARGB(255, 109, 4, 2)!,
                            fontSize: isSmallScreen ? 20.0 : 38.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 30.0 : 70.0),
                        Text(
                          'Welcome to the Esprit Alumni App, a cutting-edge platform , exclusively designed for graduates of the Esprit School of Engineering. Our mission is to foster a strong, vibrant community that facilitates collaboration, professional networking, and career growth. Stay in the loop with the latest news, events, and opportunities while connecting with fellow alumni and accessing valuable career resources - all at your fingertips.',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: isSmallScreen ? 14.0 : 20.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 20.0 : 50.0,
                      vertical: isSmallScreen ? 8.0 : 16.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                height: isSmallScreen ? 200.0 : 300.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'Assets/images/profile.png',
                                      height: isSmallScreen ? 70.0 : 100.0,
                                    ),
                                    SizedBox(
                                        height: isSmallScreen ? 10.0 : 20.0),
                                    Text(
                                      'Profile',
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 12.0 : 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height: isSmallScreen ? 5.0 : 10.0),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Text(
                                        'Users can create and update their profile to share information about their education and experience.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: isSmallScreen ? 5.0 : 14.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: isSmallScreen ? 10.0 : 20.0),
                          Expanded(
                            child: Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                height: isSmallScreen ? 200.0 : 300.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'Assets/images/chat.png',
                                      height: isSmallScreen ? 65.0 : 100.0,
                                    ),
                                    SizedBox(
                                        height: isSmallScreen ? 10.0 : 20.0),
                                    Text(
                                      'Chat',
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 12.0 : 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height: isSmallScreen ? 5.0 : 10.0),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Text(
                                        'The app allows users to connect with other alumni in real-time through a built-in chat feature.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: isSmallScreen ? 6.0 : 14.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: isSmallScreen ? 10.0 : 20.0),
                          Expanded(
                            child: Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                height: isSmallScreen ? 200.0 : 300.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'Assets/images/computer_sc.png',
                                      height: isSmallScreen ? 65.0 : 100.0,
                                    ),
                                    SizedBox(
                                        height: isSmallScreen ? 10.0 : 20.0),
                                    Text(
                                      'Publishing',
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 12.0 : 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                        height: isSmallScreen ? 5.0 : 10.0),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Text(
                                        'Users can publish articles, job offers and events.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: isSmallScreen ? 6.0 : 14.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
