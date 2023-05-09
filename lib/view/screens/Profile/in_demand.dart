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
        ),
      ];
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 80),
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
          Expanded(
            child: _jobData.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : charts.BarChart(
                    _createChartData(),
                    animate: true,
                    vertical: false,
                  ),
          ),
        ],
      ),
    );
  }
}
