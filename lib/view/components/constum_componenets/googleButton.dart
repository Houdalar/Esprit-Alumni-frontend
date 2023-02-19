import 'package:flutter/material.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          _isButtonPressed = true;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          _isButtonPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isButtonPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: _isButtonPressed ? Colors.grey[300] : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('media/google-icon.png', height: 24),
            SizedBox(width: 10),
            Text('Sign in with Google'),
          ],
        ),
      ),
    );
  }
}
