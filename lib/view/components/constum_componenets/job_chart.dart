import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';

class JobChart extends StatefulWidget {
  @override
  _JobChartState createState() => _JobChartState();
}

class _JobChartState extends State<JobChart> {
  late List<charts.Series<JobDataA, String>> _seriesData = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    const url = 'http://10.0.2.2:8081/getJob';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        _seriesData = [
          charts.Series<JobDataA, String>(
            id: 'Job Data',
            domainFn: (JobDataA data, _) => data.jobTitle,
            measureFn: (JobDataA data, _) => data.percentage,
            data: [
              JobDataA('DevOps', data['devopsPercentage']),
              JobDataA('Full Stack', data['fullStackPercentage']),
              JobDataA('Data Science', data['dataSciencePercentage']),
              JobDataA('Artificial Intelligence', data['aiPercentage']),
              JobDataA('Mobile', data['mobilePercentage']),
              JobDataA('Web', data['webPercentage']),
              JobDataA('Backend', data['backPercentage']),
              JobDataA('Frontend', data['frontPercentage']),
              JobDataA('Software', data['softwarePercentage']),
              JobDataA('Business Intelligence', data['biPercentage']),
            ],
            labelAccessorFn: (JobDataA data, _) =>
                '${data.jobTitle}: ${data.percentage.toStringAsFixed(2)}%',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          ),
        ];
      });
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Chart'),
      ),
      body: _seriesData == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: charts.BarChart(
                _seriesData,
                animate: true,
                vertical: false,
                barRendererDecorator: charts.BarLabelDecorator<String>(),
                domainAxis: const charts.OrdinalAxisSpec(
                  renderSpec: charts.NoneRenderSpec(),
                ),
                primaryMeasureAxis: const charts.NumericAxisSpec(
                  tickProviderSpec: charts.BasicNumericTickProviderSpec(
                    desiredTickCount: 6,
                  ),
                ),
              ),
            ),
    );
  }
}

class JobDataA {
  final String jobTitle;
  final double percentage;

  JobDataA(this.jobTitle, this.percentage);
}
