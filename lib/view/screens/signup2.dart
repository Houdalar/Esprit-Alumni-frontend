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

class _Signin2PageState extends State<Signin2Page> {
  Gender? selectedGender;
  int? _selectedValue;

  late String? _DateOfBirth;
  late String? _speciality;
  late String? _option;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

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
      onPressed: () {},
      icon: const Icon(
        Icons.calendar_today,
        color: AppColors.primaryDark,
      ),
      label: const Text('Sign in with Google',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.0,
            fontFamily: 'Mukata Malar',
          )),
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
                  Text('Female'),
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
              margin: const EdgeInsets.fromLTRB(35, 35, 35, 20),
              child: dateButton,
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
