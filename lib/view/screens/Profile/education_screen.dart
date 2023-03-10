import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreen();
}

class _EducationScreen extends State<EducationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'Assets/images/esprit_logo.png',
                  height: 80,
                  width: 110,
                ),
                SizedBox(width: 5),
                Flexible(
                  child: Text(
                    'Ecole supérieur privée d\'ingénierie et de technologie',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
