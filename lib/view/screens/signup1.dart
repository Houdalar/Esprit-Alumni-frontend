import 'package:esprit_alumni_frontend/view/screens/login.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import '../../socketService.dart';
import '../components/constum_componenets/gradientButton.dart';
import '../components/themes/colors.dart';
import 'Profile/home.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:path/path.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import '../components/constum_componenets/googleButton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../viewmodel/userViewModel.dart';
import 'package:esprit_alumni_frontend/view/screens/signup2.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  _SignupPageState createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? _email;
  String? _password;
  String? _username;
  String? _confirmPassword;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Container(
      height: 150.0,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 10),
      child: Image.asset("media/logo.png"),
    );

    final email = TextFormField(
      onSaved: (String? value) {
        _email = value;
      },
      minLines: 1,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Email',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryDark),
          borderRadius: BorderRadius.circular(32.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(32.0),
        ),
        filled: true,
        fillColor: AppColors.darkwhite,
        prefixIcon: const Icon(
          Icons.email,
          color: AppColors.darkgray,
        ),
      ),
      validator: (value) {
        const String pattern = r'^[a-zA-Z0-9]+.[a-zA-Z0-9]+@esprit\.tn$';
        RegExp regExp = RegExp(pattern);
        if (value == null || value.isEmpty) {
          return 'Please enter an email address';
        }
        if (!EmailValidator.validate(value)) {
          return 'Please enter a valid email address';
        }
        if (!regExp.hasMatch(value)) {
          return 'Please enter an email address from esprit.tn';
        }
        return null;
      },
    );
    final username = TextFormField(
      onSaved: (String? value) {
        _username = value;
      },
      minLines: 1,
      maxLines: 1,
      keyboardType: TextInputType.name,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'username',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryDark),
          borderRadius: BorderRadius.circular(32.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(32.0),
        ),
        filled: true,
        fillColor: AppColors.darkwhite,
        prefixIcon: const Icon(
          Icons.text_fields,
          color: AppColors.darkgray,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
    );
    final password = TextFormField(
      onSaved: (String? value) {
        _password = value;
      },
      minLines: 1,
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      autofocus: true,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'password',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryDark),
          borderRadius: BorderRadius.circular(32.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(32.0),
        ),
        filled: true,
        fillColor: AppColors.darkwhite,
        prefixIcon: const Icon(
          Icons.lock,
          color: AppColors.darkgray,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
    final confirmPassword = TextFormField(
      onSaved: (String? value) {
        _confirmPassword = value;
      },
      minLines: 1,
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      autofocus: true,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'confirm password',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryDark),
          borderRadius: BorderRadius.circular(32.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(32.0),
        ),
        filled: true,
        fillColor: AppColors.darkwhite,
        prefixIcon: const Icon(
          Icons.lock,
          color: AppColors.darkgray,
        ),
      ),
      validator: (value) {
        _keyForm.currentState!.save();
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != _password) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
    final nextButton = Container(
      width: double.infinity,
      child: gradientButton(
        borderRadius: BorderRadius.circular(30.0),
        width: double.infinity,
        height: 60.0,
        gradient: AppColors.gradient1,
        child: const Text(
          'NEXT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23.0,
            fontFamily: 'Mukata Malar',
          ),
        ),
        onPressed: () {
          if (_keyForm.currentState!.validate()) {
            // print the value of all the fields

            _keyForm.currentState!.save();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Signup2Page(_email, _username, _password),
              ),
            );
          }
        },
      ),
    );
    final googleButton = ElevatedButton.icon(
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
        UserViewModel.signupWithGoogle(context);
      },
      icon: Image.asset("media/google-icon.png", height: 24),
      label: const Text('Continue with Google',
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
              height: 200.0,
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: logo,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 0, 35, 20),
              child: email,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 0, 35, 20),
              child: username,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 0, 35, 10),
              child: password,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 10, 35, 20),
              child: confirmPassword,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 35, 35, 20),
              child: nextButton,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(35, 10, 35, 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    child: const Divider(
                      color: Colors.black,
                      height: 30.0,
                    ),
                  ),
                  const Text(
                    '  Or sign up with  ',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(
                    width: 50.0,
                    child: Divider(
                      color: Colors.black,
                      height: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(35, 0, 35, 20),
              child: googleButton,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(35, 0, 35, 10),
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
                    onTap: () {
                      Navigator.pushNamed(context, "/login");
                    },
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
