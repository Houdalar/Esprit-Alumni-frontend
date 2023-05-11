import 'dart:convert';
import 'dart:developer';

import 'package:esprit_alumni_frontend/view/components/design/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GeographicalDistribution extends StatefulWidget {
  const GeographicalDistribution({super.key});

  @override
  State<GeographicalDistribution> createState() =>
      _GeographicalDistributionState();
}

Future<List<Map<String, dynamic>>> fetchData() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8081/GeoDest'));
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 22,
            color: AppColors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: PieChartWidget(data: snapshot.data!));
          }
        },
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

    final total = widget.data.fold(0.0, (sum, item) => sum + item['count']);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: widget.data.asMap().entries.map((entry) {
                final color = chartColors[entry.key % chartColors.length];
                final value = entry.value;

                return PieChartSectionData(
                  color: color,
                  value: value['count'].toDouble(),
                  title:
                      '${(value['count'] / total * 100).toStringAsFixed(2)}%',
                  radius: 100,
                  titleStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.data.asMap().entries.map((entry) {
            final color = chartColors[entry.key % chartColors.length];
            final value = entry.value;

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
                const SizedBox(width: 5),
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
