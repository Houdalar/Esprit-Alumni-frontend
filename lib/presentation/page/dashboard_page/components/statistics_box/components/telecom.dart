import 'package:esprit_alumni_frontend/dummy_data/charts_data.dart';
import 'package:esprit_alumni_frontend/presentation/theme/palette.dart';
import 'package:esprit_alumni_frontend/presentation/theme/text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Telecommunications extends StatelessWidget {
  const Telecommunications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 30, bottom: 30, right: 25),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.network_check,
                  size: 50, color: Color.fromARGB(255, 178, 0, 0)),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  'TELECOMMUNICATIONS',
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
                'Participate in the optimization of communication systems, from research to the design of equipment and services, through network infrastructure management.',
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
