import 'package:flutter/material.dart';

class CivilEngineering extends StatelessWidget {
  const CivilEngineering({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 30, bottom: 30, right: 25),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.construction_outlined,
                  size: 50, color: Color.fromARGB(255, 178, 0, 0)),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  'CIVIL ENGINEERING',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mukta Malar',
                      color: Color.fromARGB(255, 178, 0, 0)),
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Work on designing new structures, assessing the safety and stability of existing structures, and developing plans to manage environmental risks.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Mukta Malar',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
