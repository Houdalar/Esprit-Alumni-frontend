import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../model/job_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class in_demand extends StatefulWidget {
  in_demand({required this.title});

  final String title;

  @override
  _in_demandState createState() => _in_demandState();
}

class _in_demandState extends State<in_demand> {
  List<JobData> _jobData = [];
  String _selectedCountry = 'tunisia';
  final List<String> _countries = ['tunisia', 'germany', 'netherlands'];

  @override
  void initState() {
    super.initState();
    _getJobData();
  }

  void _getJobData() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8081/getIDF$_selectedCountry'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _jobData =
            List<JobData>.from(data.map((json) => JobData.fromJson(json)));
      });
    } else {
      throw Exception('Failed to load job data');
    }
  }

  void _onCountryChanged(String? country) {
    setState(() {
      _selectedCountry = country!;
      _getJobData();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<JobData, String>> _createChartData() {
      return [
        charts.Series<JobData, String>(
          id: 'Jobs',
          data: _jobData,
          domainFn: (job, _) => job.field,
          measureFn: (job, _) => job.count,
          colorFn: (job, _) =>
              charts.ColorUtil.fromDartColor(AppColors.primary),
          labelAccessorFn: (job, _) => '${job.field}',
        ),
      ];
    }

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
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    DropdownButton<String>(
                      value: _selectedCountry,
                      onChanged: _onCountryChanged,
                      items: _countries.map((String country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              _jobData.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            height: 400,
                            child: charts.BarChart(
                              _createChartData(),
                              behaviors: [
                                charts.ChartTitle('In Demand Fields',
                                    behaviorPosition:
                                        charts.BehaviorPosition.top,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                              ],
                              animate: true,
                              vertical: false,
                              barRendererDecorator:
                                  charts.BarLabelDecorator<String>(
                                      labelPosition:
                                          charts.BarLabelPosition.inside
                                      // set the

                                      ),
                              domainAxis: const charts.OrdinalAxisSpec(
                                  renderSpec: charts.NoneRenderSpec()),
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('Field Name'),
                  ),
                  DataColumn(
                    label: Text('Rank'),
                  ),
                  DataColumn(
                    label: Text('Value'),
                  ),
                ],
                rows: _jobData
                    .asMap()
                    .entries
                    .map((entry) => DataRow(cells: <DataCell>[
                          DataCell(Text(entry.value.field)),
                          DataCell(Text((entry.key + 1).toString())),
                          DataCell(Text("${entry.value.count}k")),
                        ]))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
