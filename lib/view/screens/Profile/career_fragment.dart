import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:esprit_alumni_frontend/model/profile.dart';
import 'package:esprit_alumni_frontend/viewmodel/profileViewModel.dart';
import 'education_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:esprit_alumni_frontend/view/components/constum_componenets/gradientButton.dart';
import 'package:esprit_alumni_frontend/view/components/themes/colors.dart';

class CareerFragment extends StatefulWidget {
  String? summary;
  String? status;
  CareerFragment(this.summary, this.status, {Key? key}) : super(key: key);

  @override
  State<CareerFragment> createState() => _CareerFragmentState();
}

class _CareerFragmentState extends State<CareerFragment> {
// UPDATE FUNCTIONS ---------------------------------------------------------------
  static String baseUrl = "10.0.2.2:8081";
  final token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MDVlMjE4OWI3MTgzODNiYTZlMWJiZiIsImlhdCI6MTY3ODEwNzIyMn0._PZVkfoErOlRj8G5RqSe3nAkh1YkJBHev8drD_8aI5A";
  String _textSummary = '';
  String _textStatus = '';
  // update the summary
  Future<ProfileModel> _updateSummary(String token, String newSummary) async {
    final response = await http.put(
      Uri.http(baseUrl, "/editSummary/$token"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'summary': newSummary}),
    );
    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      final profile = ProfileModel.fromJson(jsonMap);
      if (jsonMap != null) {
        return profile;
      } else {
        throw Exception('Failed to parse profile data');
      }
    } else {
      throw Exception('Failed to update summary');
    }
  }

  // update the status
  Future<ProfileModel> _updateStatus(String token, String newStatus) async {
    final response = await http.put(
      Uri.http(baseUrl, "/editStatus/$token"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': newStatus}),
    );
    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      final profile = ProfileModel.fromJson(jsonMap);
      if (jsonMap != null) {
        return profile;
      } else {
        throw Exception('Failed to parse profile data');
      }
    } else {
      throw Exception('Failed to update summary');
    }
  }

// DIALOGS ---------------------------------------------------------------
// summary edit dialog
  void _showEditDialogSummary() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text('Edit your summary'),
          content: TextField(
            controller: TextEditingController(text: widget.summary),
            decoration: InputDecoration(),
            onChanged: (value) {
              setState(() {
                _textSummary = value;
              });
            },
          ),
          actions: <Widget>[
            Center(
              child: gradientButton(
                borderRadius: BorderRadius.circular(10.0),
                width: 87.0,
                height: 30.0,
                gradient: AppColors.gradient2,
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: 'Mukata Malar',
                  ),
                ),
                onPressed: () async {
                  // Call the _updateSummary function to update the summary on the server
                  await _updateSummary(token, _textSummary);
                  setState(() {
                    widget.summary = _textSummary;
                  });

                  // Close the dialog
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // status edit dialog
  void _showEditDialogStatus() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text('Edit your status'),
          content: TextField(
            controller: TextEditingController(text: widget.status),
            decoration: InputDecoration(),
            onChanged: (value) {
              setState(() {
                _textStatus = value;
              });
            },
          ),
          actions: <Widget>[
            Center(
              child: gradientButton(
                borderRadius: BorderRadius.circular(10.0),
                width: 87.0,
                height: 30.0,
                gradient: AppColors.gradient2,
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: 'Mukata Malar',
                  ),
                ),
                onPressed: () async {
                  // Call the _updateSummary function to update the summary on the server
                  await _updateStatus(token, _textStatus);
                  setState(() {
                    widget.status = _textStatus;
                  });
                  // Close the dialog
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Summary statement',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Mukta Malar',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 90),
              GestureDetector(
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: AppColors.primaryDark,
                    size: 22,
                  ),
                  onPressed: _showEditDialogSummary,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              widget.summary.toString(),
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          Row(
            children: [
              Text(
                'Status',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Mukta Malar',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 212),
              GestureDetector(
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: AppColors.primaryDark,
                    size: 22,
                  ),
                  onPressed: _showEditDialogStatus,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              widget.status.toString(),
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Education',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Mukta Malar',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 175),
              GestureDetector(
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: AppColors.primaryDark,
                    size: 22,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EducationScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Image.asset(
                'Assets/images/esprit_logo.png',
                height: 80,
                width: 110,
              ),
              SizedBox(width: 5),
              Flexible(
                child: Text(
                  'Ecole supérieur privée d\'ingénierie et de technologie',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 10),
          Text(
            'Experience',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Mukta Malar',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              'Senior Software Developer | Boston, MA | June 2012 - Current',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 10),
          Text(
            'Skills',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Mukta Malar',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              '# flutter\n'
              '\n'
              '# springboot\n'
              '\n'
              '# .net\n',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
