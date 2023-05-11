import 'package:esprit_alumni_frontend/view/components/design/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:esprit_alumni_frontend/presentation/theme/palette.dart';
import 'package:esprit_alumni_frontend/presentation/theme/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';

class PopularFields extends StatefulWidget {
  @override
  _PopularFieldsState createState() => _PopularFieldsState();
}

class _PopularFieldsState extends State<PopularFields> {
  late List<charts.Series<JobDataA, String>> _seriesData = [];
  late List<JobDataA> jobDataList = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    const url = 'http://localhost:8081/getJob';
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
    return Container(
      width: 500,
      height: 430,
      padding: const EdgeInsets.fromLTRB(50, 22, 32, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Popular Fields Among Esprit Students',
              style: TextStyles.myriadProSemiBold22DarkBlue,
            ),
            _seriesData == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    height: 500,
                    child: charts.BarChart(
                      _seriesData,
                      animate: true,
                      vertical: false,
                      barGroupingType: charts.BarGroupingType.grouped,
                      barRendererDecorator: charts.BarLabelDecorator<String>(),
                      domainAxis: const charts.OrdinalAxisSpec(
                        renderSpec: charts.NoneRenderSpec(),
                      ),
                      primaryMeasureAxis: const charts.NumericAxisSpec(
                        tickProviderSpec: charts.BasicNumericTickProviderSpec(
                          desiredTickCount: 5,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 30),
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

  /*Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 700,
      padding: const EdgeInsets.fromLTRB(50, 22, 32, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Popular Fields Among Esprit Students',
            style: TextStyles.myriadProSemiBold22DarkBlue,
          ),
        ],
      ),
    );
  }*/
