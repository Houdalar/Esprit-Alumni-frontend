import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;
            bool isSmallScreen = screenWidth < 580;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    //height: MediaQuery.of(context).size.height * 0.2,
                    padding: EdgeInsets.only(
                        left: 40, right: 5, top: 15, bottom: 25),
                    child: Text(
                      'Esprit Alumni App: Connect, Collaborate, and Elevate Your Career',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 20.0 : 38.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 181, 28, 17),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 45, right: 40),
                    child: Text(
                      'Welcome to the Esprit Alumni App, a cutting-edge platform , exclusively designed for graduates of the Esprit School of Engineering. Our mission is to foster a strong, vibrant community that facilitates collaboration, professional networking, and career growth. Stay in the loop with the latest news, events, and opportunities while connecting with fellow alumni and accessing valuable career resources - all at your fingertips.',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14.0 : 20.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 15.0 : 30.0),
                  Container(
                    height: 1000,
                    width: isSmallScreen ? screenWidth : screenWidth * 0.8,
                    child: Wrap(
                      spacing: 15.0,
                      runSpacing: 15.0,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildSubscriptionCard(
                            'Assets/images/web_profile.png',
                            'Profile',
                            'Showcase your unique skills and experiences, and let your personality shine!'),
                        SizedBox(width: 15.0),
                        _buildSubscriptionCard(
                          'Assets/images/web_publishing.png',
                          'Publishing',
                          'Share your valuable thoughts, experiences, ideas, job openings, and internships with our thriving community.',
                        ),
                        SizedBox(width: 15.0),
                        _buildSubscriptionCard(
                          'Assets/images/web_chat.png',
                          'Chat',
                          'Establish meaningful connections with Esprit students and alumni in real-time.',
                        ),
                        SizedBox(width: 15.0),
                        _buildSubscriptionCard(
                          'Assets/images/web_statistics.png',
                          'Statistics',
                          'Delve into powerful insights on Esprit Alumni with our geographical distribution, in-demand field analysis, and popular fields within the Esprit community.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(
      String asset, String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          height: 300,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                asset,
                height: 80,
                width: 80,
              ),
              SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
