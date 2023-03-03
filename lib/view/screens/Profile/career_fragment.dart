import 'package:flutter/material.dart';

class CareerFragment extends StatefulWidget {
  const CareerFragment({Key? key}) : super(key: key);

  @override
  State<CareerFragment> createState() => _CareerFragmentState();
}

class _CareerFragmentState extends State<CareerFragment> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary statement',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Mukta Malar',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              'Accomplished senior software developer with 15 years of experience in app development.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 10),
          Text(
            'Education',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Mukta Malar',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2),
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
          SizedBox(height: 0.0),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 116.0),
                child: Text(
                  'Speciality :',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[1200],
                  ),
                ),
              ),
              SizedBox(width: 7),
              Text(
                'TIC',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(182, 39, 8, 1.0),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 116.0),
                child: Text(
                  'Option :',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[1200],
                  ),
                ),
              ),
              SizedBox(width: 29),
              Text(
                'SIM',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(182, 39, 8, 1.0),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 10),
          Text(
            'Experience',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Mukta Malar',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              'Senior Software Developer | Boston, MA | June 2012 - Current',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 10),
          Text(
            'Skills',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Mukta Malar',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              '# flutter\n'
              '\n'
                  '# springboot\n'
                  '\n'
              '# .net\n' ,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
  }
