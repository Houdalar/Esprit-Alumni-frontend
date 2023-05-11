import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:developer';
import 'package:fl_chart/fl_chart.dart';
import 'package:esprit_alumni_frontend/presentation/theme/text_styles.dart';

class GeographicalDistribution extends StatefulWidget {
  const GeographicalDistribution({Key? key}) : super(key: key);

  @override
  State<GeographicalDistribution> createState() =>
      _GeographicalDistributionState();
}

Future<List<Map<String, dynamic>>> fetchData() async {
  final response = await http.get(Uri.parse('http://localhost:8081/GeoDest'));
  log(response.body);
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((item) => item as Map<String, dynamic>).toList();
  } else {
    throw Exception('Failed to load data from API');
  }
}

class _GeographicalDistributionState extends State<GeographicalDistribution> {
  late Future<List<Map<String, dynamic>>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 515,
      width: 500,
      //constraints: const BoxConstraints(maxWidth: 500, minHeight: 270),
      padding: const EdgeInsets.only(top: 31, left: 30, right: 25, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Geographical Distribution of Alumni",
              style: TextStyles.myriadProSemiBold22DarkBlue),
          const SizedBox(height: 10),
          SizedBox(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: PieChartWidget(data: snapshot.data!),
                      ));
                }
              },
            ),
          ),
          /*Wrap(
            spacing: 36,
            runSpacing: 10,
            children: <Widget>[],
          ),*/
        ],
      ),
    );
  }
}

class PieChartWidget extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const PieChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  @override
  Widget build(BuildContext context) {
    final List<Color> chartColors = [
      const Color(0xFF910000),
      const Color(0xFF6B0000),
      const Color.fromARGB(255, 255, 149, 156),
      const Color(0xFFFF3F3D),
      const Color(0xFFFF6B6B),
    ];

    //final total = widget.data.fold(0.0, (sum, item) => item['count']);
    final total = widget.data.fold(0.0, (sum, item) => sum + item['count']);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 4.0),
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 50,
                sections: widget.data.asMap().entries.map((entry) {
                  final color = chartColors[entry.key % chartColors.length];
                  final value = entry.value;

                  return PieChartSectionData(
                    color: color,
                    value: value['count'].toDouble(),
                    title:
                        '${(value['count'] / total * 100).toStringAsFixed(2)}%',
                    radius: 60,
                    titleStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        //// Legend
        Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.data.asMap().entries.map((entry) {
              final color = chartColors[entry.key % chartColors.length];
              final value = entry.value;

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    value['field'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;

  const Indicator({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}


/*return Container(
      constraints: const BoxConstraints(maxWidth: 500, minHeight: 340),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Geographical Distribution of Alumni",
                  style: TextStyles.myriadProSemiBold22DarkBlue),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: 500,
            height: 550,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
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
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _futureData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: PieChartWidget(data: snapshot.data!),
                          ));
                    }
                  },
                ),
              ),
            ),
          ),
          Wrap(
            spacing: 36,
            runSpacing: 10,
            children: <Widget>[],
          ),
        ],
      ),
    );*/