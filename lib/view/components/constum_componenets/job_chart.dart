import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../design/app_colors.dart';

class JobChart extends StatefulWidget {
  @override
  _JobChartState createState() => _JobChartState();
}

class _JobChartState extends State<JobChart> {
  late List<charts.Series<JobDataA, String>> _seriesData = [];
  late List<JobDataA> jobDataList = [];

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

      jobDataList = [
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
      ];

      setState(() {
        _seriesData = [
          charts.Series<JobDataA, String>(
            id: 'Job Data',
            domainFn: (JobDataA data, _) => data.jobTitle,
            measureFn: (JobDataA data, _) => data.percentage,
            data: jobDataList,
            labelAccessorFn: (JobDataA data, _) => '${data.jobTitle}',
            colorFn: (_, __) =>
                charts.ColorUtil.fromDartColor(AppColors.primary),
            seriesColor: charts.MaterialPalette.red.shadeDefault,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _seriesData == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Card(
                    elevation: 10,
                    margin: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 500,
                        child: charts.BarChart(
                          _seriesData,
                          behaviors: [
                            charts.ChartTitle(
                                'Popular fields within esprit alumni \n ',
                                behaviorPosition: charts.BehaviorPosition.top,
                                titleOutsideJustification:
                                    charts.OutsideJustification.middleDrawArea),
                          ],
                          animate: true,
                          vertical: false,
                          barGroupingType: charts.BarGroupingType.grouped,
                          barRendererDecorator:
                              charts.BarLabelDecorator<String>(),
                          domainAxis: const charts.OrdinalAxisSpec(
                            renderSpec: charts.NoneRenderSpec(),
                          ),
                          primaryMeasureAxis: const charts.NumericAxisSpec(
                            tickProviderSpec:
                                charts.BasicNumericTickProviderSpec(
                              desiredTickCount: 5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text('Rank'),
                ),
                DataColumn(
                  label: Text('Job Title'),
                ),
                DataColumn(
                  label: Text('Percentage'),
                ),
              ],
              rows: jobDataList
                  .asMap()
                  .entries
                  .map(
                    (entry) => DataRow(cells: <DataCell>[
                      DataCell(Text((entry.key + 1).toString())), // Rank
                      DataCell(Text(entry.value.jobTitle)), // Job Title
                      DataCell(Text(
                          '${entry.value.percentage.toStringAsFixed(2)}%')), // Percentage
                    ]),
                  )
                  .toList(),
            ),
          ],
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
