import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:esprit_alumni_frontend/presentation/theme/text_styles.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

import './job_data.dart';

class in_demand extends StatefulWidget {
  in_demand({Key? key}) : super(key: key);

  //final String title;

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
        .get(Uri.parse('http://localhost:8081/getIDF$_selectedCountry'));

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
          colorFn: (job, _) => charts.ColorUtil.fromDartColor(Colors.red),
          labelAccessorFn: (job, _) => '${job.count}',
        ),
      ];
    }

    return Container(
      height: 515,
      width: 650,
      //constraints: const BoxConstraints(maxWidth: 500, minHeight: 270),
      padding: const EdgeInsets.only(top: 31, left: 30, right: 10, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Most In-Demand Fields",
                    style: TextStyles.myriadProSemiBold22DarkBlue),
                const SizedBox(width: 40),
                Container(
                  width: 110,
                  height: 35,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: DropdownButton<String>(
                      value: _selectedCountry,
                      onChanged: _onCountryChanged,
                      items: _countries.map((String country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _jobData.isEmpty
                // na7i padding w card
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 400,
                      child: charts.BarChart(
                        _createChartData(),
                        animate: true,
                        vertical: false,
                        barRendererDecorator:
                            charts.BarLabelDecorator<String>(),
                        domainAxis: const charts.OrdinalAxisSpec(
                            renderSpec: charts.NoneRenderSpec()),
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
                        DataCell(Text(entry.value.count.toString())),
                      ]))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
