import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import '../components/constum_componenets/gradientButton.dart';
import '../components/themes/colors.dart';
import './home.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:path/path.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import '../components/constum_componenets/googleButton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../viewmodel/userViewModel.dart';

class Signin2Page extends StatefulWidget {
  static String tag = 'login-page';

  const Signin2Page({super.key});

  @override
  _Signin2PageState createState() => new _Signin2PageState();
}

enum Gender { male, female }

List<String> _level = [
  'First Year',
  'Second Year',
  'Third Year',
  'Fourth Year',
  'Fifth Year',
];

List<String> _speciality = [
  'Tic',
  'Tc',
  'Gc',
  'Ge',
];

List<String> _tcoptions = [
  'First Year',
  'Second Year',
  'Third Year',
  'Fourth Year',
  'Fifth Year',
];

List<String> _gcoptions = [
  'First Year',
  'Second Year',
  'Third Year',
  'Fourth Year',
  'Fifth Year',
];

List<String> _ticoptions = [
  'SIM',
  'TWIN',
  'DS',
  'ARCTIC',
  'INFINI',
  'SAE',
  'SE',
  'ERP-BI',
  'SLEAM',
  'NIDS',
];

List<String> _geoptions = [
  'First Year',
  'Second Year',
  'Third Year',
  'Fourth Year',
  'Fifth Year',
];

class _Signin2PageState extends State<Signin2Page> {
  Gender? selectedGender;
  int? _selectedValue;

  DateTime? _selectedDate;
  String? _selectedLevel;
  String? _selectedSpecialization;
  String? _selectedOption;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primary, // header background color
            accentColor: AppColors.primaryDark, // selection color
            colorScheme: ColorScheme.light(primary: AppColors.primaryDark),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //_userViewModel = UserViewModel(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Container(
      height: 150.0,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 10),
      child: Image.asset("media/logo.png"),
    );
    List<String> _getDropdownItems() {
      switch (_selectedSpecialization) {
        case 'Tic':
          return _ticoptions;

        case 'Tc':
          return _tcoptions;
        case 'Gc':
          return _tcoptions;

        case 'Ge':
          return _tcoptions;

        default:
          return [];
      }
    }

    final signupButton = Container(
      //padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
      width: double.infinity,
      child: gradientButton(
        borderRadius: BorderRadius.circular(30.0),
        width: double.infinity,
        height: 60.0,
        gradient: AppColors.gradient1,
        child: const Text(
          'SIGN UP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23.0,
            fontFamily: 'Mukata Malar',
          ),
        ),
        onPressed: () {},
      ),
    );

    final dateButton = ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(60),
        primary: Colors.white,
        onPrimary: AppColors.primaryDark,
        elevation: 3,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: AppColors.primaryDark, width: 1),
        ),
      ),
      onPressed: () {
        _selectDate(context);
      },
      icon: const Icon(
        Icons.calendar_today,
        color: AppColors.primaryDark,
      ),
      label: const Text('choose date',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.0,
            fontFamily: 'Mukata Malar',
          )),
    );

    final level = DropdownButtonFormField<String>(
      value: _selectedLevel,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: 'Choose your level',
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryDark),
      iconSize: 24,
      isExpanded: true,
      items: _level
          .map((option) => DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedLevel = value;
        });
      },
    );

    final speciality = DropdownButtonFormField<String>(
      value: _selectedSpecialization,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: 'Choose your speciality',
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryDark),
      iconSize: 24,
      isExpanded: true,
      items: _speciality
          .map((option) => DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedSpecialization = value;
        });
      },
    );

    final option = DropdownButtonFormField<String>(
      value: _selectedOption,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: 'Choose your option',
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1,
          ),
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryDark),
      iconSize: 24,
      isExpanded: true,
      items: _getDropdownItems()
          .map((option) => DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedOption = value;
        });
      },
    );

    return Scaffold(
      body: Form(
        key: _keyForm,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 35, 35, 10),
              child: const Text(
                "Genre :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: 0,
                    groupValue: _selectedValue,
                    fillColor: MaterialStateProperty.all(AppColors.primary),
                    onChanged: (int? value) =>
                        setState(() => _selectedValue = value),
                  ),
                  const Text(
                    'Male',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: 1,
                    groupValue: _selectedValue,
                    fillColor: MaterialStateProperty.all(AppColors.primary),
                    onChanged: (value) =>
                        setState(() => _selectedValue = value),
                  ),
                  const Text('Female'),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 20, 35, 20),
              child: const Text(
                "Date of birth :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(80, 0, 80, 20),
              child: dateButton,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 10, 35, 20),
              child: const Text(
                "Level :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(80, 0, 80, 20),
              child: level,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 10, 35, 20),
              child: const Text(
                "Speciality :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(80, 0, 80, 20),
              child: speciality,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 10, 35, 20),
              child: const Text(
                "Option :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(80, 0, 80, 20),
              child: speciality,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 35, 35, 20),
              child: signupButton,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(35, 35, 35, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You have an account ?",
                      style: TextStyle(fontSize: 15)),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    child: const Text("Sign in",
                        style:
                            TextStyle(color: AppColors.primary, fontSize: 15),
                        textAlign: TextAlign.center),
                    onTap: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
