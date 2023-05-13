import 'package:flutter/material.dart';

class DownloadApp extends StatelessWidget {
  const DownloadApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          bool isSmallScreen = screenWidth < 580;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  //height: MediaQuery.of(context).size.height * 0.2,
                  padding:
                      EdgeInsets.only(left: 40, right: 5, top: 15, bottom: 25),
                  child: Text(
                    'Subscribe Now',
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
                    'As an admin, you have a lot on your plate already, by subscribing to this feature, you\'ll get access to valuable insights and data that will help you track your organization\'s progress, identify areas for improvement, and make informed decisions. Don\'t wait - subscribe to the dashboard feature today and take your organization to the next level.',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 18.0 : 25.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 15.0 : 30.0),
                Container(
                  height: 400,
                  width: isSmallScreen ? screenWidth : screenWidth * 0.8,
                  child: Wrap(
                    spacing: 15.0,
                    runSpacing: 15.0,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildSubscriptionCard(
                        'Basic',
                        '\$300/year',
                        'Access to basic features',
                      ),
                      SizedBox(width: 15.0),
                      _buildSubscriptionCard(
                        'Premium',
                        '\$450/year',
                        'Access to premium features',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubscriptionCard(
      String title, String price, String description) {
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
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                price,
                style: TextStyle(
                  fontSize: 20,
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                  onPrimary: Colors.black,
                  elevation: 4,
                  minimumSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Subscribe Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
