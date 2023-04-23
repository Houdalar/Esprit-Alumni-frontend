import 'package:flutter/material.dart';
import '../components/constum_componenets/gradientButton.dart';
import '../components/themes/colors.dart';

class GetStartedPage extends StatelessWidget {
  final logo = SizedBox(
    height: 200.0,
    width: double.infinity,
    child: Image.asset("media/logo.png"),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 10),
              child: logo,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 2, 40, 10),
              child: gradientButton(
                borderRadius: BorderRadius.circular(30.0),
                width: double.infinity,
                height: 60.0,
                gradient: AppColors.gradient1,
                child: const Text(
                  'SIGN IN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23.0,
                    fontFamily: 'Mukata Malar',
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
